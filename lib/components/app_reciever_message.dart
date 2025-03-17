import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppReceiverMessage extends StatelessWidget {
  final String message;
  final Color color;
  final String messageTime;

  const AppReceiverMessage(
      {required this.message,
      this.color = primaryColor,
      required this.messageTime,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.65.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppTextMedium(
            text: message,
            color: whiteColor,
            fontSize: 15.sp,
            fontFamily: FontFamily.raleway,
          ),
          SizedBox(height: 1.h),
          AppTextThin(
            text: messageTime,
            color: whitishGray,
            fontFamily: FontFamily.raleway,
            fontSize: 12.sp,
          ),
        ],
      ),
    );
  }
}
