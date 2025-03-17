import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/contact_us/contact_us_provider.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/customer_support_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<CustomerSupportProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => ContactUsProvider(),
      child: Consumer<ContactUsProvider>(builder: (context, provider, child) {
        if (value.contactInfo!.data.socialMediaLinks.isNotEmpty) {
          return ListView.builder(
              itemCount: value.contactInfo!.data.socialMediaLinks.length,
              itemBuilder: (context, index) {
                var contactInfo =
                    value.contactInfo!.data.socialMediaLinks[index];

                String? contactText =
                    provider.getSocialMediaText(contactInfo.type);
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.25.h),
                  child: GestureDetector(
                    onTap: () async {
                      String url = contactInfo.url;
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        debugPrint("Could not launch $url");
                      }
                    },
                    child: AppBox(
                        elevation: 0,
                        bgColor: whiteColor,
                        borderColor: greenishBlack,
                        borderWidth: 0.5,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 5.w, top: 1.h, bottom: 1.h, right: 0),
                          child: Row(
                            children: [
                              AppCircularImage(
                                imgHeight: 4.h,
                                networkImage: contactInfo.iconUrl,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 5.w),
                              AppTextSemiBold(
                                text: contactText!,
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.hermann,
                                fontSize: 18.sp,
                              )
                            ],
                          ),
                        )),
                  ),
                );
              });
        } else {
          return Center(
            child: AppTextMedium(
              text: "No Contact Info",
              fontFamily: FontFamily.raleway,
              fontSize: 14.sp,
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      }),
    );
  }
}
