import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TabItem extends StatelessWidget {
  final String label;
  final String svgName;
  final int index;

  const TabItem(
      {required this.label,
      required this.svgName,
      required this.index,
      super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainHomeProvider>(context);
    final bool isActive = provider.isActiveTab(index);
    const Color activeColor = lightTurquoise;
    const Color inactiveColor = grayColor;
    final Color color = isActive ? activeColor : inactiveColor;
    final localization = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 0.75.h),
        AppSvg(
          svgName: svgName,
          width: 10.w,
          height: 2.h,
          color: color,
        ),
        SizedBox(height: 0.5.h),
        AppTextThin(
          text: label,
          fontSize: localization!.locale.languageCode == "en" ? 13.sp : 11.5.sp,
          color: color,
        ),
        SizedBox(height: 1.h),
      ],
    );
  }
}
