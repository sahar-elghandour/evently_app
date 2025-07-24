
import 'package:evently_app/Ui/home/add_event/widgets/date_or_time_widget.dart';
import 'package:evently_app/Ui/home/taps/home_tap/event_tap_item.dart';
import 'package:evently_app/Ui/home/taps/widgets/custom_elevated_button.dart';
import 'package:evently_app/Ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';
import '../../../providers/event_list_provider.dart';
import '../../../utils/dialog_utils.dart';
class AddEvent extends StatefulWidget {
  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex=0;
  TextEditingController addEventController= TextEditingController();
  TextEditingController descriptionController= TextEditingController();
  DateTime? selectedDate;
   String? formatedDate;
   String? formatedTime;
  TimeOfDay? selectedTime;
  String selectedImage = '';
  String selectedDarkImage = '';
  String selectedEventName = '';
  LatLng? selectedLocation;
  String? selectedLocationName;
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
     eventListProvider=Provider.of<EventListProvider>(context);
    List<String> eventNameList=[
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
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
    List<String> eventDarkImageList=[
      AppAssets.sportDarkImage,
      AppAssets.birthdayDark,
      AppAssets.meetingDarkImage,
      AppAssets.gamingDarkImage,
      AppAssets.workShopDarkImage,
      AppAssets.bookClubDarkImage,
      AppAssets.exhibitionDarkImage,
      AppAssets.holidayDarkImage,
      AppAssets.eatingDarkImage,

    ];
    selectedImage = eventImageList[selectedIndex];
    selectedDarkImage=eventDarkImageList[selectedIndex];
    selectedEventName=eventNameList[selectedIndex];

    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(
          color: AppColors.primaryColor
        ),
        title: Text(AppLocalizations.of(context)!.create_event,style: AppStyles.med20primary,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.02),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: double.infinity,
                height: height*.24,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(image: AssetImage(themeProvider.appTheme==ThemeMode.light? selectedImage:selectedDarkImage),fit: BoxFit.fill,),
                ),
              ),SizedBox(height: height*.02,)
              ,SizedBox(
                height: height*.03,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      selectedIndex=index;
                      setState(() {
                      });
                    },
                    child: EventTapItem(isSelected: selectedIndex==index, selectedBgColor: AppColors.primaryColor,text: eventNameList[index],
                    borderColor: AppColors.primaryColor,selectedText: themeProvider.appTheme==ThemeMode.light?AppStyles.med16white:AppStyles.med16black,unSelectedText: AppStyles.med16primary),
                  );
                },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width*.02,);
                    },
                    itemCount:eventNameList.length ),
              )
              ,SizedBox(height: height*.02,),
              Text(AppLocalizations.of(context)!.title,style: Theme.of(context).textTheme.titleLarge),
               SizedBox(height: height*.02,),
              CustomTextFormField(controller: addEventController,prefixIcon:Image(image: AssetImage(AppAssets.eventTitleIcon)),hintText: AppLocalizations.of(context)!.event_title,hintStyle: themeProvider.appTheme==ThemeMode.light?AppStyles.med16grey:AppStyles.med16white,borderSideColor:themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.primaryColor ,)
              ,SizedBox(height: height*.02,),
              Text(AppLocalizations.of(context)!.description,style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: height*.02,),
              CustomTextFormField(controller: descriptionController,hintText: AppLocalizations.of(context)!.event_description,maxLines: 4,hintStyle: themeProvider.appTheme==ThemeMode.light?AppStyles.med16grey:AppStyles.med16white,borderSideColor:themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.primaryColor ,)
            ,SizedBox(height: height*.02,)
              ,DateOrTimeWidget(onButtonClick:chooseDate,iconName: AppAssets.dateIcon, text: AppLocalizations.of(context)!.event_date,
                  text2:selectedDate == null ? AppLocalizations.of(context)!.choose_date:
              //'${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}'
              formatedDate
              )
              ,DateOrTimeWidget(onButtonClick:chooseTime,iconName: AppAssets.timeIcon, text: AppLocalizations.of(context)!.event_time,text2: selectedTime==null? AppLocalizations.of(context)!.choose_time:formatedTime)
              ,SizedBox(height: height*.02,)
              ,Text(AppLocalizations.of(context)!.location,style: Theme.of(context).textTheme.titleLarge),
             SizedBox(height: height*.02,),
              CustomElevatedButton(onPressed: (){},
                text: selectedLocationName == null
                    ? AppLocalizations.of(context)!.choose_event_location
                    : selectedLocationName!,
                textStyle: AppStyles.med16primary,icon: true,iconName: AppAssets.locationIcon
                ,iconPadding:.02,backgroundColorButton: AppColors.transparentColor,colorSide: AppColors.primaryColor,suffixIconName: Icons.arrow_forward_ios,mainAxisAlignment: MainAxisAlignment.start,space: .22,)
              ,SizedBox(height: height*.02,)
              , CustomElevatedButton(onPressed: (){
                addEvent();
              },text: AppLocalizations.of(context)!.add_event,)
            ],
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

  void chooseTime() async{
    var chooseTime = await showTimePicker(context: context,
        initialTime: TimeOfDay.now());
    if(chooseTime !=null){
      selectedTime=chooseTime;
      formatedTime= selectedTime!.format(context);
    }
    setState(() {

    });

  }

  void addEvent() {
    if (selectedDate == null || selectedTime == null) {
      DialogUtils.showMsg(
        context: context,
        title: 'Incomplete Information',
        msg: 'Please choose both date and time for the event.',
        posActionName: 'OK',
      );
      return;
    }
    Event event =Event(
        title: addEventController.text,
        eventName: selectedEventName,
        dateTime: selectedDate!,
        image: selectedImage,
        darkImage:selectedDarkImage ,
        description: descriptionController.text,
        time: formatedTime!,

    );
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    FirebaseUtils.addEventToFirestore
      (event,userProvider.currentUser!.id)
        .then((value){
      ToastUtils.toastMsg(msg: "event added successfully",
          color: AppColors.primaryColor,
          textColor: AppColors.whiteColor);
      Navigator.pop(context,true);

    })
        .timeout(Duration(milliseconds: 500),
    onTimeout: (){
     // print('event added successfully');
      //Navigator.pop(context);
     ToastUtils.toastMsg(msg: "event added successfully", color: AppColors.primaryColor, textColor: AppColors.whiteColor);
     //Navigator.pop(context,true);

    }
    );
  }
}
