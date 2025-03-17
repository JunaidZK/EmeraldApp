import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AppSwithcer extends StatelessWidget {
  final bool swithcerValue;
  final Function(bool) valueChanged;
  final Color activeColor;
  final Color? borderColor;
  const AppSwithcer({
    required this.swithcerValue,
    required this.valueChanged,
    this.activeColor = brightGreen,
    this.borderColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      value: swithcerValue, 
      onToggle: valueChanged,
      height: 18,
      width: 35,
      activeColor: activeColor,
      inactiveColor: whiteColor,
      inactiveToggleColor: lightGray,
      padding: 0,
      toggleSize: 15.0,
      switchBorder: borderColor != null 
        ? Border.all(
          color: borderColor!,
          width: 0.5,
        ) : null
    );
  }
}