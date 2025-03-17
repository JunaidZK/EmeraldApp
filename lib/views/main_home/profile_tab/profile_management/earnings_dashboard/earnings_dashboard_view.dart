import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_container_box.dart';
import 'package:emerald_beauty/components/app_drop_down_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_vertical_text_data.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/model_class/circle_chart.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/earnings_dashboard/earnings_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EarningsDashboardView extends StatelessWidget {
  final Users user;
  const EarningsDashboardView({this.user = Users.employee, super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => EarningsDashboardProvider(),
      child: Consumer<EarningsDashboardProvider>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: appBar(
              context,
              appBarheight: 8.h,
              leftWidget: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Transform.flip(
                  flipX: localization!.locale.languageCode == "ar",
                  child: const AppSvg(
                    svgName: arrowBack,
                    boxfit: BoxFit.none,
                  ),
                ),
              ),
              title: localization.translate("EARNINGS DASHBOARD"),
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible:
                          user == Users.freelancer, // Only show for freelancers
                      child: Center(
                        child: Wrap(
                          spacing: 2.w, // Horizontal space between items
                          runSpacing: 0.5.h, // Vertical space between rows
                          children:
                              List.generate(value.summary.length, (index) {
                            var summary = value.summary[index];
                            return SizedBox(
                              width:
                                  (width - 64) / 2, // Ensures two items per row
                              child: AppContainerBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 1.h,
                                  ),
                                  child: AppVerticalTextData(
                                    headerText: summary['value']!,
                                    headerFont: FontFamily.hermann,
                                    headerTextColor:
                                        Theme.of(context).primaryColor,
                                    headerSize: 20.sp,
                                    subText: summary['name']!,
                                    subTextFont: FontFamily.raleway,
                                    subTextColor:
                                        Theme.of(context).primaryColor,
                                    subSize: 13.5.sp,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: user == Users.freelancer,
                        child: AppBox(
                            elevation: 2,
                            bgColor: whiteColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextBold(
                                        text: "Overview",
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: FontFamily.raleway,
                                        fontSize: 17.sp,
                                      ),
                                      Row(
                                        children: [
                                          AppTextMedium(
                                            text: "Sort By:   ",
                                            fontSize: 17.sp,
                                            fontFamily: FontFamily.raleway,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          SizedBox(
                                            width: 17.5
                                                .w, // Set a fixed width or adjust as needed
                                            child: AppDropDownTextfield(
                                              outlineBorder: InputBorder.none,
                                              value: "Yearly",
                                              suffixIcon: AppSvg(
                                                svgName: dropDownIcon,
                                                width: 7.5.w,
                                                height: 1.h,
                                              ),
                                              items: [
                                                DropdownMenuItem(
                                                  value: "Monthly",
                                                  child: AppTextThin(
                                                    text: "Monthly",
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontFamily:
                                                        FontFamily.raleway,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: "Yearly",
                                                  child: AppTextThin(
                                                    text: "Yearly",
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontFamily:
                                                        FontFamily.raleway,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SfCircularChart(
                                    series: <DoughnutSeries<CircleChart,
                                        String>>[
                                      DoughnutSeries<CircleChart, String>(
                                        dataSource: value.chartData,
                                        xValueMapper: (CircleChart data, _) =>
                                            data.x,
                                        yValueMapper: (CircleChart data, _) =>
                                            data.y,
                                        pointColorMapper:
                                            (CircleChart data, _) => data.color,
                                        dataLabelMapper:
                                            (CircleChart data, _) =>
                                                '${data.y}%',
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true),
                                        innerRadius: "65%",
                                      )
                                    ],
                                  ),
                                  Column(
                                    children:
                                        value.chartOverView.map((overview) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  AppCircleShape(
                                                      horizontalPadding: 1.5.w,
                                                      verticalPadding: 0.5.h,
                                                      borderColor:
                                                          overview['color']
                                                              as Color?,
                                                      bgColor: overview['color']
                                                          as Color?,
                                                      widget: const SizedBox
                                                          .shrink()),
                                                  SizedBox(width: 2.w),
                                                  AppTextMedium(
                                                    text: overview["title"]
                                                        .toString(),
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        FontFamily.hermann,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  SizedBox(width: 1.w),
                                                  const AppSvg(svgName: profit),
                                                  SizedBox(width: 0.5.w),
                                                  AppTextMedium(
                                                    text: overview["p/l"]
                                                        .toString(),
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        FontFamily.hermann,
                                                    color: lightTurquoise,
                                                  )
                                                ],
                                              ),
                                              AppTextSemiBold(
                                                text: overview["amount"]
                                                    .toString(),
                                                fontSize: 14.sp,
                                                fontFamily: FontFamily.hermann,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 0.5.h),
                                        ],
                                      );
                                    }).toList(),
                                  )
                                ],
                              ),
                            ))),
                    SizedBox(height: 1.h),
                    AppTextBold(
                      text: localization.translate("Transaction History"),
                      color: Theme.of(context).primaryColor,
                      fontSize: 17.5.sp,
                      fontFamily: FontFamily.raleway,
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: value.transactionHistory.map((history) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBox(
                                elevation: 0,
                                bgColor: whiteColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.25.w, vertical: 0.5.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          AppCircularImage(
                                            imgHeight: 3.h,
                                          ),
                                          SizedBox(width: 2.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppTextSemiBold(
                                                text: history["service"]!,
                                                fontFamily: FontFamily.hermann,
                                                fontSize: 14.sp,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              AppTextThin(
                                                text: history["date_time"]!,
                                                fontFamily: FontFamily.hermann,
                                                fontSize: 13.sp,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      AppTextSemiBold(
                                        text: history["amount"]!,
                                        fontFamily: FontFamily.hermann,
                                        fontSize: 16.sp,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                )),
                            const Divider(),
                          ],
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
