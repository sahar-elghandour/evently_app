import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils.dart';
import '../../../model/event.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../providers/event_list_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/toast_utils.dart';
import '../add_event/widgets/date_or_time_widget.dart';
import '../taps/home_tap/event_tap_item.dart';
import '../taps/home_tap/home_tap.dart';
import '../taps/widgets/custom_elevated_button.dart';
import '../taps/widgets/custom_text_form_field.dart';


class EditEvent extends StatefulWidget {
  final Event event;

  const EditEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEvent> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  String? locationName;
  int selectedIndex = 0;
  DateTime? selectedDate;
  String? formatedDate;
  String? formatedTime;
  TimeOfDay? selectedTime;
  late String selectedImage;
  late Event event;
  late EventListProvider eventListProvider;
  @override
  void initState() {
    super.initState();

    event = widget.event;

    nameController = TextEditingController(text: event.title);
    descriptionController = TextEditingController(text: event.description);

    selectedDate = event.dateTime;
    selectedTime =parseTime(event.time);
        //TimeOfDay.fromDateTime(event.dateTime);
    selectedIndex = eventImageList.indexOf(event.image);
  }
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


  List<String> eventImageList=[
    AppAssets.sportImage,
    AppAssets.birthdayImage,
    AppAssets.meetingImage,
    AppAssets.gamingImage,
    AppAssets.workShopImage,
    AppAssets.bookClubImage,
    AppAssets.exhibitionImage,
    AppAssets.holidayImage,
    AppAssets.eatingImage,

  ];



  @override
  Widget build(BuildContext context) {
    eventListProvider=Provider.of<EventListProvider>(context);
    List<String> eventNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];

    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(
            color: AppColors.primaryColor
        ),
        title: Text(AppLocalizations.of(context)!.edit_event, style: AppStyles.med20primary,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: height * 0.24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(eventImageList[selectedIndex]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                    height: height * .02),
                SizedBox(
                  height: height * .03,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: EventTapItem(isSelected: selectedIndex ==
                              index,
                              selectedBgColor: AppColors.primaryColor,
                              text: eventNameList[index],
                              borderColor: AppColors.primaryColor,
                              selectedText: themeProvider.appTheme ==
                                  ThemeMode.light
                                  ? AppStyles.med16white
                                  : AppStyles.med16black,
                              unSelectedText: AppStyles.med16primary),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: width * .02,);
                      },
                      itemCount: eventNameList.length),
                ), SizedBox(height: height * .02,),
                Text(AppLocalizations.of(context)!.title, style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
                SizedBox(height: height * .02,),

                CustomTextFormField(
                  controller: nameController,
                  prefixIcon: Image(
                      image: AssetImage(AppAssets.eventTitleIcon)),
                  hintText: AppLocalizations.of(context)!.event_title,
                  hintStyle: themeProvider.appTheme == ThemeMode.light
                      ? AppStyles.med16grey
                      : AppStyles.med16white,
                  borderSideColor: themeProvider.appTheme == ThemeMode.light
                      ? AppColors.greyColor
                      : AppColors.primaryColor,)
                , SizedBox(height: height * .02,),

                Text(AppLocalizations.of(context)!.description, style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
                SizedBox(height: height * .02,),
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: AppLocalizations.of(context)!.event_description,
                  maxLines: 4,
                  hintStyle: themeProvider.appTheme == ThemeMode.light
                      ? AppStyles.med16grey
                      : AppStyles.med16white,
                  borderSideColor: themeProvider.appTheme == ThemeMode.light
                      ? AppColors.greyColor
                      : AppColors.primaryColor,)
                , SizedBox(height: height * .02,),

                DateOrTimeWidget(
                  onButtonClick: pickDate,
                  iconName: AppAssets.dateIcon,
                  text: AppLocalizations.of(context)!.event_date,
                  text2: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : DateFormat('dd/MM/yyyy').format(selectedDate!),
                ),

                DateOrTimeWidget(
                  onButtonClick: pickTime,
                  iconName: AppAssets.timeIcon,
                  text: AppLocalizations.of(context)!.event_time,
                  text2: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : selectedTime!.format(context),
                ),
                Text(AppLocalizations.of(context)!.location, style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
                SizedBox(height: height * .02,),
                CustomElevatedButton(
                  onPressed: () {},
                  text: 'cairo,Egypt',
                  textStyle: AppStyles.med16primary,
                  icon: true,
                  iconName: AppAssets.locationIcon
                  ,
                  iconPadding: .02,
                  backgroundColorButton: AppColors.transparentColor,
                  colorSide: AppColors.primaryColor,
                  suffixIconName: Icons.arrow_forward_ios
                  ,
                  mainAxisAlignment: MainAxisAlignment.start,
                  space: .4,)
                , SizedBox(height: height * .02,),
                CustomElevatedButton(
                  onPressed:(){
                    saveChanges();
                    }, text: AppLocalizations.of(context)!.update_event,)
                ,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var choosedate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = choosedate;
    if (choosedate != null) {
      formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      setState(() {

      });
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(context: context,
        initialTime: TimeOfDay.now());
    if (chooseTime != null) {
      selectedTime = chooseTime;
      formatedTime = selectedTime!.format(context);
    }
    setState(() {

    });
  }

  TimeOfDay? parseTime(String timeString) {
    final format = DateFormat.jm();
    final dt = format.parse(timeString);
    return TimeOfDay.fromDateTime(dt);
  }

  String _formatDate(DateTime? date) {
    return date == null ? "Choose date" : DateFormat('dd/MM/yyyy').format(date);
  }

  void pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  void pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  void saveChanges() async {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    try {
      final updatedEvent = widget.event.copyWith(
        eventName: eventListProvider.eventNameList[selectedIndex+1],
        description: descriptionController.text,
        dateTime: selectedDate!,
        time: selectedTime!.format(context),
        locationName: locationName,
        image: eventImageList[selectedIndex],
        title: nameController.text,
      );

      final userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;

      await Provider.of<EventListProvider>(context, listen: false)
          .updateEvent(updatedEvent, userId);
      Provider.of<EventListProvider>(context, listen: false)
          .changeSelectedIndex(0, userId);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.homeRouteName, (route) => false);
    } catch (e) {
      print('Error in saveChanges: $e');
    }
  }

}
