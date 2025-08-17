import 'package:evently_app/Ui/auth/login/login-navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModel extends ChangeNotifier{
  //todo: hold data  handel logic
  var emailController =TextEditingController(text:"sahar@gmail.com");
  var passwordController=TextEditingController(text: "123456");
  late LoginNavigator navigator;
  var formKey = GlobalKey<FormState>();
  void login() async{
      if (formKey.currentState?.validate() == true) {
        navigator.showMyLoading('Loading...');
        // DialogUtils.showLopading(textLoading: 'Loading...', context: context);
        try {
          //todo:sign in firebase auth
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text
          );
          /*
      //todo:read user from firestore
      var user =await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
      if(user == null){
        return;
      }
      //todo:save user in provider
      var userProvider = Provider.of<UserProvider>(context,listen: false);
      userProvider.updateUser(user);
      var eventListProvider = Provider.of<EventListProvider>(context,listen: false);
      eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      eventListProvider.getAllFavEventsFromFirebase(userProvider.currentUser!.id);


       */
          //todo:hide loading
          navigator.hideMyLoading();
          //DialogUtils.hideLoading(context: context);
          //todo:show Msg
          navigator.showMyMesssage('login successfully',title:'success' );
         // navigator.navigateToHome();
          //DialogUtils.showMsg(context: context, msg:'login successfully',
          //title: 'success',posActionName: 'ok' ,posAction: (){
          // Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
          // });
          print('id:${credential.user?.uid ?? ''}');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-credential') {
            //todo:hide loading
            navigator.hideMyLoading();
            // DialogUtils.hideLoading(context: context);
            //todo:show Msg
            navigator.showMyMesssage(title: 'Error',
                'The supplied auth credential is incorrect or has expired.');
            //DialogUtils.showMsg(context: context,
            //  msg:'The supplied auth credential is incorrect or has expired.'
            //,title: 'Error',posActionName: 'ok' );

          }
        } catch (e) {
          //todo:hide loading
          navigator.hideMyLoading();
          //DialogUtils.hideLoading(context: context);
          //todo:show Msg
          navigator.showMyMesssage(e.toString(),title: 'Error');
          //DialogUtils.showMsg(context: context,title: 'Error',posActionName: 'ok', msg:e.toString());
          print(e.toString());
        }
      }
    }
}