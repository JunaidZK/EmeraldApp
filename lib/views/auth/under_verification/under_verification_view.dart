import 'dart:io';

import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnderVerificationView extends StatelessWidget {
  const UnderVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
            child: CustomScrollView(slivers: <Widget>[
          const AppSilverBar(),
          SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.h),
                        AppTextSemiBold(
                          text: "YOUR ACCOUNT IS\nUNDER REVIEW",
                          color: primaryColor,
                          fontSize: 23.sp,
                          textAlign: TextAlign.center,
                          fontFamily: FontFamily.raleway,
                        ),
                        SizedBox(height: 2.5.h),
                        AppTextMedium(
                          text:
                              "It usually takes us around a day. We'll notify you when the review is finished. If we can confirm your info, you'll be able to use App. If we can't, your account will be permanently disabled.",
                          fontFamily: FontFamily.raleway,
                          fontSize: 16.sp,
                          textAlign: TextAlign.center,
                          color: Theme.of(context).primaryColor,
                        )
                      ])))
        ])),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              App3DButton(
                tap: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
                backgroundColor: Theme.of(context).primaryColor,
                borderColor: greenishBlack,
                child: AppTextSemiBold(
                  text: "CLOSE",
                  color: whiteColor,
                  fontFamily: FontFamily.raleway,
                  fontSize: 17.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
