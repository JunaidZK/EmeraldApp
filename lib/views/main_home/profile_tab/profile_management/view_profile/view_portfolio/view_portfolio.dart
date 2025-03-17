import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_dotted_upload.dart';
import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/model_class/home_tab/employee_services.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewPortfolio extends StatelessWidget {
  final ServiceData portfolio;
  const ViewPortfolio({required this.portfolio, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: appBar(context,
          appBarheight: 8.h,
          title: localization!.locale.languageCode == "en"
              ? portfolio.service!.name
              : portfolio.service!.arabicName,
          leftWidget: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Transform.flip(
                flipX: localization.locale.languageCode == "ar",
                child: const AppSvg(
                    svgName: arrowBack,
                    boxfit: BoxFit.none,
                    alignment: Alignment.center),
              ))),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.5.h),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 3.w, // Horizontal space between items
            runSpacing: 2.h, // Vertical space between lines of items
            verticalDirection: VerticalDirection.down,
            textDirection: localization.locale.languageCode == "en"
                ? TextDirection.ltr
                : TextDirection.rtl,
            children: [
              if (portfolio.portfolio.isNotEmpty)
                ...portfolio.portfolio.map((image) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                                width: 27.5.w,
                                height: 12.5.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: AspectRatio(
                                    aspectRatio: 1.5,
                                    child: AppNetworkImage(
                                        image: image.path,
                                        fit: BoxFit.cover)))),
                      ]);
                }),

              // Add New Button (AppDottedUpload widget)
              GestureDetector(
                onTap: () {
                  debugPrint("add porfolio");
                },
                child: AppDottedUpload(
                  svg: roundedAdd,
                  padding: EdgeInsets.only(
                      right: localization.locale.languageCode == "en"
                          ? 62.5.w
                          : 0.w,
                      left: localization.locale.languageCode == "ar"
                          ? 62.5.w
                          : 0.w),
                  innerPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: 3.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            App3DButton(
              backgroundColor: Theme.of(context).primaryColor,
              borderColor: greenishBlack,
              width: 60.w,
              tap: () {
                Navigator.pop(context);
              },
              child: AppTextBold(
                text: localization.translate("SAVE"),
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
}
