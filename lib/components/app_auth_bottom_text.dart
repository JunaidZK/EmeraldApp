import 'package:emerald_beauty/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppAuthBottomText extends StatelessWidget {
  final String btnText;
  final String lightText;
  final String boldText;
  final void Function()? onBtnPressed;
  final void Function()? boldTextPressed;
  final bool isBtnHide;
  final bool isTextHide;
  final Color? lightTextColor;
  final Color? btnTextColor;
  const AppAuthBottomText(
      {super.key,
      this.btnText = "Login",
      this.lightText = "Don't have an account?",
      this.boldText = "Register",
      this.onBtnPressed,
      this.boldTextPressed,
      this.isBtnHide = false,
      this.isTextHide = false,
      this.lightTextColor,
      this.btnTextColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isTextHide)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextRegular(
                  text: lightText,
                  fontSize: 13.sp,
                  color: lightTextColor,
                ),
                SizedBox(
                  width: 1.5.w,
                ),
                GestureDetector(
                  onTap: boldTextPressed,
                  child: AppTextSemiBold(
                    text: boldText,
                    fontSize: 14.sp,
                    color: btnTextColor,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
