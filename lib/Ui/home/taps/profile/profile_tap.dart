import 'package:evently_app/Ui/home/taps/profile/language/language_bottom_sheet.dart';
import 'package:evently_app/Ui/home/taps/profile/theme/theme_bottom_sheet.dart';
import 'package:evently_app/Ui/home/taps/widgets/custom_elevated_button.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../providers/user_provider.dart';
class ProfileTap extends StatefulWidget{
  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
   return Scaffold(
     appBar: AppBar(
       shape:RoundedRectangleBorder(
         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))
       ) ,
       toolbarHeight: height*.16,
       title: Row(children: [
         Image(image: AssetImage(AppAssets.appbarImage)),
         SizedBox(width: width*.04,)
         ,Column(crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           Text(userProvider.currentUser!.name,style: AppStyles.bold24white,),
           Text(userProvider.currentUser!.email,style: AppStyles.med16white,)
         ],)
         
       ],),
       backgroundColor: AppColors.primaryColor,
     ),
     body:Padding(
       padding:EdgeInsets.all(width*.04),
       child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           Text(AppLocalizations.of(context)!.language
           ,style:
             Theme.of(context).textTheme.headlineLarge,),
           Container(padding: EdgeInsets.symmetric(vertical: height*.013,horizontal: width*.02),
               margin: EdgeInsets.symmetric(vertical: height*.02),
               decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(16),
             border: Border.all(width: 3,color: AppColors.primaryColor),
           ),child:InkWell(
                 onTap: (){
                   showLanguageBottomSheet();
                 },
             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(languageProvider.appLanguage=='en'?
                 AppLocalizations.of(context)!.english:AppLocalizations.of(context)!.arabic
                     ,style: AppStyles.bold20primary),
               Icon(Icons.arrow_drop_down_outlined,color: AppColors.primaryColor,size: 35,)
               ],
             ),
           ))
           , Text(AppLocalizations.of(context)!.theme
             ,style:
             Theme.of(context).textTheme.headlineLarge,),
           Container(padding: EdgeInsets.symmetric(vertical: height*.013,horizontal: width*.02),
               margin: EdgeInsets.symmetric(vertical: height*.02),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(16),
                 border: Border.all(width: 3,color: AppColors.primaryColor),
               ),child:InkWell(
                 onTap: (){
                   showThemeBottomSheet();
                 },
                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(themeProvider.appTheme==ThemeMode.light?
                     AppLocalizations.of(context)!.light:AppLocalizations.of(context)!.dark
                         ,style: AppStyles.bold20primary),
                     Icon(Icons.arrow_drop_down_outlined,color: AppColors.primaryColor,size: 35,)
                   ],
                 ),
               )),Spacer(),
           Padding(
             padding:  EdgeInsets.symmetric(vertical: height*.02),
             child: CustomElevatedButton(onPressed:(){

               Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginRouteName, (route)=>false);
             },
                 mainAxisAlignment:MainAxisAlignment.start,backgroundColorButton: AppColors.redColor,
               icon: true,colorSide: AppColors.redColor,iconPadding: .03,
               iconName: AppAssets.logoutIcon,textStyle: AppStyles.reg20white,text: AppLocalizations.of(context)!.logout),
           )

         ],
       ),
     ),
   );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(context:context,
        builder:(context) => LanguageBottomSheet()
    );
  }
  void showThemeBottomSheet() {
    showModalBottomSheet(context:context,
        builder:(context) => ThemeBottomSheet()
    );
  }

}

/*
ElevatedButton(style: ElevatedButton.styleFrom(
             padding:EdgeInsets.symmetric(vertical: height*.015,horizontal: width*.04) ,
             backgroundColor: AppColors.redColor,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16)
             )
           ),onPressed: () {},
           child: Row(
             children: [
               Icon(Icons.logout,color: AppColors.whiteColor,size: 25,),
               SizedBox(width: width*.02,),
               Text(AppLocalizations.of(context)!.logout,style: AppStyles.reg20white),
             ],
           ),)
 */