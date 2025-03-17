import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/profile/profile_management/leave_management.dart';
import 'package:flutter/material.dart';

class LeaveManagement {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<LeaveResponse?> getLeaves() async {
    late LeaveResponse? result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response =
            await api.makeRequest(url: ApiUrls.leave, method: Method.GET);

        final bool status = response["status"];

        if (status) {
          result = LeaveResponse.fromJson(response);
        } else {
          debugPrint("Error: ${response["message"]}");
        }
      } else {
        debugPrint("Check internet Connection");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return result;
  }

  Future<String> applyForLeave({
    required String startDate,
    required String endDate,
    required String reason,
    required String subject,
    required String leaveType,
    required List<String> attachments,
  }) async {
    String result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        List<Map<String, String>> documents = attachments.map((filePath) {
          return {
            "path": filePath, // Pass the actual file path
            "type":
                "image", // You might need to determine the file type dynamically
          };
        }).toList();

        var response = await api
            .makeRequest(url: ApiUrls.leave, method: Method.POST, params: {
          "start_date": startDate,
          "end_date": endDate,
          "reason": reason,
          "subject": subject,
          "type": leaveType == "SICK"
              ? 10
              : leaveType == "EMERGENCY"
                  ? 20
                  : leaveType == "VACATION"
                      ? 30
                      : 40,
          "documents": documents
        });

        final bool status = response["status"];

        if (status) {
          result = "Successfully applied for leave";
          debugPrint("Success: ${response["message"]}");
        } else {
          result = "Error applying for leave";
          debugPrint("Error: ${response["message"]}");
        }
      } else {
        result = "Check your internet connection";
        debugPrint("Check your internet connection");
      }
    } catch (e) {
      result = "Error applying for leave";
      debugPrint("Exception: $e");
    }
    return result;
  }
}
