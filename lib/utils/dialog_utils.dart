import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils{

  static void showLopading({required String textLoading,required BuildContext context}){
    showDialog(barrierDismissible: false,
      context: context, builder: (context) =>
      AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppColors.primaryColor,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(textLoading,style: AppStyles.bold20black,),
            )
          ],
        ),
      )
    ,);
  }
  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);

  }

  static void showMsg({required BuildContext context,
    required String msg,String? title,String? posActionName,
    Function? posAction,String? negActionName,Function? negAction,bool barrierDismissible= true }){
    List<Widget>? actions=[];
      if(posActionName != null){
        actions.add(TextButton(onPressed: (){
          Navigator.pop(context);
          posAction?.call();
        }, child: Text(posActionName,style:AppStyles.bold14black ,)));

      }
      if(negActionName !=null){
        actions.add(TextButton(onPressed: (){
          Navigator.pop(context);
          negAction?.call();
        }, child: Text(negActionName,style:AppStyles.bold14black ,)));
      }

   showDialog(barrierDismissible: barrierDismissible,
       context: context, builder: (context) => AlertDialog(
     content: Text(msg,style: AppStyles.bold20black,),
     title: Text(title??'',style: AppStyles.bold14black,),
     actions: actions,
   ));
}
}