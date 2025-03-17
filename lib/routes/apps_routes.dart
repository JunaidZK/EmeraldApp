import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/views/auth/forgot_password/forgot_password_view.dart';
import 'package:emerald_beauty/views/auth/login/login_view.dart';
import 'package:emerald_beauty/views/auth/otp/otp_view.dart';
import 'package:emerald_beauty/views/auth/register/register_view.dart';
import 'package:emerald_beauty/views/auth/reset_password/reset_password_view.dart';
import 'package:emerald_beauty/views/auth/splash/splash_view.dart';
import 'package:emerald_beauty/views/auth/user_choice/user_choice_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/analytics/analytics_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/availability/availbility_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/customer_support_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/expertise/expertise_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/localization/language_support/language_support_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/policies_and_legal_info/privacy_policy/privacy_policy_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/policies_and_legal_info/refund_policy/refund_policy_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/policies_and_legal_info/terms_and_conditions/terms_conditions_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/change_password/change_password_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/earnings_dashboard/earnings_dashboard_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/edit_profile/edit_profile_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/leave_management/leave_management_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/payment_info/payment_info_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/view_profile/view_profile_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/ratings_and_reviews/received_ratings/received_ratings_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/service_management/my_services/my_services_view.dart';
import 'package:flutter/material.dart';

class AppsRoutes {
  //MARK: - Auth Screens
  static const String login = "/login";
  static const String userChoice = "/userChoice";
  static const String forgetPassword = "/forgetPassword";
  static const String otp = "/otp";
  static const String resetPassword = "/resetPassword";
  static const String splash = "/splash";
  static const String signUp = "/signUp";

  //MARK: - Profile Tab Screens

  //MARK: - PROFILE MANAGEMENT
  static const String viewProfile = '/viewProfile';
  static const String editProfile = '/editProfile';
  static const String changePassword = '/changePassword';
  static const String earningsDashboard = '/earningDashboard';
  static const String leaveManagement = '/leaveManagement';
  static const String paymentInfo = '/paymentInfo';
  static const String availability = '/availability';
  static const String analytics = '/analytics';
  static const String expertise = '/expertise';

  //MARK: - SERVICE MANAGEMENT
  static const String myServices = '/myServices';

  //MARK: - RATINGS & REVIEWS
  static const String receivedRatings = '/receivedRatings';

  //MARK: - COMMUNICATION
  static const String customerSupport = "/customerSupport";

  //MARK: - LOCALIZATION
  static const String langaugeSupport = '/languageSupport';

  //MARK: - POLICIES & LEGAL INFORMATION
  static const String termsConditions = '/termsConditions';
  static const String refundPolicy = '/refundPolicy';
  static const String privacyPolicy = '/privacyPolicy';

  //MARK: - ROUTES
  static Map<String, WidgetBuilder> routes = {
    //AUTH
    login: (context) => LoginView(
        requesFrom: ModalRoute.of(context)!.settings.arguments as RequestFrom,
        user: ModalRoute.of(context)!.settings.arguments as Users),
    splash: (context) => const SplashView(),
    userChoice: (context) => UserChoiceView(
        display: ModalRoute.of(context)!.settings.arguments as DisplayType,
        user: ModalRoute.of(context)!.settings.arguments as Users),
    otp: (context) => OtpView(
          requestFrom:
              ModalRoute.of(context)!.settings.arguments as RequestFrom,
          input: ModalRoute.of(context)!.settings.arguments as String,
          user: ModalRoute.of(context)!.settings.arguments as Users,
          displayType:
              ModalRoute.of(context)!.settings.arguments as DisplayType,
        ),
    forgetPassword: (context) => ForgotPasswordView(
          requesFrom: ModalRoute.of(context)!.settings.arguments as RequestFrom,
          displayType:
              ModalRoute.of(context)!.settings.arguments as DisplayType,
          user: ModalRoute.of(context)!.settings.arguments as Users,
        ),
    resetPassword: (context) => ResetPasswordView(
          requestFrom:
              ModalRoute.of(context)!.settings.arguments as RequestFrom,
          input: ModalRoute.of(context)!.settings.arguments as String,
          otp: ModalRoute.of(context)!.settings.arguments as String,
          user: ModalRoute.of(context)!.settings.arguments as Users,
        ),
    signUp: (context) => RegisterView(
        requestFrom: ModalRoute.of(context)!.settings.arguments as RequestFrom),

    //PROFILE SCREENS
    viewProfile: (context) => const ViewProfileView(),
    editProfile: (context) => EditProfileView(
        user: ModalRoute.of(context)!.settings.arguments as Users),
    changePassword: (context) => const ChangePasswordView(),
    earningsDashboard: (context) => EarningsDashboardView(
        user: ModalRoute.of(context)!.settings.arguments as Users),
    leaveManagement: (context) => const LeaveManagementView(),
    paymentInfo: (context) => const PaymentInfoView(),
    availability: (context) => const AvailbilityView(),
    analytics: (context) => const AnalyticsView(),
    expertise: (context) => const ExpertiseView(),
    myServices: (context) => MyServicesView(
        user: ModalRoute.of(context)!.settings.arguments as Users),
    receivedRatings: (context) => const ReceivedRatingsView(),
    customerSupport: (context) => const CustomerSupportView(),
    langaugeSupport: (context) => const LanguageSupportView(),
    termsConditions: (context) => const TermsConditionsViews(),
    refundPolicy: (context) => const RefundPolicyView(),
    privacyPolicy: (context) => const PrivacyPolicyView()
  };
}
