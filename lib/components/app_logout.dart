import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/auth/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppLogout extends StatelessWidget {
  const AppLogout({super.key});

  @override
  Widget build(BuildContext context) {
    final localiztion = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 2.5.h,
          ),
          const AppSvg(svgName: alert),
          SizedBox(height: 1.5.h),
          AppTextBold(
            text: localiztion!.translate("LOGOUT ACCOUNT"),
            color: Theme.of(context).primaryColor,
            fontFamily: FontFamily.raleway,
            fontSize: 20.sp,
          ),
          SizedBox(height: 1.5.h),
          AppTextThin(
            text: localiztion.translate(
                "Are you sure want to logout? Once you logout you need to login again. Are you OK?"),
            fontSize: 15.sp,
            fontFamily: FontFamily.raleway,
            color: grayColor,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              App3DButton(
                backgroundColor: Theme.of(context).primaryColor,
                borderColor: greenishBlack,
                width: 35.w,
                height: 4.5.h,
                tap: () {
                  Navigator.pop(context);
                },
                child: AppTextBold(
                  text: localiztion.translate("NO"),
                  color: whiteColor,
                  fontFamily: FontFamily.raleway,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(width: 1.5.w),
              App3DButton(
                backgroundColor: lightTurquoise,
                borderColor: Theme.of(context).primaryColor,
                width: 35.w,
                height: 4.5.h,
                tap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SplashView()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: AppTextBold(
                  text: localiztion.translate("YES"),
                  color: Theme.of(context).primaryColor,
                  fontFamily: FontFamily.raleway,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h)
        ],
      ),
    );
  }
}
