import 'package:emerald_beauty/api_classes/profile/profile_management/change_password.dart';
import 'package:flutter/material.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();

  ChangePassword changePassword = ChangePassword();

  // Controllers for password fields
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  // Visibility flags for each password field
  bool _currentPasswordVisible = true;
  bool _newPasswordVisible = true;
  bool _confirmNewPasswordVisible = true;
  bool _isLoading = false;

  // Getters for password visibility
  bool get currentPasswordVisible => _currentPasswordVisible;
  bool get newPasswordVisible => _newPasswordVisible;
  bool get confirmNewPasswordVisible => _confirmNewPasswordVisible;
  bool get isLoading => _isLoading;

  // Methods to toggle password visibility
  void toggleCurrentPasswordVisibility() {
    _currentPasswordVisible = !_currentPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _newPasswordVisible = !_newPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmNewPasswordVisibility() {
    _confirmNewPasswordVisible = !_confirmNewPasswordVisible;
    notifyListeners();
  }

  // Method to check if the form is valid
  bool validatePasswords() {
    // Check if passwords match and not empty
    if (currentPassword.text.isEmpty) {
      return false;
    }
    if (newPassword.text.isEmpty || confirmNewPassword.text.isEmpty) {
      return false;
    }
    if (newPassword.text != confirmNewPassword.text) {
      return false;
    }
    return true;
  }

  Future<String?> passwordChange() async {
    String? responseMsg;

    _isLoading = true;
    notifyListeners();
    String result = await changePassword.changePassword(newPassword: newPassword.text, confirmNewPassword: confirmNewPassword.text, currentPassword: currentPassword.text);

    if (result.contains("password reset successfully")) {
      responseMsg = null;
    } else {
      responseMsg = result;
    }

    _isLoading = false;
    notifyListeners();
    return responseMsg;
  }

  // Method to clear all the password fields
  void clearPasswords() {
    currentPassword.clear();
    newPassword.clear();
    confirmNewPassword.clear();
    notifyListeners();
  }
}
