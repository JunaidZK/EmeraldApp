import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class GiveReview {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();
  Future<String> sendReview(
      {required int bookingId,
      required String review,
      required int rating}) async {
    late String result;
    try {
      final bool isConnected = await internet.isConnected();
      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.reviews,
            method: Method.POST,
            params: {
              "booking_id": bookingId,
              "review": review,
              "rating": rating
            });

        final bool status = response["status"];

        if (status) {
          result = "Thank you for providing for the service.";
        } else {
          debugPrint("Error: ${response["message"]}");
          result = "Unable to add the review at the moment";
        }
      } else {
        debugPrint("Check your Internet");
        result = "Check your Internet Connection";
      }
    } catch (e) {
      debugPrint("Exception: $e");
      result = "Unable to add the review at the moment";
    }
    return result;
  }
}
