import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/api_classes/bookings/update_booking_status.dart';
import 'package:emerald_beauty/components/app_booking_request.dart';
import 'package:emerald_beauty/components/app_bottom_sheet.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/components/review/app_give_review.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/detailed_booking/detailed_booking_provider.dart';
import 'package:emerald_beauty/views/main_home/message_tab/chat/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailedBookingView extends StatelessWidget {
  final int bookingId;
  final String title;
  final String status;
  final String name;
  final String date;
  final String servicetime;
  final String serviceName;
  final String servicePrice;
  final int employeeId;
  const DetailedBookingView(
      {required this.bookingId,
      required this.title,
      required this.status,
      required this.name,
      required this.date,
      required this.servicetime,
      required this.serviceName,
      required this.servicePrice,
      required this.employeeId,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DetailedBookingProvider(),
        child: Consumer<DetailedBookingProvider>(
          builder: (context, provider, child) {
            final Color statusTextColor = provider.status == "Confirmed" || provider.status == "Completed"
                ? brightGreen
                : provider.status == "In Progress"
                    ? blueColor
                    : provider.status == "Cancelled"
                        ? redColor
                        : yellowColor;
            return Scaffold(
                appBar: appBar(context,
                    title: title, leftIcon: null, leftWidget: GestureDetector(onTap: () => Navigator.pop(context), child: const AppSvg(svgName: arrowBack, boxfit: BoxFit.none))),
                body: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                AppCircularImage(imgHeight: 6.h),
                                SizedBox(width: 1.w),
                                AppTextSemiBold(
                                  text: name,
                                  fontFamily: FontFamily.hermann,
                                  fontSize: 16.sp,
                                  color: brownishBlack,
                                )
                              ],
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                              AppTextSemiBold(text: provider.status, fontFamily: FontFamily.raleway, fontSize: 16.sp, color: statusTextColor),
                              GestureDetector(
                                onTap: () => Navigator.push(context, AnimatedNavigation.bottomSlide(ChatView(employeeId: employeeId))),
                                child:
                                    AppCircleShape(horizontalPadding: 2.w, verticalPadding: 1.5.h, bgColor: lightAqua, borderColor: lightAqua, widget: const AppSvg(svgName: chat)),
                              )
                            ])
                          ],
                        ),
                        // SizedBox(height: 1.h),
                        // AppTextSemiBold(
                        //   text: "Information",
                        //   fontFamily: FontFamily.hermann,
                        //   color: Theme.of(context).primaryColor,
                        //   fontSize: 16.sp,
                        // ),
                        // const Divider(
                        //   color: whiteShade,
                        // ),
                        // SizedBox(height: 0.5.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           children: [
                        //             AppSvg(
                        //               svgName: phone,
                        //               color: lightTurquoise,
                        //               width: 5.w,
                        //             ),
                        //             SizedBox(
                        //               width: 1.5.w,
                        //             ),
                        //             AppTextRegular(
                        //               text: "+971508846638",
                        //               fontFamily: FontFamily.raleway,
                        //               fontSize: 14.sp,
                        //               color: Theme.of(context).primaryColor,
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: 2.h,
                        //         ),
                        //         Row(
                        //           children: [
                        //             AppSvg(
                        //               svgName: address,
                        //               color: lightTurquoise,
                        //               width: 5.w,
                        //             ),
                        //             SizedBox(
                        //               width: 1.5.w,
                        //             ),
                        //             AppTextRegular(
                        //               text:
                        //                   "Street: Palm Terrace, 6, Shoreline Street",
                        //               fontFamily: FontFamily.raleway,
                        //               fontSize: 14.sp,
                        //               color: Theme.of(context).primaryColor,
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),

                        //   ],
                        // ),
                        SizedBox(height: 1.25.h),
                        AppTextSemiBold(
                          text: "Time & Date",
                          fontFamily: FontFamily.hermann,
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.sp,
                        ),
                        const Divider(
                          color: whiteShade,
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            const Expanded(
                              child: AppSvg(svgName: calendar),
                            ),
                            Expanded(
                              flex: 2,
                              child: AppTextMedium(
                                text: date,
                                fontFamily: FontFamily.raleway,
                                fontSize: 15.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const Expanded(
                              child: AppSvg(svgName: time),
                            ),
                            Expanded(
                              flex: 2,
                              child: AppTextMedium(
                                text: servicetime,
                                fontFamily: FontFamily.raleway,
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        AppTextSemiBold(
                          text: "Service List",
                          fontFamily: FontFamily.hermann,
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.sp,
                        ),
                        const Divider(
                          color: whiteShade,
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextMedium(
                              text: serviceName,
                              fontFamily: FontFamily.raleway,
                              fontSize: 15.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                            AppTextSemiBold(
                              text: servicePrice,
                              fontFamily: FontFamily.raleway,
                              fontSize: 15.sp,
                            )
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     SizedBox(height: 2.5.h),
                        //     AppBox(
                        //       elevation: 0,
                        //       bgColor: whiteColor,
                        //       borderColor: greenishBlack,
                        //       borderWidth: 0.5,
                        //       child: Padding(
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 3.w, vertical: 1.h),
                        //         child: const AppReviewData(),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Visibility(
                  visible: status != "Completed",
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        App3DButton(
                          tap: () async {
                            UpdateBookingStatus status = UpdateBookingStatus();
                            final String result = await status.updateBooking(bookingId: bookingId, decision: BookingDecision.COMPLETED);
                            showToast(result);
                            bottomSheet(
                                context,
                                AppBottomSheet(
                                  svg: completed,
                                  title: "JOB COMPLETED",
                                  subTitle:
                                      "Your service has been successfully sompleted! We\nvalue your feedback.\nPlease take a moment to rate you experience with the freelancer:",
                                  okText: "LEAVE A REVIEW",
                                  oneButton: true,
                                  okTap: () async {
                                    Navigator.pop(context);
                                    bottomSheet(context, AppGiveReview(bookingId: bookingId, name: name));
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => const AppGiveReview())
                                    // );
                                  },
                                ));
                          },
                          backgroundColor: Theme.of(context).primaryColor,
                          borderColor: greenishBlack,
                          child: AppTextBold(
                            text: "COMPLETE",
                            color: whiteColor,
                            fontFamily: FontFamily.raleway,
                            fontSize: 17.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
