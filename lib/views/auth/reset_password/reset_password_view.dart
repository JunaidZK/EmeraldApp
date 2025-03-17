import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_auth_bottom_text.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/auth/login/login_view.dart';
import 'package:emerald_beauty/views/auth/reset_password/reset_password_provider.dart';
import 'package:emerald_beauty/views/auth/user_choice/user_choice_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordView extends StatelessWidget {
  final RequestFrom requestFrom;
  final Users? user;
  final String input;
  final String otp;
  const ResetPasswordView(
      {required this.requestFrom,
      required this.input,
      required this.otp,
      this.user,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ResetPasswordProvider(),
        child: Consumer<ResetPasswordProvider>(
            builder: (context, provider, child) {
          return Stack(
            children: [
              Form(
                key: provider.newPasswordFormKey,
                child: Scaffold(
                  body: SafeArea(
                      child: CustomScrollView(
                    slivers: <Widget>[
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
                                          'Set up a new password to regain access.',
                                      fontSize: 16.5.sp,
                                      color: grayColor,
                                    ),
                                    SizedBox(height: 1.75.h),
                                    Column(
                                      children: [
                                        AppTextField(
                                          textController:
                                              provider.newPasswordController,
                                          placeholder: "New Password",
                                          obscureText: provider.hideNewPassword,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              provider.hideNewPassword =
                                                  !provider.hideNewPassword;
                                            },
                                            child: Icon(
                                              provider.hideNewPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Password is required";
                                            }
                                            if (value.length < 8) {
                                              return "Password must be at least 8 characters long";
                                            }
                                            if (!RegExp(r'[A-Z]')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one uppercase letter";
                                            }
                                            if (!RegExp(r'[0-9]')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one numeric value";
                                            }
                                            if (!RegExp(r'[\W_]')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one special character";
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 0.5.h),
                                        AppTextField(
                                          textController: provider
                                              .confirmNewPasswordController,
                                          placeholder: "Confirm New Password",
                                          obscureText:
                                              provider.hideConfirmNewPassword,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              provider.hideConfirmNewPassword =
                                                  !provider
                                                      .hideConfirmNewPassword;
                                            },
                                            child: Icon(
                                              provider.hideConfirmNewPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Password is required";
                                            }
                                            if (value.length < 8) {
                                              return "Password must be at least 8 characters long";
                                            }
                                            if (!RegExp(r'[A-Z]')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one uppercase letter";
                                            }
                                            if (!RegExp(r'[0-9]')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one numeric value";
                                            }
                                            if (!RegExp(r'[\W_]')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one special character";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    )
                                  ])))
                    ],
                  )),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.only(
                        bottom: 1.h), // Adjust padding as needed
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        App3DButton(
                          tap: () async {
                            if (provider.newPasswordFormKey.currentState!
                                .validate()) {
                              String? result = await provider.resetPassword(
                                  requesFrom: requestFrom,
                                  input: input,
                                  otp: otp);

                              if (result == null) {
                                if (user == Users.employee) {
                                  Navigator.push(
                                      context,
                                      AnimatedNavigation.bottomSlide(LoginView(
                                        requesFrom: requestFrom,
                                        user: user!,
                                      )));
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   AnimatedNavigation.bottomSlide(LoginView(
                                  //     requesFrom: requestFrom,
                                  //     user: user!,
                                  //   )),
                                  //   (route) => false,
                                  // );
                                  // Navigator.push(
                                  //     context,
                                  //     AnimatedNavigation.bottomSlide(LoginView(
                                  //       requesFrom: RequestFrom.email,
                                  //       user: user!,
                                  //     )));
                                }
                              } else {
                                showToast(result);
                              }
                            }
                          },
                          backgroundColor: Theme.of(context).primaryColor,
                          borderColor: greenishBlack,
                          child: AppTextSemiBold(
                            text: "SAVE",
                            fontSize: 17.sp,
                            color: whiteColor,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
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
        }));
  }
}
