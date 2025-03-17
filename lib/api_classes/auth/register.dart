import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class Register {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<String> register({
    required RequestFrom requestFrom,
    required String input,
    required String firstName,
    required String lastName,
    required String userName,
    required String password,
    required String address,
    required double lat,
    required double lng,
    String? imageUrl,
    required List<int> selectedCategoryIds,
    required List<String> selectedCategoryNames,
    required Map<String, List<String>> uploadedDocuments,
    required Map<String, List<String>> uploadedPortfolio,
    required Map<String, List<String>> uploadCertificates,
  }) async {
    String result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var params = {
          requestFrom == RequestFrom.email ? "email" : "phone": input,
          "user_name": userName,
          "first_name": firstName,
          "last_name": lastName,
          "password": password,
          "latitude": lat,
          "longitude": lng,
          "address": address,
          "role_id": 2,
          "categories": selectedCategoryIds.map((categoryId) {
            return {
              "category_id": categoryId,
              "certificates": (uploadCertificates[selectedCategoryNames[
                          selectedCategoryIds.indexOf(categoryId)]] ??
                      [])
                  .map((path) => {"path": path, "type": "image"})
                  .toList(),
              "documents": (uploadedDocuments[selectedCategoryNames[
                          selectedCategoryIds.indexOf(categoryId)]] ??
                      [])
                  .map((path) => {"path": path, "type": "image"})
                  .toList(),
              "potfolio": (uploadedPortfolio[selectedCategoryNames[
                          selectedCategoryIds.indexOf(categoryId)]] ??
                      [])
                  .map((path) => {"path": path, "type": "image"})
                  .toList(),
            };
          }).toList()
        };

        if (imageUrl != null) {
          params["image_url"] = imageUrl;
        }
        var response = await api.makeRequest(
            url: ApiUrls.register, method: Method.POST, params: params);

        final bool status = response["status"];

        if (status) {
          debugPrint("Success");
          result = "User created successfully";
        } else {
          debugPrint("Error: ${response["message"]}");
          result = "${response["message"]}";
        }
      } else {
        debugPrint("Check your internet connection");
        result = "Check your internet connection";
      }
    } catch (e) {
      debugPrint("Exception: $e");
      result = "Unexpected Error Occured";
    }
    return result;
  }
}
