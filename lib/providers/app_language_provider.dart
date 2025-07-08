import 'package:flutter/material.dart';

import '../app_prefrences/app_prefrences.dart';

class LanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';

  LanguageProvider() {
    _loadSavedLanguage();
  }

  void changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) return;
    appLanguage = newLanguage;
    await AppPreferences.saveLanguage(newLanguage);
    notifyListeners();
  }

  void _loadSavedLanguage() async {
    final savedLang = await AppPreferences.getSavedLanguage();
    if (savedLang != null) {
      appLanguage = savedLang;
      notifyListeners();
    }
  }
}



