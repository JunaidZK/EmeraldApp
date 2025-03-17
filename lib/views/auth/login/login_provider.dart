import 'package:emerald_beauty/api_classes/auth/login.dart';
import 'package:emerald_beauty/constant_values/api_urls.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/firebase/firestore.dart';
import 'package:emerald_beauty/model_class/user/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  Login loginApi = Login();
  FirestoreUser fireStore = FirestoreUser();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController inputField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();

  bool _hidePassword = true;

  bool _checkBoxValue = false;

  bool _isLoading = false;

  String _phoneNumberWithCountryCode = '';

  bool get hidePassword => _hidePassword;

  bool get checkBoxValue => _checkBoxValue;

  bool get isLoading => _isLoading;

  String get phoneNumberWithCountryCode => _phoneNumberWithCountryCode;

  set hidePassword(bool value) {
    _hidePassword = value;
    notifyListeners();
  }

  set checkBoxValue(bool val) {
    _checkBoxValue = val;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumberWithCountryCode = phoneNumber;
    notifyListeners();
  }

  Future<String?> login({required RequestFrom requesFrom, required Users user}) async {
    String? msg;
    if (loginFormKey.currentState!.validate()) {
      _isLoading = true;
      notifyListeners();

      dynamic result = await loginApi.loginUser(
          requestFrom: requesFrom, user: user, input: requesFrom == RequestFrom.email ? inputField.text : _phoneNumberWithCountryCode, password: passwordField.text);

      if (result is UserModel) {
        if (!result.data.user.isVerified) {
          msg = "OTP verification incomplete";
        } else if (!result.data.user.isApproved) {
          msg = "Account not verified by admin";
        } else {
          ApiUrls.token = "${result.data.accessToken.type} ${result.data.accessToken.token}";
          ApiUrls.userId = result.data.user.id;

          await fireStore.saveUsers(
              requestFrom: requesFrom,
              userId: result.data.user.id,
              input: requesFrom == RequestFrom.email ? result.data.user.email! : result.data.user.phone!,
              firstName: result.data.user.firstName,
              lastName: result.data.user.lastName,
              profilePic: result.data.user.userImage?.path);
          await FirebaseMessaging.instance.subscribeToTopic(result.data.user.id.toString());
          msg = null;
        }
      } else if (result is String) {
        msg = result;
      }
      _isLoading = false;
      notifyListeners();
    }
    return msg;
  }
}
