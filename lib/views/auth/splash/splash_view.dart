import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/views/auth/login/login_view.dart';
import 'package:emerald_beauty/views/auth/splash/splash_provider.dart';
import 'package:emerald_beauty/views/auth/user_choice/user_choice_view.dart';
import 'package:flutter/material.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the Slide Animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 10), // Start off-screen at the bottom
      end: const Offset(0, 2.5), // End near the center
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => SplashProvider(),
      child: Consumer<SplashProvider>(builder: (context, provider, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // Set isAnimated to true in the provider
              provider.isAnimated = true;
            }
          });
        });
        return Scaffold(
          body: Stack(
            children: [
              // Background image
              AppImage(
                image: backgroundImage,
                width: width,
                height: height,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  SlideTransition(
                    position: _slideAnimation,
                    child: Center(
                      child: AppSvg(
                        svgName: iconImage,
                        width: 15.w,
                        height: 12.5.h,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: provider.isAnimated ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.decelerate,
                    child: Column(
                      children: [
                        SizedBox(height: 42.5.h),
                        AppTextHeavyBold(
                          text: 'Select Role',
                          fontSize: 18.sp,
                          fontFamily: FontFamily.hermann,
                        ),
                        SizedBox(height: 1.h),
                        App3DButton(
                          tap: () {
                            Navigator.push(
                                context,
                                AnimatedNavigation.bottomSlide(const LoginView(
                                    requesFrom: RequestFrom.email,
                                    user: Users.employee)));
                          },
                          backgroundColor: secondaryPrimaryColor,
                          borderColor: whiteColor,
                          child: AppTextHeavyBold(
                            text: "Employee",
                            fontSize: 14.5.sp,
                            color: whiteColor,
                            fontFamily: FontFamily.raleway,
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        App3DButton(
                          tap: () {
                            Navigator.push(
                                context,
                                AnimatedNavigation.bottomSlide(
                                    const UserChoiceView(
                                  display: DisplayType.login,
                                )));
                          },
                          backgroundColor: whiteColor,
                          borderColor: whiteColor,
                          child: AppTextHeavyBold(
                            text: "Freelancer",
                            fontSize: 14.5.sp,
                            color: Theme.of(context).primaryColor,
                            fontFamily: FontFamily.raleway,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
