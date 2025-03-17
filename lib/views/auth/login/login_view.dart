import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_auth_bottom_text.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_check_box.dart';
import 'package:emerald_beauty/components/app_mobile_field.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_button.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/globals.dart';
import 'package:emerald_beauty/views/auth/forgot_password/forgot_password_view.dart';
import 'package:emerald_beauty/views/auth/login/login_provider.dart';
import 'package:emerald_beauty/views/auth/otp/otp_view.dart';
import 'package:emerald_beauty/views/auth/under_verification/under_verification_view.dart';
import 'package:emerald_beauty/views/auth/user_choice/user_choice_view.dart';
import 'package:emerald_beauty/views/main_home/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends StatelessWidget {
  final RequestFrom requesFrom;
  final Users user;
  const LoginView({required this.requesFrom, this.user = Users.freelancer, super.key});
// robert@gmail.com
// Demo@123
// nofilraheel@teamx.global

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Consumer<LoginProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            Form(
              key: provider.loginFormKey,
              child: Scaffold(
                body: SafeArea(
                    child: CustomScrollView(slivers: <Widget>[
                  const AppSilverBar(),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(height: 1.25.h),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const AppSvg(svgName: arrowBack),
                            ),
                            SizedBox(height: 0.5.h),
                            AppTextMedium(
                              text: "WELCOME\nBACK!",
                              color: Theme.of(context).primaryColor,
                              fontSize: 23.sp,
                            ),
                            SizedBox(height: 2.h),
                            AppTextRegular(
                              text: 'To book your favorite beauty services.',
                              fontSize: 16.5.sp,
                              color: grayColor,
                            ),
                            SizedBox(height: 1.75.h),
                            Visibility(
                              visible: requesFrom == RequestFrom.email,
                              child: AppTextField(
                                textController: provider.inputField,
                                placeholder: "Email Address",
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is required.";
                                  }
                                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                                  if (!emailRegex.hasMatch(value)) {
                                    return "Please enter a valid email address.";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Visibility(
                                visible: requesFrom == RequestFrom.phone,
                                child: AppMobileTextfield(
                                  textController: provider.inputField,
                                  placeholder: "Mobile Number",
                                  onChanged: (PhoneNumber phoneNumber) {
                                    String fullPhoneNumber = phoneNumber.completeNumber;

                                    provider.setPhoneNumber(fullPhoneNumber);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Mobile number is required.";
                                    }
                                    final phoneRegex = RegExp(r'^\d{10,15}$');
                                    if (!phoneRegex.hasMatch(value)) {
                                      return "Please enter a valid mobile number.";
                                    }
                                    return null;
                                  },
                                )),
                            SizedBox(height: 0.5.h),
                            AppTextField(
                              textController: provider.passwordField,
                              placeholder: "Password",
                              obscureText: provider.hidePassword,
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  provider.hidePassword = !provider.hidePassword;
                                },
                                child: Icon(
                                  provider.hidePassword ? Icons.visibility : Icons.visibility_off,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required.";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters.";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 0.5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AppCheckBox(
                                      value: provider.checkBoxValue,
                                      changed: (val) {
                                        provider.checkBoxValue = val!;
                                      },
                                      activeColor: lightTurquoise,
                                      borderColor: lightTurquoise,
                                    ),
                                    AppTextRegular(
                                      text: "Remember me",
                                      color: lightTurquoise,
                                      fontFamily: FontFamily.raleway,
                                      fontSize: 14.sp,
                                    )
                                  ],
                                ),
                                AppTextButton(
                                  tap: () {
                                    if (user != Users.employee) {
                                      Navigator.push(context, AnimatedNavigation.bottomSlide(const UserChoiceView(display: DisplayType.forget)));
                                    } else {
                                      Navigator.push(context, AnimatedNavigation.bottomSlide(ForgotPasswordView(requesFrom: RequestFrom.email, user: user)));
                                    }
                                  },
                                  text: "Forgot Password?",
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                          ])))
                ])),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(bottom: 1.h), // Adjust padding as needed
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      App3DButton(
                        tap: () async {
                          if (provider.loginFormKey.currentState!.validate()) {
                            String? result = await provider.login(requesFrom: requesFrom, user: user);

                            if (result == null) {
                              Provider.of<GlobalProvider>(context, listen: false).globalRequestFrom = requesFrom;
                              Provider.of<GlobalProvider>(context, listen: false).globalUser = user;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  AnimatedNavigation.bloomNavigation(context,
                                      page: MainHomeView(
                                        user: user,
                                        requestFrom: requesFrom,
                                      )),
                                  (Route<dynamic> route) => false);
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   AnimatedNavigation.bloomNavigation(context,
                              //       page: MainHomeView(
                              //         user: user,
                              //       )),
                              //   (Route<dynamic> route) => false,
                              // );
                            } else if (result.contains("OTP verification incomplete")) {
                              Navigator.push(
                                  context,
                                  AnimatedNavigation.bottomSlide(OtpView(
                                    requestFrom: requesFrom,
                                    input: requesFrom == RequestFrom.email ? provider.inputField.text : provider.phoneNumberWithCountryCode,
                                    displayType: DisplayType.login,
                                    user: user,
                                  )));
                            } else if (result.contains("Account not verified by admin")) {
                              Navigator.push(context, AnimatedNavigation.bottomSlide(const UnderVerificationView()));
                            } else {
                              showToast(result);
                            }
                          }
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: greenishBlack,
                        child: AppTextSemiBold(
                          text: "LOGIN",
                          fontSize: 17.sp,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(height: 1.25.h),
                      Visibility(
                        visible: user != Users.employee,
                        child: AppAuthBottomText(
                          lightText: "Don't have an account?",
                          boldText: "Register",
                          lightTextColor: greenishBlack,
                          btnTextColor: lightTurquoise,
                          boldTextPressed: () {
                            Navigator.pushReplacement(context, AnimatedNavigation.bottomSlide(const UserChoiceView(display: DisplayType.register)));
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
