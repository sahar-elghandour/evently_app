import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
   return Container(
     margin: EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.01),
     height: height*.27,
     decoration: BoxDecoration(
       image: DecorationImage(image: AssetImage(AppAssets.birthdayImage),fit: BoxFit.fill),
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
         Text('22',style: AppStyles.bold20primary),
         Text('Nov',style: AppStyles.bold14primary,)
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
         Expanded(child: Text('This is a Birthday Party ',
             style: AppStyles.bold14black)),
         IconButton(onPressed: (){}, icon:Icon( Icons.favorite_border),color: AppColors.primaryColor,)
       ],),
       )
   ],),

   );
   
  }
  
}