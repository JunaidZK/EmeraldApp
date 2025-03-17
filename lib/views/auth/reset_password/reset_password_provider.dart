import 'package:emerald_beauty/api_classes/auth/reset_password.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class ResetPasswordProvider extends ChangeNotifier {
  ResetPassword reset = ResetPassword();

  final GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  // Private fields for password visibility
  bool _hideNewPassword = true;
  bool _hideConfirmNewPassword = true;
  bool _isLoading = false;

  // Getters
  bool get hideNewPassword => _hideNewPassword;
  bool get hideConfirmNewPassword => _hideConfirmNewPassword;
  bool get isLoading => _isLoading;

  // Setters with notifyListeners for UI updates
  set hideNewPassword(bool value) {
    _hideNewPassword = value;
    notifyListeners();
  }

  set hideConfirmNewPassword(bool value) {
    _hideConfirmNewPassword = value;
    notifyListeners();
  }

  // Optional: Helper method to check if passwords match
  bool doPasswordsMatch() {
    return newPasswordController.text == confirmNewPasswordController.text;
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<String?> resetPassword({
    required RequestFrom requesFrom,
    required String input,
    required String otp,
  }) async {
    String? message;
    if (newPasswordFormKey.currentState!.validate()) {
      if (newPasswordController.text == confirmNewPasswordController.text) {
        _isLoading = true;
        notifyListeners();

        String result = await reset.resetPassword(
            requestFrom: requesFrom,
            newPassword: newPasswordController.text,
            confrimNewPassword: confirmNewPasswordController.text,
            input: input,
            otp: otp);

        if (result.contains("Password Changed Successfully")) {
          message = null;
        } else {
          message = result;
        }
      } else {
        message = "Password doesn not match.";
      }
    }
    _isLoading = false;
    notifyListeners();
    return message;
  }
}
