import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppReviewData extends StatelessWidget {
  const AppReviewData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppCircularImage(
                  imgHeight: 4.h,
                ),
                SizedBox(width: 2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextSemiBold(
                      text: "John Peterson",
                      fontFamily: FontFamily.hermann,
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.sp,
                    ),
                    Row(
                        children: List.generate(5, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.25.w),
                        child: AppSvg(
                          svgName: stars,
                          width: 4.w,
                          height: 1.25.h,
                        ),
                      );
                    }))
                  ],
                )
              ],
            ),
            AppTextMedium(
              text: "6/4/2024",
              color: grayColor,
              fontFamily: FontFamily.raleway,
              fontSize: 14.sp,
            )
          ],
        ),
        SizedBox(height: 1.5.h),
        AppTextRegular(
          text:
              "Loved my haircut and color! The stylist was professional, and the salon was clean and welcoming. Will definitely return!",
          color: grayColor,
          fontFamily: FontFamily.raleway,
          fontSize: 14.sp,
        )
      ],
    );
  }
}
