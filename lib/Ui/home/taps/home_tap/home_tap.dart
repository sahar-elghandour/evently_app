import 'package:evently_app/Ui/home/taps/home_tap/event_tap_item.dart';
import 'package:evently_app/Ui/home/taps/home_tap/widget/event_item.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_theme_provider.dart';
import '../../../../providers/user_provider.dart';

class HomeTap extends StatefulWidget{
  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  late EventListProvider eventListProvider;


  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
   eventListProvider=Provider.of<EventListProvider>(context);
    //if(eventListProvider.eventList.isEmpty){
     // eventListProvider.getALLEvents(userProvider.currentUser!.id);
    //}
   eventListProvider.getEventNameList(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color:themeProvider.appTheme== ThemeMode.dark ? AppColors.primaryColor:
            AppColors.whiteColor),
        title: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(AppLocalizations.of(context)!.welcome_back,style: AppStyles.reg16white,),
            Text(userProvider.currentUser!.name,style: AppStyles.bold24white,)
          ],),Spacer(),
          IconButton(onPressed: (){}, icon:Image.asset(AppAssets.themeIcon)),
          Container(padding: EdgeInsets.symmetric(horizontal: width*.016,vertical: height*.008),
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColor
          ),
            child:  Text('EN',style: Theme.of(context).textTheme.headlineSmall,))

        ],),bottom: AppBar(
        iconTheme: IconThemeData(
            color:themeProvider.appTheme== ThemeMode.dark ? AppColors.primaryColor:
            AppColors.whiteColor),
        toolbarHeight: height*.088,
        title: Column(children: [
          Row(children: [
            ImageIcon(AssetImage(AppAssets.unSelectedMapIcon,),size:40),
            Text('Cairo,Egypt',style: AppStyles.med16white,)
          ],),DefaultTabController(length: eventListProvider.eventNameList.length, child:
          TabBar(
            isScrollable: true,
              tabAlignment:TabAlignment.start ,
              indicatorColor: AppColors.transparentColor,
              labelPadding: EdgeInsets.zero,
              dividerColor: AppColors.transparentColor,
              onTap: (index){
            eventListProvider.changeSelectedIndex(index,userProvider.currentUser!.id);
            }
          , tabs:eventListProvider.eventNameList.map((eventName) {
            return EventTapItem(isSelected:eventListProvider.selectedIndex==eventListProvider.eventNameList.indexOf(eventName) ,
              text: eventName,selectedBgColor: Theme.of(context).focusColor,
              selectedText: Theme.of(context).textTheme.headlineMedium,
              unSelectedText:Theme.of(context).textTheme.titleMedium,);
          },).toList()
          ))
        ],),
      ),
      ),
      body: Column(
        children:[
          Expanded(
              child: eventListProvider.filterEventList.isEmpty?
            Center(child: Text("No events added"),): 
         ListView.separated(
                  padding: EdgeInsets.only(top: height*.02),
              itemBuilder: (context, index) {
                return EventItem(event:eventListProvider.filterEventList[index] ,);
              }
              , separatorBuilder: (context, index) {
                return SizedBox(height: height*.001,);              },
              itemCount: eventListProvider.filterEventList.length))
        ],
      ),
    );
  }
}