import 'package:emerald_beauty/api_classes/auth/register.dart';
import 'package:emerald_beauty/api_classes/uploading/file_picker.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class DocumentsSessionRegisterProvider extends ChangeNotifier {
  final FilePickerService filePicker = FilePickerService();
  Register registerApi = Register();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Map<String, List<String>> uploadedDocuments = {};
  Map<String, List<String>> uploadedPortfolio = {};
  Map<String, List<String>> uploadCertificates = {};

  Future<void> addFile(Map<String, List<String>> fileMap, String serviceName) async {
    _isLoading = true;
    notifyListeners();
    final result = await filePicker.addFile();
    if (result.isNotEmpty) {
      fileMap.putIfAbsent(serviceName, () => []).add(result);
      _isLoading = false;
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  void removeFile(Map<String, List<String>> fileMap, String serviceName, int index) {
    if (fileMap.containsKey(serviceName) && fileMap[serviceName]!.isNotEmpty) {
      fileMap[serviceName]!.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> addDocument(String serviceName) => addFile(uploadedDocuments, serviceName);
  Future<void> addCertificate(String serviceName) => addFile(uploadCertificates, serviceName);
  Future<void> addPortfolio(String serviceName) => addFile(uploadedPortfolio, serviceName);

  void removeDocument(String serviceName, int index) => removeFile(uploadedDocuments, serviceName, index);
  void removeCertificate(String serviceName, int index) => removeFile(uploadCertificates, serviceName, index);
  void removePortfolio(String serviceName, int index) => removeFile(uploadedPortfolio, serviceName, index);

  Future<bool> createFreelancer(
      {required RequestFrom requestFrom,
      required String input,
      required String firstName,
      required String lastName,
      required String userName,
      required String password,
      required String address,
      required double lat,
      required double lng,
      required List<int> selectedCategoryIds,
      required List<String> selectedCategoryNames}) async {
    bool val;
    _isLoading = true;
    notifyListeners();

    String result = await registerApi.register(
        requestFrom: requestFrom,
        input: input,
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        password: password,
        address: address,
        lat: lat,
        lng: lng,
        selectedCategoryIds: selectedCategoryIds,
        selectedCategoryNames: selectedCategoryNames,
        uploadedDocuments: uploadedDocuments,
        uploadedPortfolio: uploadedPortfolio,
        uploadCertificates: uploadCertificates);
    showToast(result);

    if (result.contains("successfully")) {
      val = true;
    } else {
      val = false;
    }
    _isLoading = false;
    notifyListeners();
    return val;
  }
}
