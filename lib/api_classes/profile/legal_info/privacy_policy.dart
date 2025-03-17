import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/profile/policies_legal_info/privacy_policy.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyApi {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<PrivacyPolicy?> fetchPrivacyPolicy() async {
    late PrivacyPolicy? result;
    try {
      final bool isConnected = await internet.isConnected();
      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.privacyPolicy, method: Method.GET);

        final bool status = response["status"];

        if (status) {
          result = PrivacyPolicy.fromJson(response);
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
