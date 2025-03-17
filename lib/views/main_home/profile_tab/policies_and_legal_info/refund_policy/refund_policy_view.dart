import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/policies_and_legal_info/refund_policy/refund_policy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RefundPolicyView extends StatelessWidget {
  const RefundPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => RefundPolicyProvider(),
      child:
          Consumer<RefundPolicyProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  appBar: appBar(
                    context,
                    appBarheight: 8.h,
                    title: localization!.translate("REFUND POLICY"),
                    leftWidget: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Transform.flip(
                        flipX: localization.locale.languageCode == "ar",
                        child: const AppSvg(
                          svgName: arrowBack,
                          boxfit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                  body: provider.refundPolicy?.data?.content != null
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 1.5.h),
                            child: Html(
                              data: localization.locale.languageCode == "en"
                                  ? provider.refundPolicy!.data!.content
                                  : provider.refundPolicy!.data!.arabicContent,
                              style: {
                                "h1": Style(
                                  fontSize:
                                      localization.locale.languageCode == "en"
                                          ? FontSize(20.sp)
                                          : FontSize(18.sp),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.hermann.name,
                                  color: Theme.of(context).primaryColor,
                                ),
                                "h2": Style(
                                  fontSize:
                                      localization.locale.languageCode == "en"
                                          ? FontSize(20.sp)
                                          : FontSize(18.sp),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.hermann.name,
                                  color: Theme.of(context).primaryColor,
                                ),
                                "h3": Style(
                                  fontSize:
                                      localization.locale.languageCode == "en"
                                          ? FontSize(20.sp)
                                          : FontSize(18.sp),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.hermann.name,
                                  color: Theme.of(context).primaryColor,
                                ),
                                "p": Style(
                                  fontSize:
                                      localization.locale.languageCode == "en"
                                          ? FontSize(16.sp)
                                          : FontSize(14.5.sp),
                                  color: Theme.of(context).primaryColor,
                                  lineHeight: LineHeight(0.1.h),
                                  fontFamily: FontFamily.hermann.name,
                                ),
                              },
                            ),
                          ),
                        )
                      : Center(
                          child: AppTextMedium(
                          text: "No Refund Policy",
                          fontFamily: FontFamily.raleway,
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                        )),
                )),
            if (provider.isLoading)
              const Center(
                child: Loader(),
              ),
          ],
        );
      }),
    );
  }
}
