import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppVerticalDividerData extends StatelessWidget {
  final String service;
  final String serviceBy;
  final String dateTime;
  final String amount;

  const AppVerticalDividerData({
    required this.service,
    required this.serviceBy,
    required this.dateTime,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Service Title
        AppTextHeavyBold(
          text: service,
          color: Theme.of(context).primaryColor,
          fontFamily: FontFamily.raleway,
          fontSize: localization!.locale.languageCode == "en" ? 15.sp : 13.5.sp,
        ),
        SizedBox(height: 0.15.h),
        const Divider(
          color: lightGray,
        ),
        // SizedBox(height: height * 0.01),
        // Service Details
        AppTextMedium(
          text: "${localization.translate("Service Given To")}: $serviceBy",
          fontFamily: FontFamily.raleway,
          fontSize: 14.sp,
          color: grayColor,
        ),
        SizedBox(height: 0.75.h),
        AppTextMedium(
          text: "${localization.translate("Date & Time")}: $dateTime",
          fontFamily: FontFamily.raleway,
          fontSize: 13.sp,
          color: grayColor,
        ),
        SizedBox(height: 0.15.h),
        const Divider(
          color: lightGray,
        ),
        // SizedBox(height: height * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextSemiBold(
              text: localization.translate("Amount"),
              fontFamily: FontFamily.raleway,
              fontSize: 14.sp,
              textAlign: TextAlign.left,
            ),
            AppTextSemiBold(
              text: amount,
              fontFamily: FontFamily.raleway,
              fontSize: 14.sp,
              textAlign: TextAlign.end, // Align text to the right for clarity
            ),
          ],
        ),
      ],
    );
  }
}
