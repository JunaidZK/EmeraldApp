import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppCheckBox extends StatelessWidget {
  bool value;
  final Color borderColor;
  final double borderWidth;
  Function(bool?)? changed;
  final Color activeColor;
  AppCheckBox(
      {required this.value,
      this.changed,
      this.borderColor = grayColor,
      this.borderWidth = 0.25,
      this.activeColor = primaryColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: activeColor,
      value: value,
      onChanged: changed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: borderColor, width: borderWidth),
      ),
      side: BorderSide(color: borderColor, width: borderWidth),
    );
  }
}
