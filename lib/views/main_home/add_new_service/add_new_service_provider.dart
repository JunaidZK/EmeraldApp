import 'package:emerald_beauty/api_classes/categories/categories.dart';
import 'package:emerald_beauty/api_classes/uploading/file_picker.dart';
import 'package:emerald_beauty/api_classes/user_service/user_service.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/getx_controller.dart';
import 'package:emerald_beauty/model_class/services/services.dart';
import 'package:flutter/material.dart';

class AddNewServiceProvider extends ChangeNotifier {
  Categories categoryApi = Categories();
  UserService createService = UserService();
  FilePickerService filePickerService = FilePickerService();
  final predefinePriceController = TextEditingController();
  final additonalPriceController = TextEditingController(text: '0');
  final englishDescription = TextEditingController();
  final arabicDescription = TextEditingController();
  List<Category> categories = [];
  List<ServiceResult> services = [];
  List<ServiceResult> filteredServices = [];
  Category? selectedCategory;
  ServiceResult? selectedService;
  List<String> serviceDocuments = [];
  List<String> portfolio = [];

  Future<void> getServices() async {
    final Services? result = await categoryApi.getAllServices();
    if (result != null) {
      // Remove duplicate categories by ensuring each category is unique based on its ID
      final uniqueCategories = <int, Category>{};

      for (var service in result.data) {
        uniqueCategories[service.category.id] = service.category;
      }

      categories = uniqueCategories.values.toList(); // Convert the map values back to a list
      services = result.data;
      filteredServices = []; // Initially, no category is selected
      notifyListeners();
    }
  }

  void selectCategory(Category category) {
    selectedCategory = category;
    // Filter services based on the selected category
    filteredServices = services.where((service) => service.categoryId == category.id).toList();

    // Reset the selected service if it is not in the new filtered list
    if (selectedService != null && !filteredServices.contains(selectedService)) {
      selectedService = null;
    }

    notifyListeners();
  }

  void selectService(ServiceResult service) {
    selectedService = service;
    englishDescription.text = service.description;
    arabicDescription.text = service.arabicDescription;
    predefinePriceController.text = service.price.toString();
    notifyListeners();
  }

  Future<void> addDocuments() async {
    String result = await filePickerService.addFile();
    serviceDocuments.add(result);
    notifyListeners();
  }

  void deleteDocument(int index) {
    if (index >= 0 && index < serviceDocuments.length) {
      serviceDocuments.removeAt(index);
      notifyListeners();
    }
  }

  bool isLoading = false;
  Future<void> addPortfolio() async {
    isLoading = true;
    notifyListeners();
    String result = await filePickerService.addFile();

    portfolio.add(result);
    isLoading = false;
    notifyListeners();
  }

  void deletePortfolio(int index) {
    if (index >= 0 && index < portfolio.length) {
      isLoading = true;
      notifyListeners();
      portfolio.removeAt(index);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createNewUserService() async {
    isLoading = true;
    notifyListeners();
    if (serviceDocuments.isEmpty) {
      AppWidgets().snackbar(text: 'Please add service doc');
      isLoading = false;
      notifyListeners();
      return false;
    }
    if (portfolio.isEmpty) {
      AppWidgets().snackbar(text: 'Please add portfolio');
      isLoading = false;
      notifyListeners();
      return false;
    }
    if (selectedService == null) {
      AppWidgets().snackbar(text: 'Please Select service');
      isLoading = false;
      notifyListeners();
      return false;
    }
    if (selectedService == null) {
      AppWidgets().snackbar(text: 'Please Select service');
      isLoading = false;
      notifyListeners();
      return false;
    }

    String result = await createService.createNewService(
      serviceId: selectedService!.id,
      price: int.parse(predefinePriceController.text) + int.parse(additonalPriceController.text),
      docs: serviceDocuments,
      portfolio: portfolio,
    );

    showToast(result);

    if (result.contains("Your have created a new service")) {
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
