import 'package:emerald_beauty/api_classes/uploading/file_picker.dart';
import 'package:emerald_beauty/app_init/app_init.dart';
import 'package:emerald_beauty/constant_values/location.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class RegisterProvider with ChangeNotifier {
  List<DropdownItem<int>> dropDownItems = [];
  String? imageUrl;

  FilePickerService filePicker = FilePickerService();

  RegisterProvider() {
    fetchCategories();
  }

  void fetchCategories() async {
    // Populate the dropDownItems list
    if (AppInit.categories.isNotEmpty) {
      dropDownItems = AppInit.categories
          .map((category) => DropdownItem<int>(
                value: category.categoryId,
                label: category.categoryName,
              ))
          .toList();
    }
    notifyListeners();
  }

  Future<void> fileUpload() async {
    imageUrl = await filePicker.addFile();
    notifyListeners();
  }

  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  // Define TextEditingController
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController inputController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final locationController = TextEditingController(text: address);

  final MultiSelectController<int> areaofExpertiseController =
      MultiSelectController();

  List<int> get selectedCategoryIds => areaofExpertiseController.selectedItems
      .map((item) => item.value)
      .toList();

  double? latitude = lat;
  double? longitude = lng;

  bool _passwordVisibility = false;
  String _phoneNumberWithCountryCode = '';

  bool get passwordVisibility => _passwordVisibility;

  String get phoneNumberWithCountryCode => _phoneNumberWithCountryCode;

  set passwordVisibility(bool val) {
    _passwordVisibility = val;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumberWithCountryCode = phoneNumber;
    notifyListeners();
  }

  // Dispose of the controller when done
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    inputController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
