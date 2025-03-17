import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_auth_bottom_text.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/auth/forgot_password/forgot_password_view.dart';
import 'package:emerald_beauty/views/auth/login/login_view.dart';
import 'package:emerald_beauty/views/auth/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserChoiceView extends StatelessWidget {
  final DisplayType display;
  final Users? user;
  const UserChoiceView({required this.display, this.user, super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    text: display == DisplayType.login
                        ? "LOG IN TO YOUR\nACCOUNT"
                        : display == DisplayType.forget
                            ? "RESET\nPASSWORD"
                            : "CREATE YOUR\nACCOUNT",
                    color: primaryColor,
                    fontSize: 23.sp,
                    fontFamily: FontFamily.raleway,
                  ),
                  SizedBox(height: 2.h),
                  AppTextMedium(
                    text: display == DisplayType.login
                        ? 'Choose how you\'d like to log in:'
                        : display == DisplayType.forget
                            ? "How would you like to reset your password?"
                            : 'Choose how you\'d like to sign up:',
                    fontSize: 16.5.sp,
                    color: grayColor,
                    fontFamily: FontFamily.raleway,
                  ),
                  SizedBox(height: 1.75.h),
                  App3DButton(
                      tap: () {
                        if (display == DisplayType.login) {
                          Navigator.push(context, AnimatedNavigation.bottomSlide(const LoginView(requesFrom: RequestFrom.email)));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const LoginView(
                          //             requesFrom: RequestFrom.email)));
                        }
                        if (display == DisplayType.register) {
                          Navigator.push(context, AnimatedNavigation.bottomSlide(const RegisterView(requestFrom: RequestFrom.email)));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const RegisterView(
                          //             requestFrom: RequestFrom.email)));
                        }
                        if (display == DisplayType.forget) {
                          Navigator.push(context, AnimatedNavigation.bottomSlide(const ForgotPasswordView(requesFrom: RequestFrom.email)));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const ForgotPasswordView(
                          //             requesFrom: RequestFrom.email)));
                        }
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      borderColor: greenishBlack,
                      width: width,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const AppSvg(svgName: mail),
                        SizedBox(width: 5.w),
                        AppTextRegular(
                            text: display == DisplayType.login
                                ? "SIGN IN WITH EMAIL ADDRESS"
                                : display == DisplayType.forget
                                    ? "VIA EMAIL ADDRESS"
                                    : "SIGN UP WITH EMAIL ADDRESS",
                            color: whiteColor,
                            fontSize: 17.sp)
                      ])),
                  SizedBox(height: 1.5.h),
                  App3DButton(
                    tap: () {
                      if (display == DisplayType.login) {
                        Navigator.push(context, AnimatedNavigation.bottomSlide(const LoginView(requesFrom: RequestFrom.phone)));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const LoginView(
                        //             requesFrom: RequestFrom.phone)));
                      }
                      if (display == DisplayType.register) {
                        Navigator.push(context, AnimatedNavigation.bottomSlide(const RegisterView(requestFrom: RequestFrom.phone)));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const RegisterView(
                        //             requestFrom: RequestFrom.phone)));
                      }
                      if (display == DisplayType.forget) {
                        Navigator.push(context, AnimatedNavigation.bottomSlide(const ForgotPasswordView(requesFrom: RequestFrom.phone)));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const ForgotPasswordView(
                        //             requesFrom: RequestFrom.phone)));
                      }
                    },
                    backgroundColor: secondaryPrimaryColor,
                    borderColor: greenishBlack,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppSvg(
                          svgName: phone,
                        ),
                        SizedBox(width: 5.w),
                        AppTextThin(
                          text: display == DisplayType.login
                              ? "SIGN IN WITH MOBILE NUMBER"
                              : display == DisplayType.forget
                                  ? "VIA MOBILE NUMBER"
                                  : "SIGN UP WITH MOBILE NUMBER",
                          color: whiteColor,
                          fontSize: 17.sp,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 1.h),
        child: AppAuthBottomText(
          lightText: display == DisplayType.login ? "Don't have an account?" : "Already have an account?",
          lightTextColor: greenishBlack,
          boldText: display == DisplayType.login ? "Register" : "Login",
          btnTextColor: lightTurquoise,
          boldTextPressed: () {
            if (display == DisplayType.login) {
              Navigator.pushReplacement(context, AnimatedNavigation.bottomSlide(const UserChoiceView(display: DisplayType.register)));
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             const UserChoiceView(display: DisplayType.register)));
            }
            if (display == DisplayType.register) {
              Navigator.pushReplacement(context, AnimatedNavigation.bottomSlide(const UserChoiceView(display: DisplayType.login)));
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             const UserChoiceView(display: DisplayType.login)));
            }
          },
        ),
      ),
    );
  }
}
