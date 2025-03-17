import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppVerticalTextImageData extends StatelessWidget {
  final String image;
  final String serviceText;
  final String priceText;
  // final String statusText;
  const AppVerticalTextImageData(
      {required this.image,
      required this.serviceText,
      required this.priceText,
      // required this.statusText,
      super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60.w,
          height: 12.5.h,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0)),
        ),
        SizedBox(height: 0.75.h),
        AppTextSemiBold(
          text: serviceText,
          color: Theme.of(context).primaryColor,
          fontFamily: FontFamily.raleway,
          fontSize: localization!.locale.languageCode == "en" ? 16.sp : 13.5.sp,
        ),
        SizedBox(height: 0.15.h),
        AppTextSemiBold(
          text: priceText,
          color: lightTurquoise,
          fontFamily: FontFamily.raleway,
          fontSize: 15.sp,
        ),
        // SizedBox(height: 0.1.h),
        // Row(
        //   children: [
        //     AppTextMedium(
        //       text: "Status",
        //       fontFamily: FontFamily.raleway,
        //       fontSize: 15.75.sp,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //     SizedBox(width: 1.w),
        //     AppTextSemiBold(
        //       text: statusText,
        //       fontFamily: FontFamily.raleway,
        //       fontSize: 15.25.sp,
        //       color: brightGreen,
        //     ),
        //   ],
        // ),
        SizedBox(height: 0.4.h),
      ],
    );
  }
}
