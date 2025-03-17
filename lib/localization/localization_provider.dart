import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('languageCode');

    if (langCode != null) {
      _locale = Locale(langCode);
    }

    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    _locale = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', newLocale.languageCode);

    Get.updateLocale(newLocale); // <--- Force update UI immediately

    notifyListeners();
  }
}
