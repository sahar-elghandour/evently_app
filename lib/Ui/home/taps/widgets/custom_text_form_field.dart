import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/app_colors.dart';
typedef OnValidator = String? Function(String?)?;
class  CustomTextFormField extends StatelessWidget {
  Color borderSideColor;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? kerboardType;
  OnValidator validator;
  TextEditingController? controller;
  bool? obscureText;
  String? obscuringCharacter;
  int? maxLines;
   CustomTextFormField ({super.key,this.borderSideColor=AppColors.greyColor,
     this.prefixIcon,this.suffixIcon,this.hintText,this.hintStyle,
     this.labelText,this.labelStyle,this.kerboardType,this.validator,
     required this.controller,this.obscureText=false,this.obscuringCharacter,this.maxLines});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: buildOutlineInputBorder(borderSideColor: borderSideColor)
          ,focusedBorder: buildOutlineInputBorder(borderSideColor: borderSideColor)
          ,errorBorder: buildOutlineInputBorder(borderSideColor:AppColors.redColor),
        focusedErrorBorder: buildOutlineInputBorder(borderSideColor: AppColors.redColor),
        errorStyle: AppStyles.med16red,
        hintText: hintText,
        hintStyle:hintStyle ?? AppStyles.med16grey ,
        labelText: labelText,
        labelStyle:labelStyle ?? AppStyles.med16grey  ,
        prefixIcon:prefixIcon,
        suffixIcon: suffixIcon,
      ),keyboardType: kerboardType,
      validator: validator,
      controller: controller,
      obscureText: obscureText!,
      obscuringCharacter:obscuringCharacter ?? "." ,
      style: TextStyle(
        color: themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.whiteColor
      ),maxLines: maxLines ??1,
    );
  }
  OutlineInputBorder buildOutlineInputBorder({ required borderSideColor}){
    return  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color:borderSideColor,
            width: 1.5
        )
    ) ;
  }
}
