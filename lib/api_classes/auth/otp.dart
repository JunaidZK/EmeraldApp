import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class Otp {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<Map<String, dynamic>> verifyOtp(
      {required String input,
      required String otp,
      required RequestFrom requesFrom}) async {
    try {
      bool isConnected = await internet.isConnected();
      if (isConnected) {
        var response = await api
            .makeRequest(url: ApiUrls.verifyOtp, method: Method.POST, params: {
          requesFrom == RequestFrom.email ? "email" : "phone": input,
          "otp_code": otp,
          // "role":
        });

        if (response.containsKey("message")) {
          final String message = response["message"];
          if (message.contains("Code Verified")) {
            return {"success": true, "message": message};
          } else {
            return {"success": false, "message": message};
          }
        } else {
          return {
            "success": false,
            "message": "Error verifying OTP. Please try later."
          };
        }
      } else {
        return {"success": false, "message": "Check Internet Connection"};
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return {
        "success": false,
        "message": "Error verifying OTP. Please try later."
      };
    }
  }

  Future<Map<String, dynamic>> resendOtp(
      {required String input, required RequestFrom requesFrom}) async {
    try {
      bool isConnected = await internet.isConnected();
      if (isConnected) {
        var response = await api
            .makeRequest(url: ApiUrls.resendOtp, method: Method.POST, params: {
          "type": requesFrom.name,
          requesFrom == RequestFrom.email ? "email" : "phone": input,
          // "role":
        });

        if (response.containsKey("message")) {
          final String message = response["message"];
          if (message.contains("Otp resend Successfully")) {
            return {"success": true, "message": message};
          } else {
            return {"success": false, "message": message};
          }
        } else {
          return {
            "success": false,
            "message": "Issue resending OTP. Please try again later"
          };
        }
      } else {
        return {"success": false, "message": "Check Internet Connection"};
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return {
        "success": false,
        "message": "Issue resending OTP. Please try again later"
      };
    }
  }
}
