import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';

class ResetPassword {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<String> resetPassword({
    required RequestFrom requestFrom,
    required String newPassword,
    required String confrimNewPassword,
    required String input,
    required String otp,
  }) async {
    try {
      bool isConnected = await internet.isConnected();
      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.resetPassword,
            method: Method.POST,
            params: {
              requestFrom == RequestFrom.email ? "email" : "phone": input,
              "password": newPassword,
              "password_confirmation": confrimNewPassword,
              "otp_code": otp,
              // "role":
            });

        if (response.containsKey("status")) {
          final bool status = response["status"];

          if (status) {
            return "Password reset successfully.";
          } else {
            return response["message"];
          }
        } else {
          return "Error resetting password. Please try again later!";
        }
      } else {
        return "Check your internet";
      }
    } catch (e) {
      return "Internal Server Error. Please try again later.";
    }
  }
}
