import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class UserService {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<String> createNewService(
      {required int serviceId,
      required List<String> docs,
      required List<String> portfolio,
      required int price}) async {
    String result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        Map<String, dynamic> params = {
          "service_id": serviceId,
          "price": price,
          "documents": docs
              .map((doc) => {"path": doc, "type": "doc"})
              .toList(), // Converting docs list to required format
          "potfolio": portfolio
              .map((item) => {"path": item, "type": "image"})
              .toList(), // Converting portfolio list to required format
        };

        var response = await api.makeRequest(
            url: ApiUrls.userServicee, method: Method.POST, params: params);

        final bool status = response["status"];

        if (status) {
          debugPrint("Succesful");
          result = "Your have created a new service";
        } else {
          debugPrint("Error: ${response["message"]}");
          result =
              response["message"] == "The service_id has already been taken"
                  ? "This service has already been created"
                  : "Error creating new service";
        }
      } else {
        debugPrint("Check you internet connection");
        result = "Check you internet connection";
      }
    } catch (e) {
      debugPrint("Exception: $e");
      result = e.toString();
      if (result.contains("The service_id has already been taken")) {
        result = "This service has already been created";
      } else {
        result = "Error creating new service";
      }
    }
    return result;
  }
}
