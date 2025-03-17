import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:flutter/material.dart';

class AppCircleShape extends StatelessWidget {
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? bgColor;
  final Function()? action;
  final double? borderWidth;
  final Widget widget;
  final Color? borderColor;
  const AppCircleShape({
    this.horizontalPadding = 2.0,
    this.verticalPadding = 0.5,
    this.bgColor = lightTurquoise,
    this.action,
    required this.widget,
    this.borderWidth,
    this.borderColor = greenishBlack,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding!, vertical: verticalPadding!),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? greenishBlack,
            width: borderWidth ?? 0.5
          )
        ),
        child: widget,
      ),
    );
  }
}
