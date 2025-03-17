import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppVerticalTextData extends StatelessWidget {
  final String headerText;
  final Color? headerTextColor;
  final FontFamily? headerFont;
  final double? headerSize;
  final String subText;
  final Color? subTextColor;
  final FontFamily? subTextFont;
  final double? subSize;
  const AppVerticalTextData(
      {required this.headerText,
      this.headerTextColor,
      this.headerFont,
      this.headerSize,
      required this.subText,
      this.subTextColor,
      this.subTextFont,
      this.subSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextHeavyBold(
          text: headerText,
          color: headerTextColor,
          fontFamily: headerFont,
          fontSize: headerSize,
        ),
        SizedBox(height: 1.h),
        AppTextMedium(
          text: subText,
          color: subTextColor,
          fontFamily: subTextFont,
          fontSize: subSize,
        )
      ],
    );
  }
}
