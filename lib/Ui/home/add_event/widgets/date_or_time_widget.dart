import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_theme_provider.dart';

class DateOrTimeWidget extends StatelessWidget {

String iconName;
String text;
String? text2;
VoidCallback onButtonClick;
DateOrTimeWidget({ required this.iconName ,required this.text,this.text2,required this.onButtonClick});
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image(image: AssetImage(iconName),color:themeProvider.appTheme==ThemeMode.light?AppColors.blackColor:AppColors.whiteColor ,),
       SizedBox(width: width*.02,),
        Text(text,style: themeProvider.appTheme==ThemeMode.light? AppStyles.med16black:AppStyles.med16white),
        Spacer(),
        TextButton(onPressed: (){
          onButtonClick();
        },child:Text(text2!,style:AppStyles.med16primary)),
      ],);
  }
}
