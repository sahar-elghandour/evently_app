import 'package:evently_app/Ui/home/taps/widgets/custom_elevated_button.dart';
import 'package:evently_app/Ui/home/taps/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController =TextEditingController(text:"sahar@gmail.com" );
  TextEditingController nameController =TextEditingController(text:"sahar" );
  TextEditingController rePasswordController =TextEditingController(text:"123456" );
  TextEditingController passwordController =TextEditingController(text: "123456");

  bool obscure=true;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    return Scaffold(

      appBar:AppBar(
        iconTheme: IconThemeData(
            color:themeProvider.appTheme== ThemeMode.dark ? AppColors.primaryColor:
        AppColors.blackColor),
        backgroundColor: themeProvider.appTheme== ThemeMode.dark?AppColors.darkPrimary:AppColors.whiteBgColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.register,style:themeProvider.appTheme== ThemeMode.dark? AppStyles.med16white:AppStyles.med16black),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.04),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(image: AssetImage(AppAssets.logo),height: height*.20,),
                SizedBox(height: height*.02,),
                Form( key:formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(hintText: AppLocalizations.of(context)!.name,hintStyle:  themeProvider.appTheme==ThemeMode.light?AppStyles.med16grey:AppStyles.med16white,prefixIcon:
                        Image(image: AssetImage(AppAssets.nameIcon)),controller: nameController,
                          kerboardType: TextInputType.text,
                          borderSideColor: themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.primaryColor ,
                          validator: (text){
                            if(text ==null || text.trim().isEmpty){
                              return AppLocalizations.of(context)!.enter_name;
                            }
                            return null;
                          },),
                        SizedBox(height: height*.02,),
                        CustomTextFormField(hintText: AppLocalizations.of(context)!.email,hintStyle:  themeProvider.appTheme==ThemeMode.light?AppStyles.med16grey:AppStyles.med16white,prefixIcon:
                        Image(image: AssetImage(AppAssets.emailIcon)),controller: emailController,
                          kerboardType: TextInputType.text,
                          borderSideColor: themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.primaryColor ,
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
                        CustomTextFormField(hintText:AppLocalizations.of(context)!.password,hintStyle:  themeProvider.appTheme==ThemeMode.light?AppStyles.med16grey:AppStyles.med16white,
                          controller: passwordController,
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
                          }, icon:Icon(obscure? Icons.visibility_off:Icons.visibility,color: themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.whiteColor,) ),obscureText:obscure,obscuringCharacter:"*" ,),
                        SizedBox(height: height*.02,),
                        CustomTextFormField(hintText:AppLocalizations.of(context)!.re_password,hintStyle:  themeProvider.appTheme==ThemeMode.light?AppStyles.med16grey:AppStyles.med16white,
                          controller: rePasswordController,
                          borderSideColor: themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.primaryColor ,
                          validator: (text){
                            if(text ==null || text.trim().isEmpty){
                              return AppLocalizations.of(context)!.enter_re_password;
                            }
                            if(text.length<6){
                              return AppLocalizations.of(context)!.enter_valid_re_password;
                            }
                            if(rePasswordController.text != passwordController.text){
                              return AppLocalizations.of(context)!.pass_should_equal_repass;
                            }
                            return null;
                          },
                          prefixIcon: Image(image: AssetImage(AppAssets.passwordIcon)),
                          suffixIcon: IconButton(onPressed: (){
                            obscure =!obscure;
                            setState(() {

                            });
                          }, icon:Icon(obscure? Icons.visibility_off:Icons.visibility,color:  themeProvider.appTheme==ThemeMode.light?AppColors.greyColor:AppColors.whiteColor,) ),obscureText:obscure,obscuringCharacter:"*" ,)
                        ,SizedBox(height: height*.02,),
                        CustomElevatedButton(onPressed:(){
                          register();
                        },text: AppLocalizations.of(context)!.create_account,)
                        , SizedBox(height: height*.02,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${AppLocalizations.of(context)!.have_account} ?',
                                style: themeProvider.appTheme==ThemeMode.light?AppStyles.med16black:AppStyles.med16white,)
                              ,TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child:
                              Text(AppLocalizations.of(context)!.login,style: AppStyles.bold16primary.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryColor
                              ),)),
                            ]),
                        SizedBox(height: height*.04,)
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
                        ,
                      ],)),

              ],
            ),
          ),
        ),

    );
  }

  void register() {
    if(formKey.currentState?.validate()==true){
    Navigator.of(context).pushNamed(AppRoutes.homeRouteName);
    }

  }
}
