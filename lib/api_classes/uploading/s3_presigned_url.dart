import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/foundation.dart';

class S3PresignedUrl {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<Map<String, dynamic>?> getS3PresignedUrl() async {
    Map<String, dynamic>? result;
    try {
      final bool isConneceted = await internet.isConnected();

      if (isConneceted) {
        var response = await api.makeRequest(
            url: ApiUrls.s3uploadUrl,
            method: Method.POST,
            params: {"content_type": "png/pdf/jpeg/mp4"});

        final bool status = response["status"];

        if (status) {
          result = response["data"]["result"];
        }
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return result;
  }
}
