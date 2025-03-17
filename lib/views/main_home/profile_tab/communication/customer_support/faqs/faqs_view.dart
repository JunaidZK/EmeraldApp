import 'package:emerald_beauty/components/app_container_box.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/customer_support_provider.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/faqs/faqs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FaqsView extends StatelessWidget {
  const FaqsView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerSupportProvider>(context);
    final localization = AppLocalizations.of(context);

    return ChangeNotifierProvider(
        create: (_) => FaqsProvider(),
        child: Consumer<FaqsProvider>(
          builder: (context, value, child) {
            if (provider.faqs == null || provider.faqs!.data.data.isEmpty) {
              return Center(
                child: AppTextRegular(
                  text: localization!.translate("No FAQs"),
                  color: Theme.of(context).primaryColor,
                  fontFamily: FontFamily.raleway,
                  fontSize: 16.sp,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: provider.faqs!.data.data.length,
                  itemBuilder: (context, index) {
                    var faq = provider.faqs!.data.data[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5.h),
                      child: GestureDetector(
                        onTap: () {
                          value.toggleFaq(faq.id);
                        },
                        child: AppContainerBox(
                          bgColor: Colors.transparent,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: AppTextSemiBold(
                                      text: localization!.locale.languageCode ==
                                              "en"
                                          ? faq.question
                                          : faq.arabicQuestion,
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: FontFamily.hermann,
                                      fontSize:
                                          localization.locale.languageCode ==
                                                  "en"
                                              ? 17.sp
                                              : 15.sp,
                                    ),
                                  ),
                                  AnimatedRotation(
                                    turns: value.openedFaqIndex == faq.id
                                        ? 0.5
                                        : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Icon(
                                      Icons.add,
                                      color: Theme.of(context).primaryColor,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: value.openedFaqIndex == faq.id
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 0.5.h,
                                        ),
                                        child: AppTextRegular(
                                          text: localization
                                                      .locale.languageCode ==
                                                  "ar"
                                              ? faq.answer
                                              : faq.arabicAnswer,
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: FontFamily.raleway,
                                          fontSize: localization
                                                      .locale.languageCode ==
                                                  "en"
                                              ? 15.sp
                                              : 13.sp,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
