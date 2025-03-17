import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:flutter/material.dart';

class AppBox extends StatelessWidget {
  final double? elevation;
  final ShapeBorder? shape;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderWidth;
  final Widget child;

  const AppBox({
    this.elevation,
    this.bgColor = dimGreenishColor,
    this.borderColor, // Optional border color
    this.borderWidth, // Optional border width
    this.shape,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            side: borderColor != null && borderWidth != null
                ? BorderSide(color: borderColor!, width: borderWidth!)
                : BorderSide.none, // Default to no border if not provided
          ),
      color: bgColor,
      child: child,
    );
  }
}
