import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/expertise/expertise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExpertiseView extends StatelessWidget {
  const ExpertiseView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
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
        title: localization.translate("EXPERTISE"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ExpertiseProvider(),
        child: Consumer<ExpertiseProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: GridView.builder(
                itemCount: value.expertise.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items per row
                    mainAxisSpacing: 16.0, // Spacing between rows
                    crossAxisSpacing: 16.0, // Spacing between columns
                    childAspectRatio:
                        0.115.h // Adjust for item height/width ratio
                    ),
                itemBuilder: (context, index) {
                  var expertise = value.expertise[index];
                  Color statusColor =
                      value.expertise[index]["status"] == "Verified"
                          ? lightTurquoise
                          : value.expertise[index]["status"] == "Pending"
                              ? yellowColor
                              : redColor;
                  return AppBox(
                      elevation: 0,
                      bgColor: whiteColor,
                      borderColor: greenishBlack,
                      borderWidth: 0.5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.5.w, vertical: 1.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50.w,
                              height: 8.5.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(expertise['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            SizedBox(height: 1.5.h),
                            AppTextSemiBold(
                              text: expertise["expertise"]!,
                              color: Theme.of(context).primaryColor,
                              fontFamily: FontFamily.raleway,
                              fontSize: 15.5.sp,
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                AppTextSemiBold(
                                  text: "Status : ",
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: FontFamily.raleway,
                                  fontSize: 14.5.sp,
                                ),
                                AppTextSemiBold(
                                  text: expertise['status']!,
                                  color: statusColor,
                                  fontFamily: FontFamily.raleway,
                                  fontSize: 14.5.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
