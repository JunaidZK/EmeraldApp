import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/leave_management/apply_for_leave/apply_for_leave_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/leave_management/detail_leave_page.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/leave_management/leave_management_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LeaveManagementView extends StatefulWidget {
  const LeaveManagementView({super.key});

  @override
  State<LeaveManagementView> createState() => _LeaveManagementViewState();
}

class _LeaveManagementViewState extends State<LeaveManagementView> {
  late LeaveManagementProvider leaveProvider;

  @override
  void initState() {
    super.initState();
    leaveProvider = LeaveManagementProvider();
    leaveProvider.getAllLeaves();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => leaveProvider,
      child:
          Consumer<LeaveManagementProvider>(builder: (context, value, child) {
        if (value.leaves == null || value.leaves!.data.isEmpty) {
          return const Loader();
        } else {
          return Scaffold(
            appBar: appBar(
              context,
              appBarheight: 8.h,
              leftWidget: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const AppSvg(
                  svgName: arrowBack,
                  boxfit: BoxFit.none,
                ),
              ),
              title: "LEAVE MANAGEMENT",
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: ListView.builder(
                itemCount: value.leaves!.data.length,
                itemBuilder: (context, index) {
                  var leave = value.leaves!.data[index];
                  Color statusBgColor = leave.leaveStatusText == "Pending"
                      ? yellowColor.withValues(alpha: 0.3)
                      : leave.leaveStatusText == "Approved"
                          ? brightGreen.withValues(alpha: 0.3)
                          : redColor.withValues(alpha: 0.3);
                  Color statusTextColor = leave.leaveStatusText == "Pending"
                      ? yellowColor
                      : leave.leaveStatusText == "Approved"
                          ? brightGreen
                          : redColor;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          AnimatedNavigation.bottomSlide(DetailLeavePage(
                            data: leave,
                          )));
                    },
                    child: AppBox(
                        elevation: 0,
                        bgColor: whiteColor,
                        borderWidth: 0.5,
                        borderColor: greenishBlack,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextBold(
                                    text: leave.reason,
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: FontFamily.raleway,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(height: 0.5.h),
                                  AppTextMedium(
                                    text: leave.leaveTypeText,
                                    color: grayColor,
                                    fontFamily: FontFamily.raleway,
                                    fontSize: 15.sp,
                                  ),
                                  SizedBox(height: 0.5.h),
                                  AppTextMedium(
                                    text:
                                        "${leave.startDate} - ${leave.endDate}",
                                    color: grayColor,
                                    fontFamily: FontFamily.raleway,
                                    fontSize: 15.sp,
                                  ),
                                ],
                              ),
                              AppBox(
                                  elevation: 0,
                                  bgColor: statusBgColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 0.5.h),
                                    child: AppTextMedium(
                                      text: leave.leaveStatusText,
                                      fontFamily: FontFamily.raleway,
                                      color: statusTextColor,
                                      fontSize: 14.sp,
                                    ),
                                  ))
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  App3DButton(
                    width: 45.w,
                    backgroundColor: Theme.of(context).primaryColor,
                    borderColor: greenishBlack,
                    tap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ApplyForLeaveView())).then((val) {
                        value.getAllLeaves();
                      });
                    },
                    child: AppTextBold(
                      text: "APPLY FOR LEAVE",
                      color: whiteColor,
                      fontFamily: FontFamily.raleway,
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
