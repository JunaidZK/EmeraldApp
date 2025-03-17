import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class EditProfileApi {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<String> updateProfile(
      {required String firstName,
      required String lastName,
      required String bio,
      required String address,
      required double latitude,
      required double longitude,
      required String image,
      required bool activeStatus}) async {
    late String result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.editProfile,
            method: Method.POST,
            params: {
              "first_name": firstName,
              "last_name": lastName,
              "bio": bio,
              "address": address,
              "latitude": latitude,
              "longitude": longitude,
              "availibility_status": activeStatus ? 20 : 10,
              "image_url": image
            });

        final bool status = response["status"];

        if (status) {
          result = "${response["message"]}";
        } else {
          result = "${response["message"]}";
        }
      } else {
        debugPrint("Check you internet connection");
        result = "Check you internet connection";
      }
    } catch (e) {
      debugPrint("Exception: $e");
      result = "Unexpected Error Occurred! Please try again later.";
    }
    return result;
  }
}
