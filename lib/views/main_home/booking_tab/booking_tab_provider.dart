import 'package:emerald_beauty/getx_controller.dart';
import 'package:emerald_beauty/model_class/booking/booking_response.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingTabProvider extends ChangeNotifier {
  AppStateController appStateController = Get.put(AppStateController(), permanent: true);

  late MainHomeProvider provider;
  late List<Booking> bookings;

  BookingTabProvider(this.provider) {
    bookings = provider.bookings!.data.data;
    notifyListeners();
  }

  bool _switcher = false;

  bool get switcher => _switcher;

  set switcher(bool value) {
    _switcher = value;

    notifyListeners(); // Notify listeners so the UI gets updated
    appStateController.bookingFilterList.value = [];
  }
}
