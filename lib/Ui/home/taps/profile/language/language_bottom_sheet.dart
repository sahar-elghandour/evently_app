import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
class LanguageBottomSheet extends StatefulWidget{
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
   return Padding(
     padding:  EdgeInsets.all(width*.07),
     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         InkWell(onTap: (){
           languageProvider.changeLanguage('en');
         },
           child:languageProvider.appLanguage=='en'?
           getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english):
     getUnSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.english),
         )
         ,SizedBox(height: height*.02,)
    ,InkWell(onTap: (){
           languageProvider.changeLanguage('ar');
         },
             child:languageProvider.appLanguage=='ar'?
    getSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic):
    getUnSelectedLanguageItem(textLanguage: AppLocalizations.of(context)!.arabic),
         )],
     ),
   );
  }

  Widget getSelectedLanguageItem({required String textLanguage}){
   return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textLanguage,style: AppStyles.bold20primary,),
        Icon(Icons.check,color: AppColors.primaryColor,)
      ],);
  }
  Widget getUnSelectedLanguageItem({required String textLanguage}){
    return  Text(textLanguage,
      style: AppStyles.bold20black,);
  }


}