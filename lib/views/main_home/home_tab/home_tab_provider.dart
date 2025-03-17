import 'package:emerald_beauty/api_classes/home_tab/booking_analytics.dart';
import 'package:emerald_beauty/api_classes/home_tab/employee_service.dart';
import 'package:emerald_beauty/api_classes/home_tab/graph_api.dart';
import 'package:emerald_beauty/model_class/chart_data.dart';
import 'package:emerald_beauty/model_class/home_tab/booking_analytics.dart';
import 'package:emerald_beauty/model_class/home_tab/employee_services.dart';
import 'package:emerald_beauty/model_class/home_tab/graph.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabProvider extends ChangeNotifier {
  BuildContext context;
  BookingAnalytics bookingAnalyticsApi = BookingAnalytics();
  GraphApi graphApi = GraphApi();
  EmployeeService employeeServicesApi = EmployeeService();

  BookingAnalyticsResponse? bookingAnalytics;
  GraphResponse? graphResponse;
  EmployeeServices? employeeServices;

  HomeTabProvider(this.context);

  Future<void> getBookingAnalytics() async {
    bookingAnalytics = await bookingAnalyticsApi.getBookingAnalytics();
    notifyListeners();
  }

  Future<void> getServices() async {
    employeeServices = await employeeServicesApi.getEmployeeServices();
    notifyListeners();
  }

  Future<void> fetchGraphData() async {
    graphResponse = await graphApi.getGraphResposne();
    notifyListeners();
  }

  List<SalesData> getGraphData() {
    return graphResponse?.data
            .map((dayData) => SalesData(dayData.day, dayData.completedCount))
            .toList() ??
        [];
  }

  List<Map<String, dynamic>> get freelancerData {
    return [
      {
        'headerText':
            bookingAnalytics?.data.firstOrNull?.meta.totalEarnings.toString() ??
                "0",
        "subText": "Total Earning"
      },
      {
        'headerText': Provider.of<MainHomeProvider>(context, listen: false)
                .bookings
                ?.data
                .meta
                .total
                .toString() ??
            "0",
        "subText": "Total Reviews"
      },
      {
        'headerText': bookingAnalytics?.data.firstOrNull?.meta.completedBookings
                .toString() ??
            "0",
        "subText": "Complete Job"
      },
      {
        'headerText': employeeServices?.meta!.total.toString() ?? "0",
        "subText": "No. of Services"
      },
    ];
  }

  List<Map<String, dynamic>> get employeeData {
    return [
      {
        'headerText': Provider.of<MainHomeProvider>(context, listen: false)
                .bookings
                ?.data
                .meta
                .total
                .toString() ??
            "0",
        "subText": "Total Reviews"
      },
      {
        'headerText': bookingAnalytics?.data.firstOrNull?.meta.completedBookings
                .toString() ??
            "0",
        "subText": "Complete Job"
      },
      {
        'headerText': employeeServices?.meta!.total.toString() ?? "0",
        "subText": "No. of Services"
      },
    ];
  }
}
