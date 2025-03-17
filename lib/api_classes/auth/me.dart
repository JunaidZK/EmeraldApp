import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/user/user_info/user_info.dart';

class Me {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<ProfileResponse?> fetchUserProfile() async {
    try {
      bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response =
            await api.makeRequest(url: ApiUrls.me, method: Method.GET, params: {
          "relations[]": ["user_image", "user_services"]
        });

        if (response.containsKey("status")) {
          bool status = response["status"];

          if (status) {
            return ProfileResponse.fromJson(response);
          } else {
            throw Exception(
                "Failed to fetch user profile: ${response['message']}");
          }
        } else {
          throw Exception("Invalid response from server");
        }
      } else {
        throw Exception("Check internet connection");
      }
    } catch (e) {
      throw Exception("Unexpected error occurred. Please try again later.");
    }
  }
}
