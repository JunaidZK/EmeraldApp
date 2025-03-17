import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_search_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/review/app_give_review_provider.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/globals.dart';
import 'package:emerald_beauty/views/main_home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppGiveReview extends StatelessWidget {
  final int bookingId;
  final String name;
  const AppGiveReview({required this.bookingId, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppGiveReviewProvider(),
      child: Consumer<AppGiveReviewProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const AppSvg(svgName: close),
                  ),
                ),
                AppSvg(
                  svgName: ratingIMG,
                  width: 4.w,
                  height: 8.h,
                ),
                SizedBox(height: 1.h),
                AppTextBold(
                  text: "RATE YOUR EXPERIENCE",
                  color: Theme.of(context).primaryColor,
                  fontFamily: FontFamily.hermann,
                  fontSize: 18.5.sp,
                ),
                SizedBox(height: 1.h),
                AppTextRegular(
                  text: "How was your experience?",
                  color: grayColor,
                  fontFamily: FontFamily.raleway,
                  fontSize: 16.5.sp,
                ),
                SizedBox(height: 0.5.h),
                AppCircularImage(
                  imgHeight: 6.h,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 1.h),
                AppTextSemiBold(
                  text: name,
                  fontFamily: FontFamily.hermann,
                  fontSize: 16.sp,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 1.5.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppTextBold(
                    text: "Ratings",
                    color: Theme.of(context).primaryColor,
                    fontFamily: FontFamily.hermann,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.25.w),
                      child: GestureDetector(
                          onTap: () {
                            value.rating = index + 1;
                          },
                          child: AppSvg(
                            svgName: stars,
                            width: 5.w,
                            height: 2.h,
                            color:
                                index < value.rating ? null : transparentColor,
                          )),
                    );
                  }),
                ),
                SizedBox(height: 0.75.h),
                AppSearchField(
                  cntrller: value.reviewController,
                  minLine: 4,
                  icon: null,
                  text: "Your Review",
                  fillColor: lightAqua.withValues(alpha: 0.1),
                  contentPadding: EdgeInsets.only(left: 3.5.w, top: 1.h),
                  submitLabel: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 0.75.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     AppTextBold(
                //       text: "Attached Photos/Videos",
                //       fontFamily: FontFamily.hermann,
                //       color: Theme.of(context).primaryColor,
                //       fontSize: 15.sp,
                //     ),
                //     AppTextBold(
                //       text: "0/5",
                //       fontFamily: FontFamily.hermann,
                //       color: Theme.of(context).primaryColor,
                //       fontSize: 15.sp,
                //     ),
                //   ],
                // ),
                // SizedBox(height: 1.25.h),
                // AppDottedUpload(
                //   svg: roundedAdd,
                //   padding: EdgeInsets.only(right: 65.w),
                //   innerPadding:
                //       EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                // ),
                // SizedBox(height: 1.h),
                App3DButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  borderColor: greenishBlack,
                  tap: () async {
                    await value.giveReview(id: bookingId).then((val) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          AnimatedNavigation.bottomSlide(MainHomeView(
                            requestFrom: Provider.of<GlobalProvider>(context,
                                    listen: false)
                                .globalRequestFrom!,
                            user: Provider.of<GlobalProvider>(context,
                                    listen: false)
                                .globalUser,
                          )));
                    });
                  },
                  child: AppTextBold(
                    text: "SUBMIT",
                    color: whiteColor,
                    fontFamily: FontFamily.raleway,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
