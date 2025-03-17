import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  bool _isAnimated = false;

  bool get isAnimated => _isAnimated;

  set isAnimated(bool value) {
    _isAnimated = value;
    notifyListeners();
  }
}
