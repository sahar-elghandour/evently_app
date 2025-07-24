import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/Ui/auth/login/login_screen.dart';
import 'package:evently_app/Ui/home/add_event/add_event.dart';
import 'package:evently_app/Ui/home/home_screen.dart';
import 'package:evently_app/onboarding_screens/onboarding_screen1.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'Ui/auth/register/register_screen.dart';

import 'Ui/home/edit_event/edit_event.dart';
import 'Ui/home/event_details/event_details.dart';
import 'firebase_options.dart';
import 'model/event.dart';
import 'onboarding_screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  //await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create:(context) => LanguageProvider()),

      ChangeNotifierProvider(create:(context) => ThemeProvider())

     ,ChangeNotifierProvider(create:(context) =>  EventListProvider())

     ,ChangeNotifierProvider(create:(context) => UserProvider())
  ]
      ,child: MyApp()));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginRouteName,
      routes: {
        AppRoutes.addEventRouteName:(context)=>AddEvent(),
        AppRoutes.splashRouteName:(context)=>SplashScreen(),
        AppRoutes.loginRouteName:(context)=>LoginScreen(),
        AppRoutes.registerRouteName:(context)=>RegisterScreen(),
        AppRoutes.onboardingRouteName:(context)=>OnboardingScreen(),
        AppRoutes.homeRouteName:(context)=>HomeScreen(),
        AppRoutes.eventDetailsRouteName:(context){
          final event =ModalRoute.of(context)!.settings.arguments as Event;
          return EventDetails(event:event);

      },AppRoutes.editEventRouteName:(context){
          final event =ModalRoute.of(context)!.settings.arguments as Event;
          return EditEvent(event:event);

        },

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

