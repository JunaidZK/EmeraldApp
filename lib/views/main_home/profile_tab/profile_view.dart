import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_bottom_sheet.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_logout.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileView extends StatelessWidget {
  final ScrollController controller;
  final Users user;
  final RequestFrom requestFrom;
  const ProfileView(
      {this.user = Users.employee,
      required this.controller,
      required this.requestFrom,
      super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(user),
      child: Consumer2<ProfileProvider, MainHomeProvider>(
          builder: (context, value, mainProvider, child) {
        return Scaffold(
          appBar: appBar(context,
              leftIcon: null,
              title: null,
              leftWidget: null,
              color: Theme.of(context).primaryColor,
              textColor: whiteColor,
              widgets: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      Align(
                          alignment: localization!.locale.languageCode == "en"
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: AppTextBold(
                              text: localization.translate("MY ACCOUNT"),
                              color: whiteColor,
                              fontFamily: FontFamily.hermann,
                              fontSize: 18.sp)),
                      SizedBox(height: 2.5.h),
                      AppCircularImage(
                          networkImage: mainProvider
                              .userProfile!.data!.profile!.userImage?.path,
                          imgHeight: 8.h,
                          borderColor: lightTurquoise),
                      SizedBox(height: 1.h),
                      AppTextSemiBold(
                          text:
                              "${mainProvider.userProfile!.data!.profile!.firstName} ${mainProvider.userProfile!.data!.profile!.lastName}",
                          fontFamily: FontFamily.hermann,
                          fontSize: 18.sp),
                      SizedBox(height: 0.75.h),
                      AppTextMedium(
                        text: requestFrom == RequestFrom.email
                            ? mainProvider.userProfile!.data!.profile!.email !=
                                    null
                                ? mainProvider
                                    .userProfile!.data!.profile!.email!
                                : ""
                            : requestFrom == RequestFrom.phone
                                ? mainProvider.userProfile!.data!.profile!
                                            .phone !=
                                        null
                                    ? mainProvider
                                        .userProfile!.data!.profile!.phone!
                                    : ""
                                : "",
                        fontSize: 14.sp,
                        color: whiteColor,
                        fontFamily: FontFamily.raleway,
                      ),
                      // SizedBox(height: 1.h),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     AppTextSemiBold(
                      //       text: value.switcher ? "Active" : "Inactive",
                      //       fontFamily: FontFamily.raleway,
                      //       color: whiteColor,
                      //       fontSize: 17.sp,
                      //     ),
                      //     SizedBox(width: 2.w),
                      //     AppSwithcer(
                      //         swithcerValue: value.switcher,
                      //         valueChanged: (val) {
                      //           value.toggleSwitcher();
                      //         }),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              appBarheight: 25.h),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
            child: ListView.builder(
                controller: controller,
                itemCount: value.buttons[0].keys.length,
                itemBuilder: (context, index) {
                  String section = value.buttons[0].keys.elementAt(index);
                  List<Map<String, String>>? items = value.buttons[0][section];
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: AppBox(
                            elevation: 0,
                            bgColor: whiteColor,
                            borderColor: greenishBlack,
                            borderWidth: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.5.w, vertical: 1.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: section != "LOGOUT",
                                    child: AppTextSemiBold(
                                      text: localization.translate(section),
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: FontFamily.raleway,
                                      fontSize:
                                          localization.locale.languageCode ==
                                                  "en"
                                              ? 16.sp
                                              : 14.5.sp,
                                    ),
                                  ),
                                  Visibility(
                                      visible: section != "LOGOUT",
                                      child: SizedBox(height: 1.h)),
                                  ListView.builder(
                                    shrinkWrap:
                                        true, // Shrinks the ListView to its content size
                                    physics:
                                        const NeverScrollableScrollPhysics(), // Disables inner ListView scrolling
                                    itemCount: items!.length,
                                    itemBuilder: (context, itemIndex) {
                                      var item = items[itemIndex];
                                      bool isLastItem =
                                          itemIndex == items.length - 1;

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    item['name'] == 'Logout'
                                                        ? 0
                                                        : 0.5.h),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (item["name"] == "Logout") {
                                                  bottomSheet(context,
                                                      const AppLogout());
                                                } else {
                                                  value.navigateToScreen(
                                                      context,
                                                      item["name"]!,
                                                      mainProvider,
                                                      user);
                                                }
                                              },
                                              child: AppBox(
                                                elevation: 0,
                                                bgColor: whiteColor,
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        AppSvg(
                                                            svgName:
                                                                item['icon']!),
                                                        SizedBox(width: 2.w),
                                                        AppTextMedium(
                                                          text: localization
                                                              .translate(item[
                                                                  'name']!),
                                                          fontFamily: FontFamily
                                                              .raleway,
                                                          fontSize: 14.sp,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Transform.flip(
                                                      flipX: localization.locale
                                                              .languageCode ==
                                                          "ar",
                                                      child: const AppSvg(
                                                          svgName:
                                                              arrowForward),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (!isLastItem)
                                            Divider(
                                              height: 0.1.h,
                                              color: whitishGray,
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  );
                }),
          ),
        );
      }),
    );
  }
}
