import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/profile/ratings_reviews/ratings_and_reviews.dart';
import 'package:flutter/material.dart';

class RatingsReviewsApi {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<ReviewResponse?> fetchReviews() async {
    late ReviewResponse? result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.reviews,
            method: Method.GET,
            params: {"relations[]": "user"});

        final bool status = response["status"];

        if (status) {
          result = ReviewResponse.fromJson(response);
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
