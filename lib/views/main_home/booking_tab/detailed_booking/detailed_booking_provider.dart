import 'package:flutter/material.dart';

class DetailedBookingProvider extends ChangeNotifier{
   String _status = "Confirmed"; // Initial status

  String get status => _status;

  // Method to update status
  void updateStatus(String newStatus) {
    _status = newStatus;
    notifyListeners(); // Notify listeners to rebuild UI
  }
}