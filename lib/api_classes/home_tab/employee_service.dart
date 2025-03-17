import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/home_tab/employee_services.dart';
import 'package:emerald_beauty/model_class/services/service_by_id.dart';
import 'package:flutter/foundation.dart';

class EmployeeService {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<EmployeeServices?> getEmployeeServices() async {
    EmployeeServices? result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.userServicee,
            params: {
              "relations[]": ["service", "potfolio"]
            },
            method: Method.GET);

        final bool status = response["status"];

        if (status) {
          result = EmployeeServices.fromMap(response);
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

  Future<ServiceByIdResponse?> getServicesbyId({required int serviceId}) async {
    ServiceByIdResponse? result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: "${ApiUrls.service}/$serviceId",
            method: Method.GET,
            params: {
              "relations[]": [
                "cover_photo",
              ]
            });

        final bool status = response["status"];

        if (status) {
          result = ServiceByIdResponse.fromJson(response);
        } else {
          debugPrint("Error: ${response["message"]}");
        }
      } else {
        debugPrint("Check internet connection");
      }
    } catch (e) {
      debugPrint("Excpetion: $e");
    }
    return result;
  }
}
