import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/booking/booking_response.dart';
import 'package:flutter/material.dart';

class GetBookings {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<BookingResponse?> getBookings() async {
    late BookingResponse bookingsList;
    try {
      bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api
            .makeRequest(url: ApiUrls.getBookings, method: Method.GET, params: {
          "relations[]": ["service", "provider", "client"],
        });

        if (response.containsKey("status")) {
          final bool status = response["status"];

          if (status) {
            // Convert the response to BookingResponse model
            BookingResponse bookingResponse =
                BookingResponse.fromJson(response);

            // Extract the list of bookings
            bookingsList = bookingResponse;
          }
        }
      } else {
        // Handle no internet connection
        debugPrint("No internet connection.");
      }
    } catch (e) {
      debugPrint("Error fetching bookings: $e");
    }

    return bookingsList;
  }
}
