import 'package:emerald_beauty/model_class/booking/booking_response.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_tab_provider.dart';
import 'package:flutter/material.dart';

class BookingRequestsProvider extends ChangeNotifier {
  final searchController = TextEditingController();

  late BookingTabProvider provider;
  late List<Booking> bookings;

  BookingRequestsProvider(this.provider) {
    filterBookings();
  }

  void filterBookings() {
    bookings = provider.bookings
        .where((booking) => booking.status == 10 || booking.status == 20)
        .toList();

    // Notify listeners if the list of bookings changes
    notifyListeners();
  }
}
