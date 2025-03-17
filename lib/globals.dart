import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {
  RequestFrom? _globalRequestFrom;

  RequestFrom? get globalRequestFrom => _globalRequestFrom;

  set globalRequestFrom(RequestFrom? val) {
    // Accepts nullable type
    _globalRequestFrom = val;
    notifyListeners();
  }

  Users _globalUser = Users.employee;

  Users get globalUser => _globalUser;

  set globalUser(Users val) {
    // Accepts nullable type
    _globalUser = val;
    notifyListeners();
  }
}
