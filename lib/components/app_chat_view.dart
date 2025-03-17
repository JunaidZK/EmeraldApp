import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppChatView extends StatelessWidget {
  final String? userImage;
  final String chatPerson;
  final String lastMessage;
  final String messageTime;
  final bool seen;
  final int notSeen;
  final Function()? tapFunctionality;
  const AppChatView(
      {this.userImage,
      required this.chatPerson,
      required this.lastMessage,
      required this.messageTime,
      this.seen = false,
      this.notSeen = 0,
      this.tapFunctionality,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: GestureDetector(
        onTap: tapFunctionality,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    whiteBorderColor, // Choose your desired color for the border
                width: 1.0, // Choose your desired width for the border
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppCircularImage(
                    imgHeight: 5.h,
                    networkImage: userImage,
                  ),
                  SizedBox(width: 1.5.w),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextBold(
                              text: chatPerson,
                              fontFamily: FontFamily.hermann,
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.sp,
                            ),
                            AppTextThin(
                              text: messageTime,
                              fontFamily: FontFamily.hermann,
                              color: lightGray,
                              fontSize: 13.5.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AppTextRegular(
                                text: lastMessage,
                                fontFamily: FontFamily.hermann,
                                color: grayColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            // Visibility(
                            //   visible: !seen,
                            //   child: Padding(
                            //     padding: EdgeInsets.only(right: width * 0.03),
                            //     child: AppCircleShape(
                            //       borderWidth: 0,
                            //       borderColor: null,
                            //       horizontalPadding: 5,
                            //       verticalPadding: 2.5,
                            //       widget: AppTextSemiBold(
                            //         text:
                            //             notSeen == 0 ? " " : notSeen.toString(),
                            //         color: whiteColor,
                            //         fontSize: (width * height) * 0.00003,
                            //         fontFamily: FontFamily.raleway,
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 1.5.h),
            ],
          ),
        ),
      ),
    );
  }
}
