import 'package:flutter/material.dart';
import '../app_prefrences/app_prefrences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  ThemeProvider() {
    _loadSavedTheme();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) return;
    appTheme = newTheme;
    await AppPreferences.saveTheme(newTheme);
    notifyListeners();
  }

  void _loadSavedTheme() async {
    final savedTheme = await AppPreferences.getSavedTheme();
    if (savedTheme != null) {
      appTheme = savedTheme;
      notifyListeners();
    }
  }
}
