import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/routes/apps_routes.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/customer_support_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/localization/language_support/language_support_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/policies_and_legal_info/privacy_policy/privacy_policy_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/policies_and_legal_info/refund_policy/refund_policy_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/policies_and_legal_info/terms_and_conditions/terms_conditions_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/change_password/change_password_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/earnings_dashboard/earnings_dashboard_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/edit_profile/edit_profile_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/expertise/expertise_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/leave_management/leave_management_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/payment_info/payment_info_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/view_profile/view_profile_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/ratings_and_reviews/received_ratings/received_ratings_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/service_management/my_services/my_services_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  final Users userType;

  bool _switcher = true;

  bool get switcher => _switcher;

  void toggleSwitcher() {
    _switcher = !_switcher;
    notifyListeners();
  }

  List<Map<String, List<Map<String, String>>>> buttons = [];

  ProfileProvider(this.userType) {
    buttons = [
      {
        "PROFILE MANAGEMENT": [
          {"name": "View Profile", "icon": user, "route": AppsRoutes.viewProfile},
          {"name": "Edit Profile", "icon": user, "route": AppsRoutes.editProfile},
          {"name": "Change Password", "icon": lock, "route": AppsRoutes.changePassword},
          {"name": "Earnings Dashboard", "icon": barChart, "route": AppsRoutes.earningsDashboard},
          if (userType == Users.freelancer) {"name": "Expertise", "icon": expertise, "route": AppsRoutes.expertise},
          if (userType == Users.employee) {"name": "Leave Management", "icon": leave, "route": AppsRoutes.leaveManagement},
          {"name": "Payment Information", "icon": payment, "route": AppsRoutes.paymentInfo},
        ],
        "SERVICE MANAGEMENT": [
          {"name": "My Services", "icon": service, "route": AppsRoutes.myServices},
        ],
        "RATINGS & REVIEWS": [
          {"name": "Recieved Ratings", "icon": rating, "route": AppsRoutes.receivedRatings},
        ],
        "COMMUNICATION": [
          {"name": "Customer Support", "icon": support, "route": AppsRoutes.customerSupport}
        ],
        "LOCALIZATION": [
          {"name": "Language Support", "icon": language, "route": AppsRoutes.langaugeSupport},
        ],
        "POLICIES & LEGAL INFORMATION": [
          {"name": "Terms and Conditions", "icon": terms, "route": AppsRoutes.termsConditions},
          {"name": "Refund Policy", "icon": terms, "route": AppsRoutes.refundPolicy},
          {"name": "Privacy Policy", "icon": terms, "route": AppsRoutes.privacyPolicy},
        ],
        "LOGOUT": [
          {"name": "Logout", "icon": logout, "route": "Route"},
        ]
      }
    ];
  }

  void navigateToScreen(BuildContext context, String name, MainHomeProvider provider, Users user) {
    switch (name) {
      case "View Profile":
        Navigator.push(context, AnimatedNavigation.bottomSlide(ChangeNotifierProvider.value(value: provider, child: const ViewProfileView())));
        break;
      case "Edit Profile":
        Navigator.push(context, AnimatedNavigation.bottomSlide(ChangeNotifierProvider.value(value: provider, child: EditProfileView(user: user))))
            .then((val) => provider.fetchUserProfile());
        break;
      case "Change Password":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const ChangePasswordView()));
        break;
      case "Earnings Dashboard":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const EarningsDashboardView()));
        break;

      case "Expertise":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const ExpertiseView()));
        break;
      case "Leave Management":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const LeaveManagementView()));
        break;
      case "Payment Information":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const PaymentInfoView()));
        break;
      case "My Services":
        Navigator.push(context, AnimatedNavigation.bottomSlide(MyServicesView(user: user)));
        break;
      case "Recieved Ratings":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const ReceivedRatingsView()));
        break;
      case "Customer Support":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const CustomerSupportView()));
        break;
      case "Language Support":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const LanguageSupportView()));
        break;
      case "Terms and Conditions":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const TermsConditionsViews()));
        break;
      case "Refund Policy":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const RefundPolicyView()));
        break;
      case "Privacy Policy":
        Navigator.push(context, AnimatedNavigation.bottomSlide(const PrivacyPolicyView()));
        break;
    }
  }
}
