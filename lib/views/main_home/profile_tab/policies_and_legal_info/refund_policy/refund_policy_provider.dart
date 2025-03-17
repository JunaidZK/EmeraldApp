import 'package:emerald_beauty/api_classes/profile/legal_info/refund_policy.dart';
import 'package:emerald_beauty/model_class/profile/policies_legal_info/refund_policy.dart';
import 'package:flutter/material.dart';

class RefundPolicyProvider extends ChangeNotifier {
  RefundPolicyApi refundApi = RefundPolicyApi();
  RefundPolicy? refundPolicy;

  bool _isLoading = true; // Initially loading

  bool get isLoading => _isLoading;

  RefundPolicyProvider() {
    fetchRefundPolicy();
  }

  void fetchRefundPolicy() async {
    try {
      // Fetch terms and conditions from the API
      refundPolicy = await refundApi.getRefundPolicy();

      if (refundPolicy == null) {
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
