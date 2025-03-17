import 'package:emerald_beauty/api_classes/profile/customer_support/contact_info.dart';
import 'package:emerald_beauty/api_classes/profile/customer_support/faqs.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/model_class/profile/customer_support/contact_info.dart';
import 'package:emerald_beauty/model_class/profile/customer_support/faqs.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomerSupportProvider extends ChangeNotifier {
  AppLocalizations? localizations;
  FaqsApi faqApi = FaqsApi();
  ContactInfoApi contactApi = ContactInfoApi();

  BuildContext context;
  late TabController tabController;
  int currentPage = 0;
  List<Widget> tabs = [];
  ContactInfoResponse? contactInfo;
  FaqResponse? faqs;
  bool _isLoading = true; // Initially loading

  bool get isLoading => _isLoading;

  CustomerSupportProvider(TickerProvider tickerProvider, this.context) {
    localizations = AppLocalizations.of(context);
    tabController = TabController(
      length: 2,
      vsync: tickerProvider,
    )..addListener(() {
        if (tabController.index != currentPage) {
          currentPage = tabController.index;
          notifyListeners();
        }
      });

    tabs = [
      Tab(
        child: AppTextBold(
          text: localizations!.translate("FAQ's"),
          fontFamily: FontFamily.raleway,
          fontSize: 16.sp,
        ),
      ),
      Tab(
        child: AppTextBold(
          text: localizations!.translate("Contact Us"),
          fontFamily: FontFamily.raleway,
          fontSize: 16.sp,
        ),
      ),
    ];
    initialization();
  }

  Future<void> initialization() async {
    try {
      final futures = await Future.wait([
        faqApi.fetchFaqs(),
        contactApi.fetchFaqs(),
      ]);
      faqs = futures[0] as FaqResponse;
      contactInfo = futures[1] as ContactInfoResponse;

      if (contactInfo == null) {
        debugPrint("Contact Info is Empty");
      } else if (faqs == null) {
        debugPrint("FAQs are empty");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
