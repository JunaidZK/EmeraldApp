import 'package:emerald_beauty/api_classes/auth/me.dart';
import 'package:emerald_beauty/api_classes/home_tab/employee_service.dart';
import 'package:emerald_beauty/model_class/home_tab/employee_services.dart';
import 'package:emerald_beauty/model_class/user/user_info/user_info.dart';
import 'package:flutter/material.dart';

class ViewProfileProvider extends ChangeNotifier {
  Me profileApi = Me();
  EmployeeService employeeService = EmployeeService();
  ProfileResponse? userProfileResponse;
  EmployeeServices? employeeExpertise;

  // List<String> expertise = [
  //   "Classic Cuts",
  //   "Modern Styles",
  //   "Hair Treatments",
  //   "Hair Colring",
  //   "Stylish Beard",
  // ];

  Future<void> fetchUserProfile() async {
    userProfileResponse = await profileApi.fetchUserProfile();
    notifyListeners();
  }

  Future<void> employeeExpertiseResponse() async {
    employeeExpertise = await employeeService.getEmployeeServices();
    notifyListeners();
  }
}
