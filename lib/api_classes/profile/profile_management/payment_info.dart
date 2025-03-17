import 'package:emerald_beauty/api_classes/check_connectivity.dart';
import 'package:emerald_beauty/api_classes/parse_api.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/model_class/profile/profile_management/bank_account.dart';
import 'package:flutter/material.dart';

class PaymentInfoApi {
  ParseApi api = ParseApi();
  CheckConnectivity internet = CheckConnectivity();

  Future<BankAccount?> fetchPaymentInfo() async {
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        var response = await api.makeRequest(
            url: ApiUrls.getPaymentInfo, method: Method.GET);

        final bool status = response["status"];

        if (status) {
          return BankAccount.fromJson(response["data"]);
        } else {
          debugPrint("Error: ${response["message"]}");
        }
      } else {
        debugPrint("Check Internet Connection");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
    return null;
  }

  Future<String> bankInfo(
      {required bool updateRequest,
      int? id,
      required String accountHolderName,
      required String bankName,
      required String accountNo,
      required String iban}) async {
    late String result;
    try {
      final bool isConnected = await internet.isConnected();

      if (isConnected) {
        String url =
            updateRequest ? "${ApiUrls.paymentInfo}/$id" : ApiUrls.paymentInfo;

        var response = await api.makeRequest(
            url: url,
            method: updateRequest ? Method.PUT : Method.POST,
            params: {
              "account_number": accountNo,
              "bank_name": bankName,
              "iban": iban,
              "name": accountHolderName
            });

        final bool status = response["status"];

        if (status) {
          result = response["message"];
        } else {
          debugPrint("Error: ${response["message"]}");
          result =
              "Issue ${updateRequest ? "updating" : "creating"} payment information";
        }
      } else {
        debugPrint("Check Internet Connection");
        result = "Check Internet Connection";
      }
    } catch (e) {
      debugPrint("Exception: $e");
      result =
          "Issue ${updateRequest ? "updating" : "creating"} payment information";
    }
    return result;
  }
}
