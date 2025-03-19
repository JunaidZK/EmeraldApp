import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/app_search_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/main_home/message_tab/chat/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppChatTypo extends StatelessWidget {
  final VoidCallback? sendBtn;
  final VoidCallback? emojiTap;
  final VoidCallback? fileTap;
  const AppChatTypo({this.sendBtn, this.emojiTap, this.fileTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h, bottom: 1.h),
        child: Row(children: [
          InkWell(onTap: fileTap, child: const AppSvg(svgName: attachments)),
          SizedBox(width: 3.w),
          Expanded(
              child: AppSearchField(
                  cntrller: Provider.of<ChatProvider>(context, listen: false).message,
                  text: "Type a message",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                  fillColor: whiteTextFieldColor,
                  icon: IconButton(
                      onPressed: emojiTap,
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: lightGray,
                      )),
                  submitLabel: TextInputAction.newline)),
          SizedBox(width: 3.w),
          AppCircleShape(borderColor: lightTurquoise, horizontalPadding: 1.5.w, verticalPadding: 1.h, widget: GestureDetector(onTap: sendBtn, child: const AppSvg(svgName: send)))
        ]));
  }
}
