import 'package:emerald_beauty/api_classes/profile/profile_management/payment_info.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/model_class/profile/profile_management/bank_account.dart';
import 'package:flutter/material.dart';

class PaymentInfoProvider extends ChangeNotifier {
  PaymentInfoApi paymentInfoApi = PaymentInfoApi();
  final accountHolderName = TextEditingController();
  final bankName = TextEditingController();
  final accountNo = TextEditingController();
  final ibaNo = TextEditingController();

  BankAccount? bankAccountDetails;

  Future<void> getPaymentInfo() async {
    bankAccountDetails = await paymentInfoApi.fetchPaymentInfo();
    if (bankAccountDetails != null) {
      accountHolderName.text = bankAccountDetails!.name;
      bankName.text = bankAccountDetails!.bankName;
      accountNo.text = bankAccountDetails!.accountNumber;
      ibaNo.text = bankAccountDetails!.iban;
    }
    notifyListeners();
  }

  bool validateForm() {
    if (accountHolderName.text.isEmpty ||
        bankName.text.isEmpty ||
        accountNo.text.isEmpty ||
        ibaNo.text.isEmpty) {
      showToast("All fields are required");
      return false;
    }
    return true;
  }

  Future<void> updatePaymentInfo() async {
    if (!validateForm()) return;
    try {
      final response = await paymentInfoApi.bankInfo(
          updateRequest: true,
          accountHolderName: accountHolderName.text,
          bankName: bankName.text,
          accountNo: accountNo.text,
          iban: ibaNo.text,
          id: bankAccountDetails!.id);
      showToast(response);
    } catch (e) {
      showToast("Failed to update payment info");
    }
  }

  Future<void> addNewPaymentInfo() async {
    if (!validateForm()) return;
    try {
      final response = await paymentInfoApi.bankInfo(
          updateRequest: false,
          accountHolderName: accountHolderName.text,
          bankName: bankName.text,
          accountNo: accountNo.text,
          iban: ibaNo.text);

      showToast(response);
    } catch (e) {
      showToast("Failed to add payment info");
    }
  }
}
