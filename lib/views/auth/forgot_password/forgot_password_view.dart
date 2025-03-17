import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_auth_bottom_text.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_mobile_field.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/auth/forgot_password/forgot_password_provider.dart';
import 'package:emerald_beauty/views/auth/otp/otp_view.dart';
import 'package:emerald_beauty/views/auth/user_choice/user_choice_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordView extends StatelessWidget {
  final RequestFrom requesFrom;
  final Users? user;
  final DisplayType displayType;
  const ForgotPasswordView(
      {required this.requesFrom,
      this.user,
      this.displayType = DisplayType.forget,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordProvider(),
      child:
          Consumer<ForgotPasswordProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            Form(
              key: provider.forgetPasswordFormKey,
              child: Scaffold(
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
                                  text: "RESET\nPASSWORD",
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 23.sp,
                                ),
                                SizedBox(height: 2.h),
                                AppTextRegular(
                                  text:
                                      'Enter your registered ${requesFrom == RequestFrom.email ? 'email address' : 'phone number'} to\nrecieve a code.',
                                  fontSize: 17.5.sp,
                                  color: grayColor,
                                ),
                                SizedBox(height: 0.25.h),
                                Visibility(
                                    visible: requesFrom == RequestFrom.email,
                                    child: AppTextField(
                                      textController: provider.inputController,
                                      placeholder: 'Email Address',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Email is required.";
                                        }
                                        final emailRegex = RegExp(
                                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                                        if (!emailRegex.hasMatch(value)) {
                                          return "Please enter a valid email address.";
                                        }
                                        return null;
                                      },
                                    )),
                                Visibility(
                                    visible: requesFrom == RequestFrom.phone,
                                    child: AppMobileTextfield(
                                      textController: provider.inputController,
                                      placeholder: "Mobile Number",
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Mobile number is required.";
                                        }
                                        final phoneRegex =
                                            RegExp(r'^\d{10,15}$');
                                        if (!phoneRegex.hasMatch(value)) {
                                          return "Please enter a valid mobile number.";
                                        }
                                        return null;
                                      },
                                    ))
                              ])))
                ])),
                bottomNavigationBar: Padding(
                  padding:
                      EdgeInsets.only(bottom: 1.h), // Adjust padding as needed
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      App3DButton(
                        tap: () async {
                          if (provider.forgetPasswordFormKey.currentState!
                              .validate()) {
                            String? result = await provider.forgetPass(
                                requestFrom: requesFrom);

                            if (result == null) {
                              Navigator.push(
                                  context,
                                  AnimatedNavigation.bottomSlide(OtpView(
                                    requestFrom: requesFrom,
                                    displayType: displayType,
                                    input: requesFrom == RequestFrom.email
                                        ? provider.inputController.text
                                        : provider.phoneNumberWithCountryCode,
                                    user: user,
                                  )));
                            } else {
                              showToast(result);
                            }
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => OtpView(
                          //               requestFrom: requesFrom,
                          //               displayType: DisplayType.forget,
                          //               user: user,
                          //             )));
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: greenishBlack,
                        child: AppTextSemiBold(
                          text: "SEND CODE",
                          fontSize: 17.sp,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(height: 1.25.h),
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
            ),
            Visibility(visible: provider.isLoading, child: const Loader())
          ],
        );
      }),
    );
  }
}
