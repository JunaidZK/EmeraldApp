// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:emerald_beauty/components/app_booking_data.dart';
import 'package:emerald_beauty/components/app_bottom_sheet.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/filter/app_filteration.dart';
import 'package:emerald_beauty/components/app_search_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/getx_controller.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/history/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  AppStateController appStateController =
      Get.put(AppStateController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Consumer<HistoryProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: AppSearchField(
                cntrller: provider.searchController,
                fillColor: whiteColor,
                onChanged: (value) => provider
                    .notifyListeners(), // 🔹 Text change detect karne ke liye
              ),
            ),
            // Expanded(child: AppSearchField(cntrller: provider.searchController, fillColor: whiteColor)),
            SizedBox(width: 2.5.w),
            GestureDetector(
                onTap: () => bottomSheet(
                    context,
                    const AppFilteration(
                        filterOptions: ["Completed", "Cancelled"])),
                child: AppCircleShape(
                    verticalPadding: 1.h,
                    horizontalPadding: 2.w,
                    borderWidth: 2.0,
                    bgColor: whiteColor,
                    widget: const AppSvg(svgName: filter)))
          ]),
          SizedBox(height: 1.25.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.groupedBookings.keys.length,
            itemBuilder: (context, index) {
              final monthYear = provider.groupedBookings.keys.elementAt(index);
              final bookings = provider.groupedBookings[monthYear]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show the month-year header
                  AppTextSemiBold(
                      text: monthYear,
                      color: Theme.of(context).primaryColor,
                      fontFamily: FontFamily.hermann,
                      fontSize: 17.sp),

                  // List the bookings for that month-year
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      var history = bookings[index];
                      bool matchesSearch = history.service!.name
                          .toLowerCase()
                          .contains(
                              provider.searchController.text.toLowerCase());

                      return Obx(() => appStateController
                                      .bookingFilterList.isEmpty &&
                                  matchesSearch ||
                              appStateController.bookingFilterList
                                      .contains(history.statusText) &&
                                  matchesSearch
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.15.h),
                              child: AppBox(
                                elevation: 0,
                                borderWidth: 1.0,
                                borderColor: Theme.of(context).primaryColor,
                                bgColor: whiteColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 1.h),
                                  child: AppBookingData(
                                    bookingId: history.id,
                                    service:
                                        localization!.locale.languageCode ==
                                                "en"
                                            ? history.service!.name
                                            : history.service!.arabicName,
                                    amount: history.amount.toString(),
                                    dateTime:
                                        "${history.date} ${history.startTime}",
                                    status: history.statusText,
                                    amountDue: history.amount.toString(),
                                    clientName:
                                        "${history.client.firstName} ${history.client.lastName}",
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox());
                    },
                  ),
                ],
              );
            },
          ),
        ],
      );
    });
  }
}
