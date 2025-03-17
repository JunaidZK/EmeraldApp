import 'package:emerald_beauty/api_classes/bookings/update_booking_status.dart';
import 'package:emerald_beauty/components/app_booking_request.dart';
import 'package:emerald_beauty/components/app_bottom_sheet.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_tab_provider.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppBookingData extends StatelessWidget {
  final int bookingId;
  final String service;
  final String amount;
  final String dateTime;
  final String status;
  final String clientName;
  final String starRating;
  final String reviews;
  final String amountDue;
  final List<Map<String, dynamic>>? addOns;
  const AppBookingData(
      {required this.bookingId,
      required this.service,
      required this.amount,
      required this.dateTime,
      this.status = "New",
      this.clientName = "Emerald",
      this.starRating = "4.4",
      this.reviews = "2145",
      this.amountDue = "250 AED",
      this.addOns,
      super.key});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = status == "Confirmed" || status == "Completed"
        ? brightGreen.withValues(alpha: 0.35)
        : status == "In Progress"
            ? blueColor.withValues(alpha: 0.35)
            : status == "Cancelled"
                ? redColor.withValues(alpha: 0.35)
                : yellowColor.withValues(alpha: 0.35);
    final Color statusTextColor = status == "Confirmed" || status == "Completed"
        ? brightGreen
        : status == "In Progress"
            ? blueColor
            : status == "Cancelled"
                ? redColor
                : yellowColor;
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextSemiBold(
              text: service,
              fontSize: 15.5.sp,
              fontFamily: FontFamily.hermann,
              color: Theme.of(context).primaryColor,
            ),
            AppTextSemiBold(
              text: "AED $amount",
              fontSize: 15.5.sp,
              fontFamily: FontFamily.hermann,
              color: lightTurquoise,
            ),
          ],
        ),
        SizedBox(height: 0.25.h),
        AppTextRegular(
          text: "${localization!.translate("Date & Time")}: $dateTime",
          fontSize: 13.25.sp,
          fontFamily: FontFamily.raleway,
          color: grayColor,
        ),
        SizedBox(height: 1.25.h),
        // Visibility(
        //     visible: status == 'New',
        //     child: AppTextSemiBold(
        //       text: "Add-Ons",
        //       fontSize: 15.sp,
        //       fontFamily: FontFamily.raleway,
        //       color: Theme.of(context).primaryColor,
        //     )),
        // Visibility(
        //   visible: status == 'New',
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemCount: addOns!.length,
        //     itemBuilder: (context, index) {
        //       final addOn = addOns![index];
        //       return Padding(
        //         padding: EdgeInsets.symmetric(vertical: 0.25.h),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             AppTextMedium(
        //               text: addOn["service"],
        //               fontSize: 13.5.sp,
        //               color: grayColor,
        //               fontFamily: FontFamily.raleway,
        //             ),
        //             AppTextMedium(
        //               text: addOn["amount"],
        //               fontSize: 13.5.sp,
        //               color: lightTurquoise,
        //               fontFamily: FontFamily.raleway,
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
        AppTextSemiBold(
          text: "Client Name",
          color: Theme.of(context).primaryColor,
          fontFamily: FontFamily.raleway,
          fontSize: 14.5.sp,
        ),
        SizedBox(height: 0.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppCircularImage(
                  imgHeight: 3.5.h,
                ),
                SizedBox(width: 2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextSemiBold(
                      text: clientName,
                      color: Theme.of(context).primaryColor,
                      fontFamily: FontFamily.raleway,
                      fontSize: 14.5.sp,
                    ),
                    // SizedBox(height: 0.5.h),
                    // Row(
                    //   children: [
                    //     const AppSvg(svgName: stars),
                    //     SizedBox(width: 1.w),
                    //     AppTextMedium(
                    //       text:
                    //           "$starRating ( $reviews ${localization.translate("reviews")})",
                    //       color: grayColor,
                    //       fontSize: 12.sp,
                    //       fontFamily: FontFamily.raleway,
                    //     )
                    //   ],
                    // ),
                  ],
                )
              ],
            ),
            AppBox(
                elevation: 0,
                bgColor: statusColor,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  child: AppTextSemiBold(
                    text: status,
                    color: statusTextColor,
                    fontSize: 12.sp,
                  ),
                ))
          ],
        ),
        SizedBox(height: 0.5.h),
        Visibility(
            visible: status != 'Cancelled' && status != "Completed",
            child: Column(
              children: [
                const Divider(
                  color: whitishGray,
                ),
                SizedBox(height: 0.1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextSemiBold(
                      text: localization.translate("Amount Due"),
                      fontSize: 14.5.sp,
                      fontFamily: FontFamily.raleway,
                      color: lightTurquoise,
                    ),
                    AppTextSemiBold(
                      text: "AED $amountDue",
                      fontSize: 14.5.sp,
                      fontFamily: FontFamily.raleway,
                      color: lightTurquoise,
                    ),
                  ],
                ),
              ],
            )),
        Visibility(
          visible: status == 'Pending',
          child: SizedBox(height: 0.75.h),
        ),
        Visibility(
            visible: status == 'Pending',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                App3DButton(
                  height: 3.25.h,
                  width: 35.w,
                  backgroundColor: lightTurquoise,
                  borderColor: Theme.of(context).primaryColor,
                  tap: () {
                    UpdateBookingStatus status = UpdateBookingStatus();
                    bottomSheet(
                        context,
                        AppBottomSheet(
                          svg: alert,
                          title: localization.translate("CANCEL REQUEST"),
                          subTitle: localization.translate(
                              "Are you sure you want to cancel your booking\nrequest?"),
                          cancelText: localization.translate("CANCEL"),
                          okText: localization.translate("CONFIRM"),
                          okTap: () async {
                            String result = await status.updateBooking(
                                bookingId: bookingId,
                                decision: BookingDecision.CANCEL);

                            Navigator.pop(context);
                            await Provider.of<MainHomeProvider>(context,
                                    listen: false)
                                .getAllBookings()
                                .then((val) {
                              Provider.of<BookingTabProvider>(context,
                                      listen: false)
                                  .bookings = Provider.of<MainHomeProvider>(
                                      context,
                                      listen: false)
                                  .bookings!
                                  .data
                                  .data;
                            });
                            showToast(result);
                          },
                          cancelTap: () {
                            Navigator.pop(context);
                          },
                        ));
                  },
                  child: AppTextBold(
                    text: localization.translate("Decline"),
                    fontFamily: FontFamily.raleway,
                    fontSize: 17.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 1.25.w),
                App3DButton(
                  height: 3.25.h,
                  width: 35.w,
                  backgroundColor: Theme.of(context).primaryColor,
                  borderColor: greenishBlack,
                  child: AppTextBold(
                    text: localization.translate("ACCEPT"),
                    fontFamily: FontFamily.raleway,
                    fontSize: 17.sp,
                    color: whiteColor,
                  ),
                  tap: () {
                    UpdateBookingStatus status = UpdateBookingStatus();
                    bottomSheet(
                        context,
                        AppBottomSheet(
                          svg: alert,
                          title:
                              localization.translate("ACCEPT BOOKING REQUEST"),
                          subTitle: localization
                              .translate("You have a new booking request!"),
                          cancelText: localization.translate("DECLINE"),
                          okText: localization.translate("ACCEPT"),
                          okTap: () async {
                            // Navigator.pop(context);
                            String result = await status.updateBooking(
                                bookingId: bookingId,
                                decision: BookingDecision.ACCEPT);

                            Navigator.pop(context);
                            await Provider.of<MainHomeProvider>(context,
                                    listen: false)
                                .getAllBookings()
                                .then((val) {
                              Provider.of<BookingTabProvider>(context,
                                      listen: false)
                                  .bookings = Provider.of<MainHomeProvider>(
                                      context,
                                      listen: false)
                                  .bookings!
                                  .data
                                  .data;
                            });
                            showToast(result);
                          },
                          cancelTap: () {
                            Navigator.pop(context);
                          },
                        ));
                  },
                )
              ],
            ))
      ],
    );
  }
}
