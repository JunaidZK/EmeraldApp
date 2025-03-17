import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/model_class/home_tab/employee_services.dart';
import 'package:emerald_beauty/model_class/services/service_by_id.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailedServiceView extends StatelessWidget {
  final ServiceByIdResponse service;
  final ServiceData employeeService;
  const DetailedServiceView(
      {required this.service, required this.employeeService, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverAppBarDelegate(
                      minHeight: 36.h,
                      maxHeight: 40.h,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            AppNetworkImage(
                              image: service.data.coverPhoto.path,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 7.5.h,
                                  left:
                                      localization!.locale.languageCode == "en"
                                          ? 5.w
                                          : 0.w,
                                  right:
                                      localization.locale.languageCode == "ar"
                                          ? 5.w
                                          : 0.w),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Transform.flip(
                                      flipX: localization.locale.languageCode ==
                                          "ar",
                                      child: AppSvg(
                                        svgName: arrowBack,
                                        color: Colors.white,
                                        boxfit: BoxFit.cover,
                                        width: 5.0.w,
                                        height: 3.h,
                                      ),
                                    ),
                                    SizedBox(width: 4.5.w),
                                    AppTextBold(
                                      text: localization.translate("DETAIL"),
                                      fontFamily: FontFamily.raleway,
                                      fontSize: 17.sp,
                                      color: whiteColor,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextBold(
                              text: localization.locale.languageCode == "en"
                                  ? service.data.name
                                  : service.data.arabicName,
                              color: Theme.of(context).primaryColor,
                              fontFamily: FontFamily.raleway,
                              fontSize: 17.5.sp,
                            ),
                            AppTextBold(
                              text: employeeService.price != 0
                                  ? employeeService.price.toString()
                                  : service.data.price.toString(),
                              fontFamily: FontFamily.raleway,
                              fontSize: 17.5.sp,
                              color: lightTurquoise,
                            )
                          ],
                        ),
                        SizedBox(height: 2.h),
                        AppTextSemiBold(
                          text: localization.translate("Description"),
                          fontFamily: FontFamily.raleway,
                          fontSize: 16.5.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Divider(
                          color: lightGray,
                        ),
                        SizedBox(height: 0.5.h),
                        AppTextRegular(
                          text: localization.locale.languageCode == "en"
                              ? service.data.description
                              : service.data.arabicDescription,
                          fontFamily: FontFamily.hermann,
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(height: 2.h),
                        Visibility(
                          visible: employeeService.portfolio.isNotEmpty,
                          child: AppTextSemiBold(
                            text: localization.translate("Portfolio"),
                            color: Theme.of(context).primaryColor,
                            fontFamily: FontFamily.raleway,
                            fontSize: 16.5.sp,
                          ),
                        ),
                        Visibility(
                          visible: employeeService.portfolio.isNotEmpty,
                          child: const Divider(
                            color: lightGray,
                          ),
                        ),
                        Visibility(
                            visible: employeeService.portfolio.isNotEmpty,
                            child: SizedBox(height: 1.h)),
                        Visibility(
                          visible: employeeService.portfolio.isNotEmpty,
                          child: Wrap(
                              runSpacing: 10.0,
                              spacing: 10.0,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              children:
                                  employeeService.portfolio.map((portfolio) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: AppNetworkImage(
                                    image: portfolio.path,
                                    width: 29.5.w,
                                    height: 13.h,
                                  ),
                                );
                              }).toList()

                              // List.generate(6, (index) {
                              //   return ClipRRect(
                              //     borderRadius: BorderRadius.circular(16.0),
                              //     child: AppImage(
                              //       image: serviceImage,
                              //       width: 29.5.w,
                              //       height: 13.h,
                              //     ),
                              //   );
                              // }),
                              ),
                        ),
                      ],
                    ),
                  ))
                ],
              )),
        ));
  }
}
