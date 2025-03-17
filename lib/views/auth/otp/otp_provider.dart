import 'package:emerald_beauty/api_classes/auth/otp.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  Otp otpFetcher = Otp();

  String _otp = '';

  String get otp => _otp;

  set otp(String value) {
    _otp = value;
    notifyListeners(); // Notify listeners about the change
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasTriggeredOtp = false;
  bool get hasTriggeredOtp => _hasTriggeredOtp;

  void markOtpTriggered() {
    _hasTriggeredOtp = true;
    notifyListeners();
  }

  Future<String?> verifyOtp(BuildContext context,
      {required String input,
      required RequestFrom requesFrom,
      required DisplayType displayType}) async {
    _isLoading = true;
    notifyListeners();
    var result = await otpFetcher.verifyOtp(
        input: input, otp: otp, requesFrom: requesFrom);

    if (result["success"] == true) {
      _isLoading = false;
      notifyListeners();
      return null;
    } else {
      _isLoading = false;
      notifyListeners();
      return result["message"];
    }
  }

  Future<String> reSendOtp(BuildContext context,
      {required String input, required RequestFrom requesFrom}) async {
    _isLoading = true;
    notifyListeners();
    var result =
        await otpFetcher.resendOtp(input: input, requesFrom: requesFrom);

    if (result["success"] == true) {
      _isLoading = false;
      notifyListeners();
      return result["message"];
      // showToast(context, result["message"]);
    } else {
      _isLoading = false;
      notifyListeners();
      return result["message"];
      // showToast(context, result["message"]);
    }
  }
}
