import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_check_box.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_button.dart';
import 'package:emerald_beauty/components/filter/filteration_provider.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppFilteration extends StatefulWidget {
  final List<String> filterOptions;

  const AppFilteration({this.filterOptions = const ["Completed", "Pending Approval", "Confirmed", "In Progress", "Cancelled"], super.key});

  @override
  State<AppFilteration> createState() => _AppFilterationState();
}

class _AppFilterationState extends State<AppFilteration> {
  AppStateController appStateController = Get.put(AppStateController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FilterationProvider(widget.filterOptions.length), // Initialize provider
        child: Consumer<FilterationProvider>(builder: (context, filterProvider, child) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(height: 2.5.h),
                Container(width: 10.w, height: 1.h, decoration: BoxDecoration(color: grayColor, borderRadius: BorderRadius.circular(12.0))),
                SizedBox(height: 1.25.h),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  AppTextButton(text: "Cancel", fontFamily: FontFamily.raleway, fontSize: 16.sp, textColor: grayColor, tap: () => Navigator.pop(context)),
                  AppTextBold(text: "FILTER", fontFamily: FontFamily.hermann, fontSize: 18.sp, color: Theme.of(context).primaryColor),
                  AppTextButton(text: "Reset", fontFamily: FontFamily.raleway, fontSize: 16.sp, textColor: redColor, tap: () => filterProvider.resetFilters())
                ]),
                SizedBox(height: 0.25.h),
                const Divider(color: whiteShade),
                SizedBox(height: 0.75.h),
                Expanded(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.filterOptions.length,
                        itemBuilder: (context, index) => Row(children: [
                              AppCheckBox(value: filterProvider.selectedFilters[index], changed: (value) => filterProvider.toggleFilter(index)),
                              SizedBox(width: 1.25.w),
                              AppTextMedium(text: widget.filterOptions[index], fontFamily: FontFamily.raleway, fontSize: 16.sp, color: grayColor)
                            ]))),
                App3DButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    borderColor: greenishBlack,
                    child: AppTextBold(text: "APPLY", color: whiteColor, fontFamily: FontFamily.raleway, fontSize: 18.sp),
                    tap: () {
                      List<String> appliedFilters = filterProvider.getAppliedFilters(widget.filterOptions);
                      appStateController.bookingFilterList.value = appliedFilters;
                      Navigator.pop(context, appliedFilters);
                    }),
                SizedBox(height: 2.5.h)
              ]));
        }));
  }
}
