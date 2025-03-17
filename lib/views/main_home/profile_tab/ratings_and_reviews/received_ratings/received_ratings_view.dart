import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/ratings_and_reviews/received_ratings/received_ratings_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReceivedRatingsView extends StatelessWidget {
  const ReceivedRatingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => ReceivedRatingsProvider(),
      child: Consumer<ReceivedRatingsProvider>(
        builder: (context, value, child) {
          // Check if data is still loading
          if (value.review == null) {
            return const Center(child: Loader());
          }

          return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
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
                title: localization.translate("RATING AND REVIEWS"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(5, (index) {
                                int rating = 5 - index;
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 0.5.h),
                                  child: Row(
                                    children: [
                                      AppTextMedium(
                                        text: "$rating",
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: FontFamily.raleway,
                                        fontSize: 13.sp,
                                      ),
                                      SizedBox(width: 2.w),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                          value: (value.ratingPercentages[
                                                      rating] ??
                                                  0) /
                                              100,
                                          color: yellowColor,
                                          backgroundColor: transparentColor,
                                          minHeight: 1.h,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      AppTextRegular(
                                        text:
                                            "${value.ratingCounts[rating] ?? 0}",
                                        color: grayColor,
                                        fontFamily: FontFamily.raleway,
                                        fontSize: 12.5.sp,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Column(
                            children: [
                              AppTextSemiBold(
                                text: value.overallRating.toStringAsFixed(1),
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.hermann,
                                fontSize: 19.sp,
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  double rating = value
                                      .overallRating; // Get the average rating
                                  int fullStars =
                                      rating.floor(); // Number of full stars
                                  // Check if there's a half star

                                  return Padding(
                                    padding: EdgeInsets.only(right: 1.w),
                                    child: AppSvg(
                                      svgName: stars,
                                      width: 12.5.w,
                                      height: 2.h,
                                      color: index < fullStars
                                          ? null // Full stars
                                          : lightGray, // Empty stars
                                    ),
                                  );
                                }),
                              ),
                              AppTextRegular(
                                text:
                                    "${value.totalReviews} ${localization.translate("Reviews")}",
                                fontFamily: FontFamily.raleway,
                                color: grayColor,
                                fontSize: 14.5.sp,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Column(
                        children: value.review!.data.reviews.map((review) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 1.5.h),
                            child: AppBox(
                              elevation: 0,
                              bgColor: whiteColor,
                              borderColor: greenishBlack,
                              borderWidth: 0.5,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppTextBold(
                                                  text:
                                                      "${review.user.firstName} ${review.user.lastName}",
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontFamily:
                                                      FontFamily.hermann,
                                                  fontSize: 15.sp,
                                                ),
                                                SizedBox(height: 0.75.h),
                                                Row(
                                                  children: List.generate(5,
                                                      (starIndex) {
                                                    return AppSvg(
                                                      svgName: stars,
                                                      width: 15.sp,
                                                      height: 1.25.h,
                                                      color: starIndex <
                                                              review.rating
                                                          ? Colors.orange
                                                          : Colors.grey,
                                                    );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        AppTextRegular(
                                          text: DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(review.createdAt)),
                                          color: grayColor,
                                          fontFamily: FontFamily.raleway,
                                          fontSize: 13.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    AppTextRegular(
                                      text: review.review,
                                      fontFamily: FontFamily.raleway,
                                      color: grayColor,
                                      fontSize: 15.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
