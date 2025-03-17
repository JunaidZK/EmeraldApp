import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AppBar appBar(BuildContext context,
    {final Widget? leftWidget,
    final String? leftIcon,
    final String? title,
    final Widget? titleWidget,
    final List<Widget>? rightIcons,
    final bool centerTitle = false,
    final double? appBarheight,
    final Color? color,
    final Color? textColor,
    final Widget? widgets}) {
  return AppBar(
    toolbarHeight: appBarheight,
    leading: leftWidget ??
        (leftIcon != null
            ? AppSvg(
                svgName: leftIcon,
                alignment: Alignment.centerLeft,
              )
            : null),
    title: title != null
        ? AppTextBold(
            text: title,
            color: textColor ?? Theme.of(context).primaryColor,
            fontFamily: FontFamily.hermann,
            fontSize: 17.sp,
            textAlign: TextAlign.start,
          )
        : titleWidget,
    centerTitle: centerTitle,
    actions: rightIcons,
    backgroundColor: color,
    automaticallyImplyLeading: false,
    flexibleSpace: widgets,
  );
}
