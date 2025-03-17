import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final Function()? tap;
  final String text;
  final FontFamily? fontFamily;
  final double? fontSize;
  final Color? textColor;
  const AppTextButton({
    this.tap,
    required this.text,
    this.fontFamily = FontFamily.hermann,
    this.fontSize = 12.0,
    this.textColor = lightTurquoise,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: AppTextMedium(
        text: text,
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: textColor,
      ),
    );
  }
}