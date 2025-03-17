import 'package:emerald_beauty/api_classes/auth/forget_password.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  ForgetPassword password = ForgetPassword();

  final TextEditingController inputController = TextEditingController();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String _phoneNumberWithCountryCode = '';

  bool get isLoading => _isLoading;

  String get phoneNumberWithCountryCode => _phoneNumberWithCountryCode;

  void setPhoneNumber(String phoneNumber) {
    _phoneNumberWithCountryCode = phoneNumber;
    notifyListeners();
  }

  Future<String?> forgetPass({required RequestFrom requestFrom}) async {
    _isLoading = true;
    notifyListeners();
    String? message;
    String result = await password.forgetPassword(
        requestFrom: requestFrom,
        input: requestFrom == RequestFrom.email
            ? inputController.text
            : _phoneNumberWithCountryCode);

    if (result.contains("Verification Code Send")) {
      message = null;
    } else {
      message = result;
    }
    _isLoading = false;
    notifyListeners();
    return message;
  }
}
