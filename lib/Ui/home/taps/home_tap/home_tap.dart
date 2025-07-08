import 'package:evently_app/Ui/home/taps/home_tap/event_tap_item.dart';
import 'package:evently_app/Ui/home/taps/home_tap/widget/event_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_theme_provider.dart';

class HomeTap extends StatefulWidget{
  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    List<String> eventNameList=[
      AppLocalizations.of(context)!.all,
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
            Text('John Safwat',style: AppStyles.bold24white,)
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
          ],),DefaultTabController(length: eventNameList.length, child:
          TabBar(
            isScrollable: true,
              tabAlignment:TabAlignment.start ,
              indicatorColor: AppColors.transparentColor,
              labelPadding: EdgeInsets.zero,
              dividerColor: AppColors.transparentColor,
              onTap: (index){
             selectedIndex=index;
             setState(() {
             });
            }
          , tabs:eventNameList.map((eventName) {
            return EventTapItem(isSelected:selectedIndex==eventNameList.indexOf(eventName) , text: eventName);
          },).toList()
          ))
        ],),
      ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.only(top: height*.02),
              itemBuilder: (context, index) {
                return EventItem();
              }
              , separatorBuilder: (context, index) {
                return SizedBox(height: height*.001,);              },
              itemCount: 20))
        ],
      ),
    );
  }
}