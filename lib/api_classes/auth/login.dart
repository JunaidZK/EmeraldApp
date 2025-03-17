import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/user/user.dart';
import 'package:flutter/material.dart';

class Login {
  ParseApi api = ParseApi();

  Future<dynamic> loginUser({
    required RequestFrom requestFrom,
    required Users user,
    required String input,
    required String password,
  }) async {
    try {
      // API Request
      var response = await api.makeRequest(
        url: "${ApiUrls.login}?relations[]=user_image",
        method: Method.POST,
        params: {
          requestFrom == RequestFrom.email ? "email" : "phone": input,
          "password": password,
          "roles": user == Users.freelancer ? [2] : [3],
        },
      );

      if (response.containsKey("message") || response.containsKey("error")) {
        final String message = response["message"] ?? response["error"];

        if (message.contains("Logged in successfully")) {
          return UserModel.fromJson(response);
        } else {
          return message;
        }
      }
      // Extract message or error
      // final String message = response["message"] ?? response["error"];

      // // Handle Success
      // if (message.contains("signed in successfully")) {
      //   return User.fromJson(response["user"]); // Return User object
      // }

      // // Handle Errors (e.g., "not verified")
      // return message; // Return error message as String
    } catch (e) {
      debugPrint("Exception: $e");
      return "An unexpected error occurred."; // Return a fallback error message
    }
  }
}
