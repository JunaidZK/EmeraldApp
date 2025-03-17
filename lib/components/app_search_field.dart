import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController cntrller;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextStyle? style;
  final String? text;
  final Widget? icon;
  final Color? fillColor;
  final dynamic onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? submitLabel;
  final int? minLine;
  final int? maxLine;
  final EdgeInsetsGeometry? contentPadding;
  const AppSearchField(
      {required this.cntrller,
      this.border,
      this.enabledBorder,
      this.focusedBorder,
      this.style,
      this.text,
      this.icon,
      this.fillColor,
      this.keyboardType = TextInputType.text,
      this.submitLabel = TextInputAction.next,
      this.minLine,
      this.maxLine,
      this.onChanged,
      this.contentPadding,
      super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return TextField(
      maxLines: (minLine ?? 1) > 1 ? null : 1,
      minLines: minLine,
      controller: cntrller,
      keyboardType: keyboardType,
      textInputAction: submitLabel,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        contentPadding: contentPadding ??
            EdgeInsets.only(top: 0.5.h, bottom: 0.5.h, left: 3.w),
        border: border ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(color: lightGray, width: 1.5)),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(color: lightGray, width: 1.5)),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.0),
                borderSide: const BorderSide(color: lightGray, width: 1.5)),
        hintText: text ?? "${localization!.translate("Search here")}....",
        hintStyle: style ??
            TextStyle(
              color: lightGray,
              fontFamily: FontFamily.raleway.toString(),
              fontSize: 14.5.sp,
            ),
        suffixIcon: icon,
      ),
      style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontFamily:
              FontFamily.raleway.toString(), // Default color if none provided
          fontWeight: FontWeight.w200),
    );
  }
}
