import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/view_profile/view_portfolio/view_portfolio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/view_profile/view_profile_provider.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewProfileView extends StatefulWidget {
  const ViewProfileView({super.key});

  @override
  State<ViewProfileView> createState() => _ViewProfileViewState();
}

class _ViewProfileViewState extends State<ViewProfileView> {
  late ViewProfileProvider viewProfile;

  @override
  void initState() {
    super.initState();
    viewProfile = ViewProfileProvider();
    Future.microtask(() {
      viewProfile.fetchUserProfile();
      viewProfile.employeeExpertiseResponse();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
        create: (_) => viewProfile,
        child: Consumer<ViewProfileProvider>(builder: (context, value, child) {
          if (value.userProfileResponse == null) {
            return const Center(child: Loader());
          }

          final profile = value.userProfileResponse!.data!.profile;
          final expertiseList = value.employeeExpertise?.data ?? [];

          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                // Profile Header
                Container(
                  width: width,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(
                      left:
                          localization!.locale.languageCode == "en" ? 4.w : 0.w,
                      right:
                          localization.locale.languageCode == "ar" ? 4.w : 0.w,
                      top: 1.5.h),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Transform.flip(
                            flipX: localization.locale.languageCode == "ar",
                            child: const AppSvg(
                                svgName: arrowBack, color: whiteColor),
                          ),
                        ),
                        SizedBox(height: 1.75.h),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Row(
                            children: [
                              AppCircularImage(
                                networkImage: profile?.userImage?.path ?? "",
                                borderWidth: 6.0,
                                borderColor: whiteBorderColor,
                                imgHeight: 10.h,
                              ),
                              SizedBox(width: 3.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3.h),
                                  AppTextBold(
                                    text:
                                        "${profile?.firstName ?? ''} ${profile?.lastName ?? ''}",
                                    color: whiteColor,
                                    fontFamily: FontFamily.raleway,
                                    fontSize: 15.5.sp,
                                  ),
                                  AppTextSemiBold(
                                    text: profile?.email ?? "",
                                    color: whiteColor,
                                    fontFamily: FontFamily.raleway,
                                    fontSize: 15.5.sp,
                                  ),
                                  AppTextSemiBold(
                                    text: profile?.phone ?? "",
                                    color: whiteColor,
                                    fontFamily: FontFamily.raleway,
                                    fontSize: 15.5.sp,
                                  ),
                                  SizedBox(height: 1.75.h),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 2.5.h)
                      ],
                    ),
                  ),
                ),

                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          // Bio Section
                          if (profile?.bio != null && profile!.bio!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextBold(
                                  text: localization.translate("Bio"),
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: FontFamily.raleway,
                                  fontSize: 17.5.sp,
                                ),
                                const Divider(color: whiteBorderColor),
                                AppTextMedium(
                                  text: profile.bio!,
                                  fontFamily: FontFamily.hermann,
                                  color: grayColor,
                                  fontSize: 14.sp,
                                ),
                                SizedBox(height: 2.h),
                              ],
                            ),

                          // Expertise Section
                          AppTextBold(
                            text: localization.translate("Expertise"),
                            color: Theme.of(context).primaryColor,
                            fontFamily: FontFamily.raleway,
                            fontSize: 17.5.sp,
                          ),
                          const Divider(color: whiteBorderColor),
                          SizedBox(height: 2.h),
                          if (expertiseList.isNotEmpty)
                            Wrap(
                              spacing: 1.w,
                              runSpacing: 0.75.h,
                              children: expertiseList.map((expert) {
                                if (expert.service != null) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 0.25.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: AppTextMedium(
                                      text: localization.locale.languageCode ==
                                              "en"
                                          ? expert.service!.name
                                          : expert.service!.arabicName,
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: FontFamily.raleway,
                                      fontSize:
                                          localization.locale.languageCode ==
                                                  "en"
                                              ? 14.sp
                                              : 12.5.sp,
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }).toList(),
                            ),
                          SizedBox(height: 2.h),

                          // Portfolio Section
                          AppTextBold(
                              text: localization.translate("Portfolio"),
                              color: Theme.of(context).primaryColor,
                              fontFamily: FontFamily.raleway,
                              fontSize: 17.5.sp),
                          const Divider(),
                          SizedBox(height: 1.h),
                          if (expertiseList.isNotEmpty)
                            Center(
                                child: Wrap(
                                    spacing: 3.w,
                                    runSpacing: 1.h,
                                    children: expertiseList.map((portfolio) {
                                      if (portfolio.service != null) {
                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      AnimatedNavigation.bottomSlide(
                                                          ViewPortfolio(
                                                              portfolio:
                                                                  portfolio))),
                                                  child: Container(
                                                      width: 25.w,
                                                      height: 10.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  12.sp)),
                                                      child: portfolio.portfolio
                                                              .isNotEmpty
                                                          ? AppNetworkImage(
                                                              image: portfolio
                                                                  .portfolio
                                                                  .first
                                                                  .path,
                                                              width: 25.w,
                                                              fit: BoxFit.none)
                                                          : AppImage(
                                                              image:
                                                                  serviceImage,
                                                              width: 25.w,
                                                              fit: BoxFit.none))),
                                              SizedBox(height: 0.5.h),
                                              AppTextMedium(
                                                  text: localization.locale
                                                              .languageCode ==
                                                          "en"
                                                      ? portfolio.service!.name
                                                      : portfolio
                                                          .service!.arabicName,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontFamily:
                                                      FontFamily.hermann,
                                                  fontSize: localization.locale
                                                              .languageCode ==
                                                          "en"
                                                      ? 15.sp
                                                      : 13.sp)
                                            ]);
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }).toList()))
                        ]))
              ])));
        }));
  }
}
