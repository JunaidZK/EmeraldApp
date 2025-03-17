import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/profile/customer_support/faqs.dart';
import 'package:flutter/material.dart';

class FaqsApi {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<FaqResponse?> fetchFaqs() async {
    late FaqResponse? result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response =
            await api.makeRequest(url: ApiUrls.faq, method: Method.GET);

        final bool status = response["status"];

        if (status) {
          result = FaqResponse.fromJson(response);
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
