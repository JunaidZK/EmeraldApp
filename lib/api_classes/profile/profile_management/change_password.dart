import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';

class ChangePassword {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<String> changePassword(
      {required String newPassword,
      required String confirmNewPassword,
      required String currentPassword}) async {
    try {
      bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.passwordChange,
            method: Method.POST,
            params: {
              "password": newPassword,
              "current_password": currentPassword,
              "password_confirmation": confirmNewPassword
            });

        if (response.containsKey("status")) {
          bool status = response["status"];
          if (status) {
            return response["message"];
          } else {
            return response["message"] ?? response["error"];
          }
        } else {
          return response["error"];
        }
      } else {
        return "Check your internet and try again later.";
      }
    } catch (e) {
      return "An unexpected error has occurred please try again later.";
    }
  }
}
