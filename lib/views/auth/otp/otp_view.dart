import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_auth_bottom_text.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_otp_field.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/auth/login/login_view.dart';
import 'package:emerald_beauty/views/auth/otp/otp_provider.dart';
import 'package:emerald_beauty/views/auth/reset_password/reset_password_view.dart';
import 'package:emerald_beauty/views/auth/under_verification/under_verification_view.dart';
import 'package:emerald_beauty/views/auth/user_choice/user_choice_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OtpView extends StatelessWidget {
  final RequestFrom requestFrom;
  final DisplayType? displayType;
  final Users? user;
  final String input;
  const OtpView(
      {required this.requestFrom,
      this.displayType,
      this.user,
      required this.input,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpProvider(),
      child: Consumer<OtpProvider>(builder: (context, provider, child) {
        if (displayType == DisplayType.login && !provider.hasTriggeredOtp) {
          Future.microtask(() {
            provider.reSendOtp(context, input: input, requesFrom: requestFrom);
            provider.markOtpTriggered(); // Mark as triggered
          });
        }
        return Stack(
          children: [
            Scaffold(
              body: SafeArea(
                  child: CustomScrollView(slivers: <Widget>[
                const AppSilverBar(),
                SliverToBoxAdapter(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1.25.h),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const AppSvg(svgName: arrowBack),
                              ),
                              SizedBox(height: 0.5.h),
                              AppTextMedium(
                                text: "OTP\nVERIFICATION",
                                color: Theme.of(context).primaryColor,
                                fontSize: 23.sp,
                              ),
                              SizedBox(height: 2.h),
                              AppTextRegular(
                                text:
                                    'Enter your 4-digit code sent on your associated\n${requestFrom == RequestFrom.email ? 'email address' : 'mobile number'}',
                                fontSize: 16.5.sp,
                                color: grayColor,
                              ),
                              SizedBox(height: 1.75.h),
                              AppOtpField(
                                onOtpEntered: (enteredOtp) {
                                  provider.otp =
                                      enteredOtp; // Store the OTP entered
                                },
                              ),
                              SizedBox(height: 1.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    String result = await provider.reSendOtp(
                                        context,
                                        input: input,
                                        requesFrom: requestFrom);

                                    showToast(result);
                                  },
                                  child: AppTextMedium(
                                    text: "Resend OTP",
                                    color: lightTurquoise,
                                    fontSize: 12.sp,
                                    fontFamily: FontFamily.raleway,
                                  ),
                                ),
                              )
                            ])))
              ])),
              bottomNavigationBar: Padding(
                padding:
                    EdgeInsets.only(bottom: 1.5.h), // Adjust padding as needed
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    App3DButton(
                      tap: () async {
                        String? result = await provider.verifyOtp(context,
                            input: input,
                            requesFrom: requestFrom,
                            displayType: displayType!);

                        if (result == null) {
                          if (displayType == DisplayType.forget) {
                            Navigator.push(
                                context,
                                AnimatedNavigation.bottomSlide(
                                    ResetPasswordView(
                                  requestFrom: requestFrom,
                                  input: input,
                                  otp: provider.otp,
                                  user: user,
                                )));
                          } else if (displayType == DisplayType.register) {
                            Navigator.push(
                                context,
                                AnimatedNavigation.bottomSlide(
                                    const UnderVerificationView()));
                          } else {
                            Navigator.push(
                                context,
                                AnimatedNavigation.bottomSlide(LoginView(
                                  requesFrom: requestFrom,
                                  user: user!,
                                )));
                          }
                        } else {
                          showToast(result);
                        }
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      borderColor: greenishBlack,
                      child: AppTextSemiBold(
                        text: "VERIFY",
                        fontSize: 17.sp,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Visibility(
                      visible: user != Users.employee,
                      child: AppAuthBottomText(
                        lightText: "Already have an account?",
                        boldText: "Login",
                        lightTextColor: greenishBlack,
                        btnTextColor: lightTurquoise,
                        boldTextPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserChoiceView(
                                  display: DisplayType.login),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(visible: provider.isLoading, child: const Loader())
          ],
        );
      }),
    );
  }
}
