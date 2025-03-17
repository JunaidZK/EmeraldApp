import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';

class ForgetPassword {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<String> forgetPassword({
    required RequestFrom requestFrom,
    required String input,
  }) async {
    try {
      bool isConnected = await internet.isConnected();
      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.forgotPassword,
            method: Method.POST,
            params: {
              requestFrom == RequestFrom.email ? "email" : "phone": input,
              // "role":
            });

        print(response);

        if (response.containsKey("status")) {
          final bool status = response["status"];
          if (status) {
            return response["message"];
          } else {
            return response["message"];
          }
        } else {
          return "Check your internet connection";
        }
      } else {
        return "Check your internet connection";
      }
    } catch (e) {
      return "Internal Server Error. Please try again later.";
    }
  }
}
