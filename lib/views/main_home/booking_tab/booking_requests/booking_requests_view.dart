// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_booking_data.dart';
import 'package:emerald_beauty/components/app_bottom_sheet.dart';
import 'package:emerald_beauty/components/app_box.dart';
// import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/filter/app_filteration.dart';
import 'package:emerald_beauty/components/app_search_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
// import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
// import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/getx_controller.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_requests/booking_requests_provider.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_tab_provider.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/detailed_booking/detailed_booking_view.dart';
// import 'package:emerald_beauty/views/main_home/booking_tab/detailed_booking/detailed_booking_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingRequestsView extends StatefulWidget {
  const BookingRequestsView({super.key});

  @override
  State<BookingRequestsView> createState() => _BookingRequestsViewState();
}

class _BookingRequestsViewState extends State<BookingRequestsView> {
  AppStateController appStateController =
      Get.put(AppStateController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final bookingProvider =
        Provider.of<BookingTabProvider>(context, listen: false);
    return Consumer<BookingRequestsProvider>(
        builder: (context, provider, child) {
      return Column(
        children: [
          Row(children: [
            Expanded(
                child: AppSearchField(
                    cntrller: provider.searchController,
                    fillColor: whiteColor,
                    onChanged: (value) => provider.notifyListeners())),
            SizedBox(width: 2.5.w),
            GestureDetector(
                onTap: () => bottomSheet(context, const AppFilteration()),
                child: AppCircleShape(
                    verticalPadding: 1.h,
                    horizontalPadding: 2.w,
                    borderWidth: 2.0,
                    bgColor: whiteColor,
                    widget: const AppSvg(svgName: filter)))
          ]),
          SizedBox(height: 0.5.h),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.bookings.length,
              itemBuilder: (context, index) {
                var booking = provider.bookings[index];
                bool matchesSearch = booking.service!.name
                    .toLowerCase()
                    .contains(provider.searchController.text.toLowerCase());

                return Obx(() => appStateController.bookingFilterList.isEmpty &&
                            matchesSearch ||
                        appStateController.bookingFilterList
                                .contains(booking.statusText) &&
                            matchesSearch
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              AnimatedNavigation.bottomSlide(
                                  ChangeNotifierProvider.value(
                                      value: bookingProvider,
                                      child: DetailedBookingView(
                                          title: localization.translate(
                                              "DETAILED BOOKING"),
                                          bookingId: booking.id,
                                          status:
                                              localization.translate(
                                                  booking.statusText),
                                          name:
                                              "${booking.client.firstName} ${booking.client.lastName}",
                                          date: booking.date,
                                          servicetime:
                                              "${booking.startTime} - ${booking.endTime}",
                                          serviceName:
                                              localization.locale
                                                          .languageCode ==
                                                      "en"
                                                  ? booking.service!.name
                                                  : booking.service!.arabicName,
                                          employeeId: booking.client.id,
                                          servicePrice:
                                              "AED ${booking.amount}"))));
                        },
                        child: AppBox(
                            elevation: 0,
                            borderWidth: 1.0,
                            borderColor: Theme.of(context).primaryColor,
                            bgColor: whiteColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              child: AppBookingData(
                                bookingId: booking.id,
                                service:
                                    localization!.locale.languageCode == "en"
                                        ? booking.service!.name
                                        : booking.service!.arabicName,
                                amount: booking.amount.toString(),
                                dateTime:
                                    "${booking.date} ${booking.startTime}",
                                status: booking.statusText,
                                amountDue: booking.amount.toString(),
                                clientName:
                                    "${booking.client.firstName} ${booking.client.lastName}",
                                // reviews: booking['reviews'].toString(),
                                // starRating: booking['stars'].toString(),
                                // addOns:
                                //     booking['add_ons'] as List<Map<String, dynamic>>?,
                              ),
                            )),
                      )
                    : const SizedBox());
              }),
        ],
      );
    });
  }
}
