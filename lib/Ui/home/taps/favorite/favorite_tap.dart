import 'package:evently_app/Ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../home_tap/widget/event_item.dart';

class FavoriteTap extends StatelessWidget{
  TextEditingController searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
   return SafeArea(child: Column(children: [
     Padding(
       padding:  EdgeInsets.symmetric(horizontal: width*.04),
       child: CustomTextFormField(hintText: 'Search for Event',
         hintStyle: AppStyles.bold14primary,borderSideColor: AppColors.primaryColor,controller:searchController ,
       prefixIcon: Icon(Icons.search,color: AppColors.primaryColor,),),
     ),
     Expanded(
         child: ListView.separated(
             padding: EdgeInsets.only(top: height*.02),
             itemBuilder: (context, index) {
               return EventItem();
             }
             , separatorBuilder: (context, index) {
           return SizedBox(height: height*.001,);              },
             itemCount: 20))
   ],));
  }

}