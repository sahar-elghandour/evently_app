import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class ThemeBottomSheet extends StatefulWidget{
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
   return Padding(
     padding:  EdgeInsets.all(width*.07),
     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         InkWell(onTap: (){
           themeProvider.changeTheme(ThemeMode.light);
         },
           child:themeProvider.appTheme==ThemeMode.light?
           getSelectedThemeItem(textTheme: AppLocalizations.of(context)!.light):
     getUnSelectedThemeItem(textTheme: AppLocalizations.of(context)!.light),
         )
         ,SizedBox(height: height*.02,)
    ,InkWell(onTap: (){
           themeProvider.changeTheme(ThemeMode.dark);
         },
             child:themeProvider.appTheme==ThemeMode.dark?
    getSelectedThemeItem(textTheme: AppLocalizations.of(context)!.dark):
    getUnSelectedThemeItem(textTheme: AppLocalizations.of(context)!.dark),
         )],
     ),
   );
  }

  Widget getSelectedThemeItem({required String textTheme}){
   return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textTheme,style: AppStyles.bold20primary,),
        Icon(Icons.check,color: AppColors.primaryColor,)
      ],);
  }
  Widget getUnSelectedThemeItem({required String textTheme}){
    return  Text(textTheme,
      style: AppStyles.bold20black,);
  }


}