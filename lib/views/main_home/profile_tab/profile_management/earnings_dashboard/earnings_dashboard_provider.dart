import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/model_class/circle_chart.dart';
import 'package:flutter/material.dart';

class EarningsDashboardProvider extends ChangeNotifier{
  var summary = [
    {
      "value": "\$15K",
      "name": "Total Revenue"
    },
    {
      "value": "\$1K",
      "name": "Total Earning"
    },
    {
      "value": "\$600",
      "name": "Commission Deduction"
    },
    {
      "value": "\$1.5K",
      "name": "Remaining balance"
    }
  ];

  var transactionHistory = [
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
    {
      "service": "Hair Cutting",
      "date_time": "6/4/2024, 6:52 PM",
      "amount": "255 AED"
    },
  ];

  final List<CircleChart> chartData = [
    CircleChart('Total Earning', 25.0, lightTurquoise),
    CircleChart('Total Revenue', 28.9, primaryColor),
    CircleChart('Commission Deduction', 13.6, primaryTextColor),
    CircleChart('Remaining Balance', 10.9, lightTealColor),
  ];

  var chartOverView = [
    {
      "color": primaryColor,
      "title": "Total Revenue",
      "amount": "\$1K",
      "p/l": "36.16%"
    },
    {
      "color": lightTurquoise,
      "title": "Total Earning",
      "amount": "\$15K",
      "p/l": "43.29%"
    },

    {
      "color": lightTealColor,
      "title": "Commission Deduction",
      "amount": "\$600",
      "p/l": "40.22%"
    },
    {
      "color": lightTurquoise,
      "title": "Remaining Balance",
      "amount": "\$1.5K",
      "p/l": "25.33%"
    }
  ];
}