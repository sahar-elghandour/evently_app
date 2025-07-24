import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EventTapItem extends StatelessWidget{
  bool isSelected;
  String text;
  Color? selectedBgColor;
  Color? borderColor;
  TextStyle? selectedText;
  TextStyle? unSelectedText;
  EventTapItem({required this.isSelected,required this.text,
    this.selectedBgColor,this.borderColor,this.selectedText,this.unSelectedText});
  @override
  Widget build(BuildContext context) {
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width*.01),
      padding: EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.001),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        color: isSelected?selectedBgColor:AppColors.transparentColor,
        border: Border.all(
          width: 2,
          color: borderColor ??Theme.of(context).focusColor
        )
      ),
      child: Text(text,style: isSelected?selectedText:unSelectedText),
    );
  }
  
}