import 'package:emerald_beauty/api_classes/home_tab/employee_service.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/model_class/home_tab/employee_services.dart';
import 'package:emerald_beauty/model_class/services/service_by_id.dart';
import 'package:flutter/material.dart';

class MyServicesProvider extends ChangeNotifier {
  EmployeeService servicesApi = EmployeeService();
  EmployeeServices? employeeServices;
  List<ServiceByIdResponse> serviceDetails = [];
  List<ServiceByIdResponse> filteredServices = [];
  final TextEditingController searchController = TextEditingController();

  MyServicesProvider() {
    searchController.addListener(_filterServices);
  }

  Future<void> fetchAllEmployeeServices() async {
    serviceDetails.clear();
    try {
      employeeServices = await servicesApi.getEmployeeServices();

      // If no data is returned, handle the empty state
      if (employeeServices == null || employeeServices!.data.isEmpty) {
        filteredServices = [];
        notifyListeners();
        return;
      }

      for (var service in employeeServices!.data) {
        try {
          ServiceByIdResponse? serviceDetail =
              await servicesApi.getServicesbyId(serviceId: service.serviceId);
          if (serviceDetail != null) {
            serviceDetails.add(serviceDetail);
          }
        } catch (e) {
          debugPrint("Error fetching service details: $e");
        }
      }

      filteredServices =
          List.from(serviceDetails); // Initially show all services
    } catch (e) {
      debugPrint("Error fetching employee services: $e");
      employeeServices = EmployeeServices(
        status: false,
        message: "No records found",
        meta: null, // Set it to `null` or provide an appropriate default value
        data: [],
      ); // Prevents null errors
      filteredServices = [];
    } finally {
      notifyListeners();
    }
  }

  void _filterServices() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredServices = List.from(serviceDetails);
    } else {
      filteredServices = serviceDetails
          .where((service) =>
              service.data.name.toLowerCase().contains(query) ||
              service.data.description.toLowerCase().contains(query))
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.removeListener(_filterServices);
    searchController.dispose();
    super.dispose();
  }
}
