import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppBottomSheet extends StatelessWidget {
  final String svg;
  final String title;
  final String subTitle;
  final String cancelText;
  final String okText;
  final Function()? cancelTap;
  final Function()? okTap;
  final bool oneButton;
  const AppBottomSheet(
      {required this.svg,
      required this.title,
      required this.subTitle,
      this.cancelText = "",
      required this.okText,
      this.cancelTap,
      this.okTap,
      this.oneButton = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 1.5.h),
        AppSvg(
          svgName: svg,
          width: 5.w,
          height: 7.5.h,
        ),
        SizedBox(height: 2.h),
        AppTextBold(
          text: title,
          color: Theme.of(context).primaryColor,
          fontSize: 19.sp,
          fontFamily: FontFamily.hermann,
        ),
        SizedBox(height: 1.5.h),
        AppTextMedium(
          text: subTitle,
          color: grayColor,
          fontFamily: FontFamily.raleway,
          fontSize: 16.sp,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 0.75.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !oneButton,
              child: App3DButton(
                width: 35.w,
                height: 4.25.h,
                backgroundColor: Theme.of(context).primaryColor,
                borderColor: greenishBlack,
                tap: cancelTap,
                child: AppTextBold(
                  text: cancelText,
                  color: whiteColor,
                  fontFamily: FontFamily.raleway,
                  fontSize: 17.sp,
                ),
              ),
            ),
            SizedBox(width: 1.w),
            App3DButton(
              width: !oneButton ? 35.w : 45.w,
              height: 4.25.h,
              backgroundColor: lightTurquoise,
              borderColor: greenishBlack,
              tap: okTap,
              child: AppTextBold(
                text: okText,
                color: Theme.of(context).primaryColor,
                fontFamily: FontFamily.raleway,
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5.h)
      ],
    );
  }
}
