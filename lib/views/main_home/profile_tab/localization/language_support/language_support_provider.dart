import 'package:flutter/material.dart';

class LanguageSupportProvider extends ChangeNotifier{
   String _selectedLanguage = "English"; // Default language

  String get selectedLanguage => _selectedLanguage;

  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}