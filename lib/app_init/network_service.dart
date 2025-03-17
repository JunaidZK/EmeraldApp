import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';

class NetworkService {
  static void initalizeUrl(Environment env) {
    switch (env) {
      case Environment.local:
        ApiUrls.baseUrl = "https://th2nztnp-5000.inc1.devtunnels.ms/api/v1";
        break;
      case Environment.staging:
        ApiUrls.baseUrl = "https://staging-api.emeraldbeauty.info/api/v1";
        break;
      case Environment.live:
        ApiUrls.baseUrl = "";
        break;
    }
  }
}
