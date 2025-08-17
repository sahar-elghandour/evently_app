import 'package:evently_app/Ui/auth/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends ChangeNotifier{
  //todo: hold data  handel logic
  late RegisterNavigator navigator;

  void register(String email ,String password) async {
    navigator.showMyLoading('loading...');
   // DialogUtils.showLopading(textLoading: 'loading...', context: context);
    try {
      //todo:sign up  to firebase auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      /*
      //todo:save user to firestore
      MyUser myUser=MyUser(id: credential.user?.uid??'',
          name: nameController.text,
          email: emailController.text);
      await FirebaseUtils.addUserToFireStore(myUser);

      //todo:save user in provider
      var userProvider = Provider.of<UserProvider>(context,listen: false);
      userProvider.updateUser(myUser);
      var eventListProvider = Provider.of<EventListProvider>(context,listen: false);
      eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      eventListProvider.getAllFavEventsFromFirebase(userProvider.currentUser!.id);
       */
      //todo:hide loading
      navigator.hideMyLoading();
     // DialogUtils.hideLoading(context: context);
      //todo:show Msg
      navigator.showMyMesssage('Register Successfully',title:'success' );
      //navigator.navigateToHome();
      //DialogUtils.showMsg(context: context, msg: 'Register Successfully'
         // ,title: 'success',posActionName: 'ok',posAction:(){
          //  Navigator.pushNamedAndRemoveUntil(context,AppRoutes.homeRouteName,(route)=>false);
         // } );
      print('register successfully');
      print('id:${credential.user?.uid ?? ''}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideMyLoading();
        //DialogUtils.hideLoading(context: context);
        navigator.showMyMesssage('The password provided is too weak.',title: 'Error');
       // DialogUtils.showMsg(context: context,title: 'Error',posActionName: 'ok',msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideMyLoading();
       // DialogUtils.hideLoading(context: context);
        navigator.showMyMesssage('The account already exists for that email.' );
        // DialogUtils.showMsg(context: contextc,posActionName: 'ok',msg:'The account already exists for that email.' );
      }
    } catch (e) {
      navigator.hideMyLoading();
      //DialogUtils.hideLoading(context: context);
      navigator.showMyMesssage(e.toString(),title: 'Error');
      //DialogUtils.showMsg(context: context,title: 'Error',posActionName: 'ok', msg:e.toString() );
      print(e);
    }
  }

}
