import 'dart:async';

import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.onboardingRouteName);
    });
  }
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(themeProvider.appTheme==ThemeMode.light? AppAssets.splashLight:AppAssets.splashDark),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}