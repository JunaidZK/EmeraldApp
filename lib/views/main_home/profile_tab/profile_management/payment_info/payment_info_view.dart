import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/payment_info/payment_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentInfoView extends StatefulWidget {
  const PaymentInfoView({super.key});

  @override
  State<PaymentInfoView> createState() => _PaymentInfoViewState();
}

class _PaymentInfoViewState extends State<PaymentInfoView> {
  late PaymentInfoProvider paymentProvider;

  @override
  void initState() {
    super.initState();
    paymentProvider = PaymentInfoProvider();
    paymentProvider.getPaymentInfo();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => paymentProvider,
      child: Consumer<PaymentInfoProvider>(builder: (context, value, child) {
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
            title: localization.translate("PAYMENT INFORMATION"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextBold(
                    text: localization.translate("Bank Account Details"),
                    fontFamily: FontFamily.hermann,
                    color: Theme.of(context).primaryColor,
                    fontSize: 17.sp,
                  ),
                  AppTextMedium(
                    text: localization.translate(
                        "Payments will be processed manually by the admin."),
                    fontFamily: FontFamily.raleway,
                    color: grayColor,
                    fontSize: 13.sp,
                  ),
                  SizedBox(height: 1.5.h),
                  AppTextBold(
                    text: localization.translate("Account Details"),
                    fontFamily: FontFamily.hermann,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.sp,
                  ),
                  AppTextField(
                    textController: value.accountHolderName,
                    placeholder:
                        localization.translate("Enter Account Holder Name"),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: grayColor)),
                  ),
                  SizedBox(height: 1.5.h),
                  AppTextBold(
                    text: localization.translate("Bank Name"),
                    fontFamily: FontFamily.hermann,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.sp,
                  ),
                  AppTextField(
                    textController: value.bankName,
                    placeholder: localization.translate("Enter Bank Name"),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: grayColor)),
                  ),
                  SizedBox(height: 1.5.h),
                  AppTextBold(
                    text: localization.translate("Account number"),
                    fontFamily: FontFamily.hermann,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.sp,
                  ),
                  AppTextField(
                    textController: value.accountNo,
                    placeholder:
                        localization.translate("Enter Bank Account No#"),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: grayColor)),
                  ),
                  SizedBox(height: 1.5.h),
                  AppTextBold(
                    text: localization.translate("IBAN"),
                    fontFamily: FontFamily.hermann,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.sp,
                  ),
                  AppTextField(
                    textController: value.ibaNo,
                    placeholder: localization.translate("Enter IBAN No#"),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: grayColor)),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                App3DButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  borderColor: greenishBlack,
                  tap: () async {
                    if (value.bankAccountDetails != null) {
                      value.updatePaymentInfo();
                    } else {
                      value.addNewPaymentInfo();
                    }
                  },
                  child: AppTextBold(
                    text: value.bankAccountDetails != null
                        ? localization.translate("UPDATE")
                        : localization.translate("SAVE"),
                    color: whiteColor,
                    fontFamily: FontFamily.hermann,
                    fontSize: 19.sp,
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
