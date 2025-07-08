import 'package:evently_app/Ui/auth/login/login_screen.dart';
import 'package:evently_app/Ui/home/home_screen.dart';
import 'package:evently_app/onboarding_screens/onboarding_screen1.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'Ui/auth/register/register_screen.dart';
import 'onboarding_screens/splash_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create:(context) => LanguageProvider()),
      ChangeNotifierProvider(create:(context) => ThemeProvider())]
      ,child: MyApp()));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRouteName,
      routes: {
        AppRoutes.splashRouteName:(context)=>SplashScreen(),
        AppRoutes.loginRouteName:(context)=>LoginScreen(),
        AppRoutes.registerRouteName:(context)=>RegisterScreen(),
        AppRoutes.onboardingRouteName:(context)=>OnboardingScreen(),
        AppRoutes.homeRouteName:(context)=>HomeScreen(),

      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,

    );
  }

}

