import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/foundation.dart';

class UpdateBookingStatus {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<String> updateBooking(
      {required int bookingId, required BookingDecision decision}) async {
    late String result;

    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: "${ApiUrls.updateBooking}/$bookingId",
            method: Method.PATCH,
            params: {
              "status": decision == BookingDecision.ACCEPT
                  ? 20
                  : decision == BookingDecision.COMPLETED
                      ? 40
                      : 50
            });

        final bool status = response["status"];

        if (status) {
          result = "Booking ${decision.name.toLowerCase()} successfully";
          debugPrint("Booking ${decision.name.toLowerCase()} successfully");
        } else {
          result = "Issue ${decision.name.toLowerCase()} booking";
        }
      } else {
        result = "Check your internet connections";
      }
    } catch (e) {
      result =
          "Exception caught while ${decision.name.toLowerCase()} the booking";
    }
    return result;
  }
}
