import 'package:emerald_beauty/model_class/booking/booking_response.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_tab_provider.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
  final searchController = TextEditingController();

  late BookingTabProvider provider;
  late Map<String, List<Booking>> groupedBookings;

  HistoryProvider(this.provider) {
    filterBookings();
  }

  void filterBookings() {
    // Group the bookings by month and year
    groupedBookings = {};

    // Filter bookings with status 40 or 50
    var filteredBookings = provider.bookings
        .where((booking) => booking.status == 40 || booking.status == 50)
        .toList();

    for (var booking in filteredBookings) {
      final date = DateTime.parse(booking.date); // Parse the date string
      final monthYear =
          "${getMonthName(date.month)} ${date.year}"; // Format month and year

      // Group bookings by month and year
      if (groupedBookings.containsKey(monthYear)) {
        groupedBookings[monthYear]?.add(booking);
      } else {
        groupedBookings[monthYear] = [booking];
      }
    }

    // Notify listeners if the list of bookings changes
    notifyListeners();
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  // var bookingHistory = [
  //   {
  //     'Sept 30, Monday':
  //     [
  //       {
  //         'service': "Classic Men's Haircut",
  //         'amount': '180 AED',
  //         'date_time': '10 Sep, 2024 | 4:00 PM',
  //         'client_name': 'John Peterson',
  //         'stars': '4.4',
  //         'reviews': '250',
  //         'status': 'Completed',
  //         'amount_due': '260 AED',
  //         'add_ons': [
  //           {
  //             "service": "Deep Conditioning Treatment",
  //             "amount": "50 AED"
  //           },
  //           {
  //             "service": "Scalp Massage",
  //             "amount": "30 AED"
  //           }
  //         ]
  //       },
  //       {
  //         'service': "Classic Men's Haircut",
  //         'amount': '180 AED',
  //         'date_time': '10 Sep, 2024 | 4:00 PM',
  //         'client_name': 'John Peterson',
  //         'stars': '4.4',
  //         'reviews': '250',
  //         'status': 'Cancelled',
  //         'amount_due': '260 AED',
  //         'add_ons': [
  //           {
  //             "service": "Deep Conditioning Treatment",
  //             "amount": "50 AED"
  //           },
  //           {
  //             "service": "Scalp Massage",
  //             "amount": "30 AED"
  //           }
  //         ]
  //       },
  //       {
  //         'service': "Classic Men's Haircut",
  //         'amount': '180 AED',
  //         'date_time': '10 Sep, 2024 | 4:00 PM',
  //         'client_name': 'John Peterson',
  //         'stars': '4.4',
  //         'reviews': '250',
  //         'status': 'Completed',
  //         'amount_due': '260 AED',
  //         'add_ons': [
  //           {
  //             "service": "Deep Conditioning Treatment",
  //             "amount": "50 AED"
  //           },
  //           {
  //             "service": "Scalp Massage",
  //             "amount": "30 AED"
  //           }
  //         ]
  //       },
  //       {
  //         'service': "Classic Men's Haircut",
  //         'amount': '180 AED',
  //         'date_time': '10 Sep, 2024 | 4:00 PM',
  //         'client_name': 'John Peterson',
  //         'stars': '4.4',
  //         'reviews': '250',
  //         'status': 'Cancelled',
  //         'amount_due': '260 AED',
  //         'add_ons': [
  //           {
  //             "service": "Deep Conditioning Treatment",
  //             "amount": "50 AED"
  //           },
  //           {
  //             "service": "Scalp Massage",
  //             "amount": "30 AED"
  //           }
  //         ]
  //       },
  //     ]
  //   }
  // ];
}
