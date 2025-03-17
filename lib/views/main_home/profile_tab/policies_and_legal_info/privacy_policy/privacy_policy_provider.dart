import 'package:emerald_beauty/api_classes/profile/legal_info/privacy_policy.dart';
import 'package:emerald_beauty/model_class/profile/policies_legal_info/privacy_policy.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyProvider extends ChangeNotifier {
  PrivacyPolicy? privacyPolicy;
  PrivacyPolicyApi privacyApi = PrivacyPolicyApi();

  bool _isLoading = true; // Initially loading

  bool get isLoading => _isLoading;

  PrivacyPolicyProvider() {
    fetchPrivacyPolicy();
  }

  void fetchPrivacyPolicy() async {
    try {
      // Fetch terms and conditions from the API
      privacyPolicy = await privacyApi.fetchPrivacyPolicy();

      if (privacyPolicy == null) {
        debugPrint("Failed to fetch terms and conditions");
      }
    } catch (e) {
      debugPrint("An error occurred: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
