import 'package:emerald_beauty/api_classes/profile/legal_info/terms_n_conditions.dart';
import 'package:emerald_beauty/model_class/profile/policies_legal_info/terms_conditions.dart';
import 'package:flutter/material.dart';

class TermsConditionsProvider extends ChangeNotifier {
  TermsAndConditions? termsNconditions; // Make it nullable

  TermsNConditions termsApi = TermsNConditions();

  bool _isLoading = true; // Initially loading

  bool get isLoading => _isLoading;

  TermsConditionsProvider() {
    fetchTermConditions();
  }

  void fetchTermConditions() async {
    try {
      // Fetch terms and conditions from the API
      termsNconditions = await termsApi.fetchTermConditions();

      if (termsNconditions == null) {
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
