import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDottedUpload extends StatelessWidget {
  final String? text;
  final String svg;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final EdgeInsets innerPadding;
  const AppDottedUpload({
    this.text,
    this.svg = uploadDocuments,
    this.padding,
    this.width,
    this.height,
    this.innerPadding = EdgeInsets.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: lightGray,
      padding: innerPadding,
      borderPadding: padding ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            AppSvg(
              svgName: svg,
            ),
            SizedBox(width: 2.5.w),
            if (text != null)
              AppTextMedium(
                text: text!,
                color: Theme.of(context).primaryColor,
                fontSize: 14.5.sp,
              ),
          ],
        ),
      ),
    );
  }
}
