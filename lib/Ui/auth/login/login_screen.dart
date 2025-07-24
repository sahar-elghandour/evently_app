import 'package:evently_app/Ui/home/taps/widgets/custom_elevated_button.dart';
import 'package:evently_app/Ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../model/my_user.dart';
import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
var formKey = GlobalKey<FormState>();

  TextEditingController emailController =TextEditingController(text:"sahar@gmail.com" );

  TextEditingController passwordController =TextEditingController(text: "123456");

  bool obscure=true;

  @override
  Widget build(BuildContext context) {
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.04),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(image: AssetImage(AppAssets.logo),height: height*.20,),
                SizedBox(height: height*.02,),
                Form( key:formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  CustomTextFormField(hintText: AppLocalizations.of(context)!.email,prefixIcon:
                  Image(image: AssetImage(AppAssets.emailIcon)),controller: emailController,hintStyle: themeProvider.appTheme==ThemeMode.light?AppStyles.med16grey:AppStyles.med16white ,
                    kerboardType: TextInputType.emailAddress,borderSideColor:themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.primaryColor ,
                    validator: (text){
                    if(text ==null || text.trim().isEmpty){
                      return AppLocalizations.of(context)!.enter_email;
                    }
                    final bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailController.text);
                    if(!emailValid){
                      return AppLocalizations.of(context)!.enter_valid_email;
                    }
                    return null;
                    },),
                  SizedBox(height: height*.02,),
                  CustomTextFormField(hintText:AppLocalizations.of(context)!.password,hintStyle: themeProvider.appTheme==ThemeMode.light?AppStyles.med16grey:AppStyles.med16white ,
                    controller: passwordController,
                    kerboardType:TextInputType.visiblePassword ,
                    borderSideColor: themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.primaryColor ,
                    validator: (text){
                      if(text ==null || text.trim().isEmpty){
                        return AppLocalizations.of(context)!.enter_password;
                      }
                      if(text.length<6){
                        return AppLocalizations.of(context)!.enter_valid_password;
                      }
                      return null;
                    },
                    prefixIcon: Image(image: AssetImage(AppAssets.passwordIcon)),
                    suffixIcon: IconButton(onPressed: (){
                      obscure =!obscure;
                      setState(() {

                      });
                    }, icon:Icon(obscure? Icons.visibility_off:Icons.visibility,color:themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.whiteColor,) ),obscureText:obscure,obscuringCharacter:"*" ,)
                  ,Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){}, child:Text('${AppLocalizations.of(context)!.forget_password}?'
                        ,style: AppStyles.bold16primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor
                      ),))
                    ],),
                  SizedBox(height: height*.02,),
                  CustomElevatedButton(onPressed:(){
                    login();
                  },text: AppLocalizations.of(context)!.login,)
                  , SizedBox(height: height*.02,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${AppLocalizations.of(context)!.do_not_have_account} ?',
                          style:themeProvider.appTheme==ThemeMode.light?AppStyles.med16black:AppStyles.med16white)
                        ,TextButton(onPressed: (){
                          Navigator.of(context).pushNamed(AppRoutes.registerRouteName);
                        }, child: Text(AppLocalizations.of(context)!.create_account,style: AppStyles.bold16primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColor
                        ),))
                      ])
                  , SizedBox(height: height*.01,)
                  ,Row(children: [
                    Expanded(child: Divider(
                      indent: width*.05,
                      endIndent:  width*.04,
                      thickness: 2,
                      color: AppColors.primaryColor,
                    )),
                    Text(AppLocalizations.of(context)!.or,style: AppStyles.med20primary,),
                    Expanded(child: Divider(thickness: 2,
                      indent: width*.04,
                      endIndent:  width*.06,
                      color: AppColors.primaryColor,))
                  ],),
                  SizedBox(height: height*.02,),
                  CustomElevatedButton(onPressed:(){
                    loginWithGoogle();

                  },text: AppLocalizations.of(context)!.login_google,
                    textStyle: AppStyles.med20primary,backgroundColorButton: AppColors.transparentColor,icon: true,iconName: AppAssets.google,)
         ,           SizedBox(height: height*.04,)
                    , Align(alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(width: 3,color: AppColors.primaryColor)
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                languageProvider.changeLanguage('en');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: languageProvider.appLanguage == 'en'
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/US.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),SizedBox(width: width*.03,),
                            GestureDetector(
                              onTap: () {
                                languageProvider.changeLanguage('ar');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: languageProvider.appLanguage == 'ar'
                                        ? Colors.blue
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/egypt.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                          ],),),
                    )
                  ],)),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if(formKey.currentState?.validate()==true){
      DialogUtils.showLopading(textLoading: 'Loading...', context: context);
      try {
        //todo:sign in firebase auth
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
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
       //todo:hide loading
        DialogUtils.hideLoading(context: context);
        //todo:show Msg
        DialogUtils.showMsg(context: context, msg:'login successfully',
            title: 'success',posActionName: 'ok' ,posAction: (){
          Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
            });
        print('id:${credential.user?.uid ?? ''}');
      } on FirebaseAuthException catch (e) {
           if(e.code =='invalid-credential'){
             DialogUtils.hideLoading(context: context);
             DialogUtils.showMsg(context: context,
                 msg:'The supplied auth credential is incorrect or has expired.'
                 ,title: 'Error',posActionName: 'ok' );

           }
      }catch(e){
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMsg(context: context,title: 'Etrror',posActionName: 'ok', msg:e.toString());
        print(e.toString());
      }
    }
  }
Future<void> loginWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);


    MyUser? user = await FirebaseUtils.readUserFromFireStore(userCredential.user!.uid);

    if (user == null) {
      MyUser newUser = MyUser(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? '',
        email: userCredential.user!.email ?? '',
      );

      await FirebaseUtils.addUserToFireStore(newUser);
      user = newUser;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.updateUser(user);

    final eventListProvider = Provider.of<EventListProvider>(context, listen: false);
    eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
    eventListProvider.getAllFavEventsFromFirebase(userProvider.currentUser!.id);

    DialogUtils.showMsg(
      context: context,
      msg: 'Login with Google successful',
      title: 'Success',
      posActionName: 'OK',
      posAction: () {
        Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
      },
    );
  } catch (e) {
    print(e.toString());
    DialogUtils.showMsg(
      context: context,
      title: 'Error',
      msg: e.toString(),
      posActionName: 'OK',
    );
  }
}
}
