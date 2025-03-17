import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSenderMessage extends StatelessWidget {
  final String message;
  final Color color;
  final String messageTime;
  // final Chat chat;
  const AppSenderMessage(
      {required this.message,
      this.color = senderMsgColor,
      required this.messageTime,
      // this.chat = Chat.delivered,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.65.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppTextMedium(
            text: message,
            color: Theme.of(context).primaryColor,
            fontSize: 15.sp,
            fontFamily: FontFamily.raleway,
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextThin(
                text: messageTime,
                color: grayColor,
                fontFamily: FontFamily.raleway,
                fontSize: 12.sp,
              ),
              SizedBox(width: 0.5.w),
              // Icon(
              //     chat == Chat.seen || chat == Chat.delivered
              //         ? Icons.done_all
              //         : Icons.check,
              //   color: chat == Chat.seen
              //     ? lightTurquoise
              //     : grayColor,
              // )
            ],
          )
        ],
      ),
    );
  }
}
