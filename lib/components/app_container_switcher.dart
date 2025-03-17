import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppContainerSwitcher extends StatelessWidget {
  final Function()? leftSideTap;
  final Color? leftSideColor;
  final String leftSideText;
  final Color? leftSideTextColor;
  final Function()? rightSideTap;
  final Color? rightSideColor;
  final String rightSideText;
  final Color? rightSideTextColor;
  const AppContainerSwitcher(
      {this.leftSideTap,
      this.leftSideColor = Colors.transparent,
      required this.leftSideText,
      this.leftSideTextColor,
      this.rightSideTap,
      this.rightSideColor = Colors.transparent,
      required this.rightSideText,
      this.rightSideTextColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: 5.h,
        decoration: const BoxDecoration(color: dimGreenishColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: leftSideTap,
              child: Container(
                width: (width / 2) - 3.w,
                height: 5.h,
                color: leftSideColor,
                child: Center(
                  child: AppTextBold(
                    text: leftSideText,
                    color: leftSideTextColor,
                    fontFamily: FontFamily.hermann,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: rightSideTap,
                child: Container(
                  width: (width / 2) - 3.w,
                  height: 5.h,
                  color: rightSideColor,
                  child: Center(
                    child: AppTextBold(
                      text: rightSideText,
                      color: rightSideTextColor,
                      fontFamily: FontFamily.hermann,
                      fontSize: 15.sp,
                    ),
                  ),
                ))
          ],
        ));
  }
}
