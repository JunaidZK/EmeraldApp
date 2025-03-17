import 'package:emerald_beauty/components/app_container_switcher.dart';
import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_requests/booking_requests_provider.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_requests/booking_requests_view.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/booking_tab_provider.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/history/history_provider.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/history/history_view.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingTabView extends StatelessWidget {
  final Users user;
  final ScrollController controller;
  final bool historyOpen;

  const BookingTabView({
    this.user = Users.freelancer,
    required this.controller,
    this.historyOpen = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mainHomeProvider =
        Provider.of<MainHomeProvider>(context, listen: false);
    final localization = AppLocalizations.of(context);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => BookingTabProvider(mainHomeProvider)),
          ChangeNotifierProxyProvider<BookingTabProvider, HistoryProvider>(
              create: (_) =>
                  HistoryProvider(BookingTabProvider(mainHomeProvider)),
              update: (_, bookingTabProvider, historyBookingProvider) =>
                  HistoryProvider(bookingTabProvider)),
          ChangeNotifierProxyProvider<BookingTabProvider,
                  BookingRequestsProvider>(
              create: (_) =>
                  BookingRequestsProvider(BookingTabProvider(mainHomeProvider)),
              update: (_, bookingTabProvider, historyBookingProvider) =>
                  BookingRequestsProvider(bookingTabProvider))
        ],
        child:
            Consumer<BookingTabProvider>(builder: (context, provider, child) {
          return Scaffold(
              appBar: appBar(context,
                  title: localization!.translate("BOOKING MANAGEMENT"),
                  leftIcon: null,
                  leftWidget: null,
                  appBarheight: 8.h),
              body: SingleChildScrollView(
                  controller: controller,
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Column(children: [
                        Center(
                            child: AppContainerSwitcher(
                                leftSideText:
                                    localization.translate("BOOKING REQUESTS"),
                                leftSideTap: () => provider.switcher = false,
                                leftSideColor: !provider.switcher
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                leftSideTextColor: !provider.switcher
                                    ? primaryTextColor
                                    : Theme.of(context).primaryColor,
                                rightSideText:
                                    localization.translate("HISTORY"),
                                rightSideTap: () => provider.switcher = true,
                                rightSideColor: provider.switcher
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                rightSideTextColor: provider.switcher
                                    ? primaryTextColor
                                    : Theme.of(context).primaryColor)),
                        SizedBox(height: 2.h),
                        provider.switcher
                            ? const HistoryView()
                            : const BookingRequestsView()
                      ]))));
        }));
  }
}
