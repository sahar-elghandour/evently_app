import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../model/event.dart';
import '../../../../../providers/app_theme_provider.dart';
import '../../../../../providers/event_list_provider.dart';
import '../../../event_details/event_details.dart';

class EventItem extends StatefulWidget{
  Event event;
  EventItem({required this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider=Provider.of<EventListProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
   return GestureDetector(
        onTap: () async {

      final updatedEvent = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EventDetails(event: widget.event),
        ),
      );

      if (updatedEvent != null && updatedEvent is Event) {
        setState(() {
          eventListProvider.updateEvent(updatedEvent,userProvider.currentUser!.id);
        });
      }


    },
     child: Container(
       margin: EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.01),
       height: height*.27,
       decoration: BoxDecoration(
         image: DecorationImage(image: AssetImage(themeProvider.appTheme==ThemeMode.light? widget.event.image:widget.event.darkImage
         ),fit: BoxFit.fill),
         borderRadius: BorderRadius.circular(16),
       ),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Container(
           margin: EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.01),
           padding: EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.0001),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(8),
           color: AppColors.whiteBgColor
         ),child: Column(children: [
           Text('${widget.event.dateTime.day}',style: AppStyles.bold20primary),
           Text(DateFormat('MMM').format(widget.event.dateTime),style: AppStyles.bold14primary,)
         ],),
         ),
         Container(alignment: Alignment.bottomCenter,
           margin: EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.01),
           padding: EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.0001),
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: AppColors.whiteBgColor
           ),child: Row(
           children: [
           Expanded(child: Text(widget.event.title,
               style: AppStyles.bold14black)),
           IconButton(onPressed: (){
             widget.event.isFavorite=!widget.event.isFavorite;
             eventListProvider.updateIsfav(widget.event,userProvider.currentUser!.id);
           }, icon:Image( image:widget.event.isFavorite ==true ? AssetImage(AppAssets.favFill):AssetImage(AppAssets.favBorder)))],),
         )
     ],),

     ),
   );

  }
}