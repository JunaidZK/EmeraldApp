import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/localization/localization_provider.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/localization/language_support/language_support_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LanguageSupportView extends StatelessWidget {
  const LanguageSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => LanguageSupportProvider(),
      child: Consumer2<LanguageSupportProvider, LocaleProvider>(
        builder: (context, value, localeprovider, child) {
          return SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                appBar: appBar(context,
                    appBarheight: 8.h,
                    leftWidget: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Transform.flip(
                        flipX: localization!.locale.languageCode == "en"
                            ? false
                            : true,
                        child: const AppSvg(
                          svgName: arrowBack,
                          boxfit: BoxFit.none,
                        ),
                      ),
                    ),
                    title: localization.translate("LANGUAGE SUPPORT")),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    children: [
                      AppBox(
                          elevation: 0,
                          bgColor: whiteColor,
                          borderColor: greenishBlack,
                          borderWidth: 0.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 1.5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppTextBold(
                                  text: "عربي",
                                  fontFamily: FontFamily.tajawal,
                                  fontSize: 17.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Radio<String>(
                                  value: "ar",
                                  groupValue:
                                      localeprovider.locale.languageCode,
                                  onChanged: (val) {
                                    if (val != null) {
                                      localeprovider
                                          .setLocale(const Locale('ar'));
                                    }
                                  },
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 1.h),
                      AppBox(
                          elevation: 0,
                          bgColor: whiteColor,
                          borderColor: greenishBlack,
                          borderWidth: 0.5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 1.5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppTextBold(
                                  text: "English",
                                  fontFamily: FontFamily.raleway,
                                  fontSize: 17.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Radio<String>(
                                  value: "en",
                                  groupValue:
                                      localeprovider.locale.languageCode,
                                  onChanged: (val) {
                                    if (val != null) {
                                      localeprovider
                                          .setLocale(const Locale('en'));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(bottom: 2.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      App3DButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: greenishBlack,
                        width: 40.w,
                        height: 5.h,
                        tap: () {
                          Navigator.pop(context);
                        },
                        child: AppTextBold(
                          text: localization.translate("SAVE"),
                          color: whiteColor,
                          fontFamily: FontFamily.hermann,
                          fontSize: 19.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
