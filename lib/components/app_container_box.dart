import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppContainerBox extends StatelessWidget {
  final ShapeBorder? shape;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderWidth;
  final Widget child;
  final double? containerWidth;
  const AppContainerBox(
      {this.bgColor = dimGreenishColor,
      this.borderColor, // Optional border color
      this.borderWidth, // Optional border width
      this.shape,
      required this.child,
      this.containerWidth,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth ?? 55.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
        border: borderColor != null || borderWidth != null
            ? Border.all(color: borderColor!, width: borderWidth!)
            : null,
      ),
      child: child,
    );
  }
}
