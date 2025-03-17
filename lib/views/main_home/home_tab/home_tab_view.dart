import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_bottom_sheet.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_container_box.dart';
import 'package:emerald_beauty/components/app_logout.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_vertical_divider_data.dart';
import 'package:emerald_beauty/components/app_vertical_text_data.dart';
import 'package:emerald_beauty/components/app_vertical_text_image_data.dart';
import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/model_class/chart_data.dart';
import 'package:emerald_beauty/views/main_home/booking_tab/detailed_booking/detailed_booking_view.dart';
import 'package:emerald_beauty/views/main_home/home_tab/home_tab_provider.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:emerald_beauty/views/main_home/notifications_view/notification_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/view_profile/view_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeTabView extends StatefulWidget {
  final Users user;
  final ScrollController controller;
  const HomeTabView(
      {this.user = Users.freelancer, required this.controller, super.key});

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  late HomeTabProvider provider;
  var graphData;

  @override
  void initState() {
    super.initState();
    provider = HomeTabProvider(context);
    provider.getServices();
    provider.fetchGraphData().then((val) {
      graphData = provider.getGraphData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final MainHomeProvider mainHomeProvider =
        Provider.of<MainHomeProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => provider,
      child: Consumer<HomeTabProvider>(builder: (context, provider, child) {
        return Scaffold(
          appBar: appBar(
            context,
            leftIcon: null,
            titleWidget: AppSvg(
              svgName: header,
              width: 10.w,
              height: 5.h,
            ),
            title: null,
            rightIcons: [
              GestureDetector(
                  onTap: () async {
                    await mainHomeProvider.markReadNotifications();
                    Navigator.push(
                            context,
                            AnimatedNavigation.bottomSlide(
                                const NotificationView()))
                        .then((val) {
                      mainHomeProvider.getUnreadNotifications();
                    });
                  },
                  child: Badge.count(
                      count: mainHomeProvider.unreadCount,
                      alignment: Alignment.topLeft,
                      offset: const Offset(-7, -5),
                      smallSize: 12.sp,
                      textColor: whiteColor,
                      backgroundColor: Theme.of(context).primaryColor,
                      isLabelVisible: mainHomeProvider.unreadCount > 0,
                      child: const AppSvg(svgName: notifications))),
              SizedBox(width: 3.5.w),
              GestureDetector(
                onTap: () {
                  showMenu(
                      context: context,
                      color: whiteColor,
                      menuPadding: EdgeInsets.zero,
                      position: localization!.locale.languageCode == "en"
                          ? RelativeRect.fromLTRB(10.w, 4.h, 0, 0)
                          : RelativeRect.fromLTRB(0.w, 4.h, 10.0.w,
                              0), // Position where the dropdown should appear
                      items: <PopupMenuEntry>[
                        PopupMenuItem<String>(
                            value: 'View Profile',
                            child: AppTextThin(
                                text: localization.translate('View Profile'),
                                fontSize: 14.sp,
                                fontFamily: FontFamily.hermann,
                                color: Theme.of(context).primaryColor)),
                        PopupMenuItem<String>(
                            value: 'Logout',
                            child: AppTextThin(
                                text: localization.translate('Logout'),
                                fontSize: 14.sp,
                                fontFamily: FontFamily.hermann,
                                color: Theme.of(context).primaryColor))
                      ]).then((value) {
                    // Handle the selected value from the dropdown
                    if (value != null) {
                      if (value == "View Profile") {
                        Navigator.push(
                            context,
                            AnimatedNavigation.bottomSlide(
                                ChangeNotifierProvider.value(
                                    value: mainHomeProvider,
                                    child: const ViewProfileView())));
                      } else {
                        bottomSheet(context, const AppLogout());
                      }
                    }
                  });
                },
                child: Row(
                  children: [
                    mainHomeProvider.userProfile != null
                        ? AppCircularImage(
                            networkImage: mainHomeProvider
                                .userProfile!.data!.profile!.userImage?.path,
                            fit: BoxFit.contain,
                            imgHeight: 4.5.h,
                          )
                        : AppCircularImage(
                            fit: BoxFit.contain, imgHeight: 4.5.h),
                    SizedBox(width: 2.5.w),
                    const AppSvg(
                      svgName: dropDownIcon,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.5.w),
            ],
          ),
          body: SingleChildScrollView(
            controller: widget.controller,
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      AppSvg(
                        svgName: location,
                        width: 1.5.w,
                        height: 2.5.h,
                      ),
                      SizedBox(width: 2.5.w),
                      AppTextSemiBold(
                        text: localization!.translate('Location'),
                        fontFamily: FontFamily.raleway,
                        fontSize: 16.5.sp,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  AppTextThin(
                    text: "123 Palm Avenue, Downtown Dubai, Dubai, UAE",
                    color: grayColor,
                    fontSize: 15.sp,
                    fontFamily: FontFamily.raleway,
                  ),
                  SizedBox(height: 0.25.h),
                  if (widget.user == Users.freelancer)
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Set number of columns here
                        mainAxisSpacing: 1.w, // Space between rows
                        crossAxisSpacing: 0.5.h, // Space between columns
                        childAspectRatio:
                            1.95, // Adjust to fit the aspect ratio of each box
                      ),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      // If used inside a scrollable parent
                      physics: const NeverScrollableScrollPhysics(),
                      // Disables scrolling within GridView if needed
                      itemCount: provider.freelancerData.length,
                      itemBuilder: (context, index) {
                        var data = provider.freelancerData[index];
                        return AppBox(
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.5.w,
                              vertical: 0.5.h,
                            ),
                            child: AppVerticalTextData(
                              headerText: data['headerText']!,
                              headerFont: FontFamily.hermann,
                              headerTextColor: Theme.of(context).primaryColor,
                              headerSize: 22.sp,
                              subText: localization.translate(data['subText']!),
                              subTextFont: FontFamily.raleway,
                              subTextColor: Theme.of(context).primaryColor,
                              subSize: localization.locale.languageCode == "en"
                                  ? 16.sp
                                  : 14.5.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  if (widget.user == Users.employee)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: provider.employeeData.map((data) {
                          return Padding(
                              padding: EdgeInsets.only(right: 1.w),
                              child: AppContainerBox(
                                  containerWidth: 28.5.w,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.5.w, vertical: 0.5.h),
                                      child: AppVerticalTextData(
                                          headerText: data['headerText']!,
                                          headerFont: FontFamily.hermann,
                                          headerTextColor:
                                              Theme.of(context).primaryColor,
                                          headerSize: 21.sp,
                                          subText: localization
                                              .translate(data['subText']!),
                                          subTextFont: FontFamily.raleway,
                                          subTextColor:
                                              Theme.of(context).primaryColor,
                                          subSize: localization
                                                      .locale.languageCode ==
                                                  "en"
                                              ? 13.sp
                                              : 11.5.sp))));
                        }).toList()),
                  SizedBox(height: 1.5.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextSemiBold(
                            text: localization.translate("Jobs Overview"),
                            color: Theme.of(context).primaryColor,
                            fontSize: localization.locale.languageCode == "en"
                                ? 19.sp
                                : 17.sp,
                            fontFamily: FontFamily.hermann),
                        AppTextRegular(
                            text: localization.translate("Weekly"),
                            color: Theme.of(context).primaryColor,
                            fontSize: 14.5.sp,
                            fontFamily: FontFamily.raleway)
                      ]),
                  SizedBox(height: 0.5.h),
                  if (graphData != null)
                    AppBox(
                        elevation: 0,
                        bgColor: Colors.white,
                        child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                                axisLine: const AxisLine(width: 0),
                                labelStyle: TextStyle(
                                    fontSize: 12.sp, color: grayColor)),
                            primaryYAxis: NumericAxis(
                                minimum: 0,
                                maximum: 25,
                                interval: 5,
                                majorTickLines: const MajorTickLines(width: 0),
                                minorTickLines: const MinorTickLines(width: 0),
                                axisLine: const AxisLine(width: 0),
                                labelStyle: TextStyle(
                                    fontSize: 12.sp, color: Colors.grey),
                                majorGridLines: const MajorGridLines(
                                    color: grayColor, dashArray: [5, 5])),
                            series: <CartesianSeries<SalesData, String>>[
                              ColumnSeries<SalesData, String>(
                                  dataSource: graphData,
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.day,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales,
                                  pointColorMapper: (SalesData sales, _) =>
                                      sales.sales < 5
                                          ? lightTurquoise
                                          : Theme.of(context).primaryColor,
                                  width: 0.1, // Adjust bar width
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.sh)))
                            ])),
                  SizedBox(height: 0.65.h),
                  if (provider.employeeServices != null)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextBold(
                              text: localization.translate("MY SERVICES"),
                              color: Theme.of(context).primaryColor,
                              fontFamily: FontFamily.hermann,
                              fontSize: 18.sp),
                          Row(children: [
                            AppCircleShape(
                                widget: Icon(Icons.arrow_back_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 16.5.sp)),
                            SizedBox(width: 2.5.w),
                            AppCircleShape(
                                widget: Icon(Icons.arrow_forward_outlined,
                                    color: Theme.of(context).primaryColor,
                                    size: 16.5.sp))
                          ])
                        ]),
                  SizedBox(height: 2.h),
                  if (provider.employeeServices != null)
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const RangeMaintainingScrollPhysics(),
                        child: Row(
                            children:
                                provider.employeeServices!.data.map((service) {
                          return Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      localization.locale.languageCode == "en"
                                          ? 3.w
                                          : 0.w,
                                  left: localization.locale.languageCode == "ar"
                                      ? 3.w
                                      : 0.w),
                              child: service.service != null
                                  ? GestureDetector(
                                      onTap: () {},
                                      child: AppContainerBox(
                                          containerWidth: 48.5.w,
                                          bgColor: whiteColor,
                                          borderColor:
                                              Theme.of(context).primaryColor,
                                          borderWidth: 1.5,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w,
                                                  vertical: 0.75.h),
                                              child: AppVerticalTextImageData(
                                                  image: serviceImage,
                                                  serviceText: localization
                                                              .locale
                                                              .languageCode ==
                                                          "en"
                                                      ? service.service!.name
                                                      : service
                                                          .service!.arabicName,
                                                  priceText: service.price != 0
                                                      ? service.price.toString()
                                                      : service.service!.price
                                                          .toString()))),
                                    )
                                  : const SizedBox.shrink());
                        }).toList())),
                  SizedBox(height: 2.5.h),
                  if (mainHomeProvider.appointmentsHistory.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextBold(
                          text: localization.translate("CLIENT HISTORY"),
                          color: Theme.of(context).primaryColor,
                          fontFamily: FontFamily.hermann,
                          fontSize: localization.locale.languageCode == "en"
                              ? 18.sp
                              : 16.sp,
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<MainHomeProvider>(context,
                                    listen: false)
                                .setPage(1, openHistory: true);
                          },
                          child: Row(
                            children: [
                              AppTextSemiBold(
                                text: localization.translate("View All"),
                                fontSize:
                                    localization.locale.languageCode == "en"
                                        ? 14.sp
                                        : 12.5.sp,
                                fontFamily: FontFamily.raleway,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 1.5.w),
                              AppCircleShape(
                                  widget: Icon(
                                Icons.arrow_forward_outlined,
                                color: Theme.of(context).primaryColor,
                                size: 15.sp,
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 0.5.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const RangeMaintainingScrollPhysics(),
                    child: Row(
                      children:
                          mainHomeProvider.appointmentsHistory.map((history) {
                        if (mainHomeProvider
                                .appointmentsHistory.firstOrNull!.service !=
                            null) {
                          return Padding(
                            padding: EdgeInsets.only(right: 2.5.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailedBookingView(
                                              title: localization.translate(
                                                  "HISTORY BOOKING DETAIL"),
                                              status: "Completed",
                                              bookingId: history.id,
                                              name:
                                                  "${history.client.firstName} ${history.client.lastName}",
                                              date: history.date,
                                              servicetime:
                                                  "${history.startTime} - ${history.endTime}",
                                              serviceName: localization.locale
                                                          .languageCode ==
                                                      "en"
                                                  ? history.service!.name
                                                  : history.service!.arabicName,
                                              servicePrice:
                                                  "AED ${history.amount}",
                                              employeeId: history.client.id,
                                            )));
                              },
                              child: AppContainerBox(
                                bgColor: whiteColor,
                                borderColor: Theme.of(context).primaryColor,
                                borderWidth: 1.5,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.h),
                                    child: AppVerticalDividerData(
                                        service:
                                            localization.locale.languageCode ==
                                                    "en"
                                                ? history.service!.name
                                                : history.service!.arabicName,
                                        serviceBy:
                                            "${history.client.firstName} ${history.client.lastName}",
                                        dateTime:
                                            "${history.date} ${history.startTime}",
                                        amount: history.amount.toString())),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
