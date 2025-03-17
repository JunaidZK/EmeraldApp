import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/categories/category_response.dart';
import 'package:emerald_beauty/model_class/services/services.dart';
import 'package:flutter/material.dart';

class Categories {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<List<CategoryResponse>?> getCategories() async {
    List<CategoryResponse>? result;
    try {
      final bool isConnected = await internet.isConnected();
      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.getCategories, method: Method.GET);

        final bool status = response["status"];

        if (status) {
          List<dynamic> dataList = response["data"]["data"];
          result =
              dataList.map((json) => CategoryResponse.fromJson(json)).toList();
        }
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return result;
  }

  Future<Services?> getAllServices() async {
    Services? result;
    try {
      final bool status = await internet.isConnected();
      if (status) {
        var response = await api.makeRequest(
            url: ApiUrls.service,
            method: Method.GET,
            params: {"relations[]": "category"});

        final bool status = response["status"];

        if (status) {
          result = Services.fromMap(response);
        } else {
          debugPrint("Error: ${response["message"]}");
        }
      } else {
        debugPrint("Check internet connection");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return result;
  }
}
