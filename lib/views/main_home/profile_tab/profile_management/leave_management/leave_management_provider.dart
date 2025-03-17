import 'package:emerald_beauty/api_classes/profile/profile_management/leave_management.dart';
import 'package:emerald_beauty/model_class/profile/profile_management/leave_management.dart';
import 'package:flutter/material.dart';

class LeaveManagementProvider extends ChangeNotifier {
  LeaveManagement api = LeaveManagement();
  LeaveResponse? leaves;
  Future<void> getAllLeaves() async {
    leaves = await api.getLeaves();
    notifyListeners();
  }
}
