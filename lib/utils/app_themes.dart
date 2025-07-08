import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'app_styles.dart';
class AppTheme {
  static final ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.whiteBgColor,
primaryColor: AppColors.primaryColor,
focusColor: AppColors.whiteColor,
appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(34),bottomRight: Radius.circular(34) )
  ),
  iconTheme: IconThemeData(
    color: AppColors.whiteColor,

  )

),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.transparentColor,
    type: BottomNavigationBarType.fixed,
  selectedItemColor: AppColors.whiteColor,
    unselectedItemColor:AppColors.whiteColor ,
  showUnselectedLabels: true,
 selectedLabelStyle: AppStyles.bold12white,
  unselectedLabelStyle: AppStyles.bold12white,
  elevation: 0
),
floatingActionButtonTheme: FloatingActionButtonThemeData(
  backgroundColor: AppColors.primaryColor
),
textTheme: TextTheme(
  headlineLarge: AppStyles.bold20black,
  headlineMedium: AppStyles.med16primary,
  headlineSmall: AppStyles.bold14primary,
  titleMedium: AppStyles.med16white
)
  );
  static final ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.darkPrimary,
      primaryColor: AppColors.darkPrimary,
      focusColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkPrimary
      ),
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,

      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.transparentColor,
        type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.whiteColor,
          unselectedItemColor:AppColors.whiteColor ,
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyles.bold12white,
        unselectedLabelStyle: AppStyles.bold12white,
          elevation: 0
      ),floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary
  ),
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20white,
          headlineSmall: AppStyles.bold14darkPrimary,
        headlineMedium: AppStyles.med16white,
          titleMedium: AppStyles.med16white
      )
  );
}