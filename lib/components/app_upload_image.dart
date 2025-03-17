import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppUploadImage extends StatelessWidget {
  final String? imageLink;
  const AppUploadImage({this.imageLink, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppCircularImage(networkImage: imageLink, imgHeight: 75),
        SizedBox(width: 2.5.w),
        const AppSvg(svgName: uploadImage),
        SizedBox(width: 1.w),
        AppTextRegular(
          text: "Upload Profile Picture",
          fontSize: 17.sp,
          color: Theme.of(context).primaryColor,
          fontFamily: FontFamily.hermann,
        )
      ],
    );
  }
}
