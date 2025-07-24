import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/app_colors.dart';
class CustomElevatedButton extends StatelessWidget {
  VoidCallback? onPressed;
  String? text;
  Color? backgroundColorButton;
  Color? colorSide;
  TextStyle? textStyle;
  bool icon;
  String? iconName;
  MainAxisAlignment? mainAxisAlignment;
  num iconPadding;
  IconData? suffixIconName;
   double space ;
  String? text2;
  bool istext2;
   CustomElevatedButton({super.key,this.onPressed,this.text,this.istext2=false,
     this.backgroundColorButton=AppColors.primaryColor,this.text2,
     this.colorSide,this.space =.01,this.textStyle,this.iconPadding=0,this.suffixIconName,this.icon=false,this.iconName,this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    return ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: height*.017),
          elevation: 0,
          backgroundColor:backgroundColorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              width: 2,
              color: colorSide ??AppColors.primaryColor
            )
          )
        ),
        child:icon?Row(mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: width*iconPadding),
            child: Image(image: AssetImage(iconName!)),
          ),
          SizedBox(width: width*.02,),
          istext2?
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text!,style:textStyle ?? AppStyles.med20white ,),
              Text(text2??'',style: AppStyles.bold14black ,),
            ],
          ):Text(text!,style:textStyle ?? AppStyles.med20white ,),
            SizedBox(width: width* space )
            ,Icon(suffixIconName,color: AppColors.primaryColor,)
        ],):
        Text(text!,style:textStyle ?? AppStyles.med20white ,)
    );
  }
}
