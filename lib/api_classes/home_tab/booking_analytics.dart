import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/home_tab/booking_analytics.dart';
import 'package:flutter/foundation.dart';

class BookingAnalytics {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<BookingAnalyticsResponse?> getBookingAnalytics() async {
    late BookingAnalyticsResponse? result;
    try {
      bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.bookingAnalytics, method: Method.GET);

        final bool status = response["status"];

        if (status) {
          result = BookingAnalyticsResponse.fromJson(response);
        } else {
          debugPrint("Error: ${response["message"]}");
        }
      } else {
        debugPrint("Check Internet Connection");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return result;
  }
}
