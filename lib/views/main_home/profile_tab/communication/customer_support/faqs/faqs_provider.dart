import 'package:flutter/material.dart';

class FaqsProvider extends ChangeNotifier {
  int? openedFaqIndex;

  void toggleFaq(int index) {
    if (openedFaqIndex == index) {
      // If the same FAQ is tapped, collapse it
      openedFaqIndex = null;
    } else {
      // Open the new FAQ
      openedFaqIndex = index;
    }
    notifyListeners();
  }
}
