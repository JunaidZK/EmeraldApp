import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class ContactUsProvider extends ChangeNotifier {
  String? getSocialMediaText(int type) {
    switch (type) {
      case 10:
        return Social.Facebook.name;
      case 20:
        return Social.Instagram.name;
      case 30:
        return Social.Linkedin.name;
      case 40:
        return Social.Twitter.name;
      case 50:
        return Social.Thread.name;
      default:
        return null;
    }
  }
}
