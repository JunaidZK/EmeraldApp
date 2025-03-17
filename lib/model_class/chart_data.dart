import 'package:flutter/material.dart';

class SalesData {
  SalesData(this.day, this.sales);
  final String day;
  final int sales;
}

class ChartData {
  ChartData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}
