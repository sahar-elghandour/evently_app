import 'package:evently_app/Ui/home/taps/widgets/custom_elevated_button.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils.dart';
import '../../../model/event.dart';
import '../../../providers/event_list_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/toast_utils.dart';
import '../edit_event/edit_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home_screen.dart';
import '../taps/home_tap/home_tap.dart';
class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late Event event;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    event=widget.event;
  }
  @override
  Widget build(BuildContext context) {
   var eventListProvider=Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(
            color: AppColors.primaryColor
        ),
        title: Text(AppLocalizations.of(context)!.event_details,style: AppStyles.med20primary,),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
    onPressed: () async {
      var result = await Navigator.of(context).pushNamed(
        AppRoutes.editEventRouteName,
        arguments: event,
      );
      if (result == true) {
        eventListProvider.getALLEvents(userProvider.currentUser!.id);
      }
      }),
          IconButton(
            icon: Icon(Icons.delete,color: AppColors.redColor,),
            onPressed: () {

              deleteEvent();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              height: height * 0.24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(widget.event.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            Text(
              widget.event.title,
              style: AppStyles.bold20primary,
            ),SizedBox(height: height * 0.02),
            CustomElevatedButton(onPressed: (){},iconName: AppAssets.datetime,istext2: true
              ,text: '${DateFormat('dd MMMM yyyy').format(widget.event.dateTime)} '
              ,text2:' ${widget.event.time}',textStyle: AppStyles.med16primary,icon: true,
              iconPadding:.02,backgroundColorButton: AppColors.transparentColor,colorSide: AppColors.primaryColor,mainAxisAlignment: MainAxisAlignment.start,space: .22,
            ), SizedBox(height: height * 0.02),
            CustomElevatedButton(onPressed: (){},

              text: "cairo,Egypt",
              textStyle: AppStyles.med16primary,icon: true,iconName: AppAssets.locationIcon
              ,iconPadding:.02,backgroundColorButton: AppColors.transparentColor,colorSide: AppColors.primaryColor,suffixIconName: Icons.arrow_forward_ios,mainAxisAlignment: MainAxisAlignment.start,space: .4,)
            ,SizedBox(height: height*.02,),
      Text(AppLocalizations.of(context)!.description,style: AppStyles.bold14black,),
            SizedBox(height: height*.01,),
            Text(
              widget.event.description,
              style:AppStyles.bold14black,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
  Future<void> deleteEvent() async {
    final userId=Provider.of<UserProvider>
      (context,listen: false).currentUser!.id;

    await FirebaseUtils.getEventCollection(userId)
        .doc(widget.event.id).delete();

    ToastUtils.toastMsg(msg: 'event deleted successfully',
        color: AppColors.primaryColor,
        textColor: AppColors.whiteColor);
    await Provider.of<EventListProvider>(context,listen: false).getALLEvents(userId);
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.homeRouteName, (route)=>false);
  }
}