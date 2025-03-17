import 'package:emerald_beauty/api_classes/auth/me.dart';
import 'package:emerald_beauty/api_classes/profile/profile_management/edit_profile.dart';
import 'package:emerald_beauty/api_classes/uploading/file_picker.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/model_class/country_code.dart';
import 'package:emerald_beauty/model_class/user/user_info/user_info.dart';
import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  Me profileApi = Me();
  FilePickerService filePicker = FilePickerService();
  ProfileResponse? user;
  EditProfileApi editApi = EditProfileApi();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final bioController = TextEditingController();
  final address = TextEditingController();

  String? userImage;
  bool activeStatus = false;

  double? lat;
  double? lng;

  String countryCode = "";
  String phoneNumber = "";

  void detectCountryCode(String completeNumber) {
    Map<String, String> foundedCountry = {};
    for (var country in Countries.allCountries) {
      String dialCode = country["dial_code"].toString();
      if (completeNumber.startsWith(dialCode)) {
        foundedCountry = country;
        break; // Exit the loop once the matching country is found
      }
    }

    if (foundedCountry.isNotEmpty) {
      // Extract the dial code
      final extractedCode = foundedCountry["code"]!;
      final extractedDialCode = foundedCountry["dial_code"]!;

      // Extract the remaining phone number
      final remainingPhoneNumber = completeNumber.substring(extractedDialCode.length);

      // Update the country code and phone number fields
      countryCode = extractedCode; // Update the country field
      mobileNumberController.text = remainingPhoneNumber; // Update the mobile number controller

      // Notify listeners about the changes
      notifyListeners();
    } else {
      debugPrint('Country code not found for the provided phone number.');
    }
  }

  Future<void> fetchUserInfo() async {
    user = await profileApi.fetchUserProfile();
    firstNameController.text = user!.data!.profile!.firstName;
    lastNameController.text = user!.data!.profile!.lastName;
    address.text = user!.data!.profile!.address!;
    emailAddressController.text = user!.data!.profile!.email!;
    if (user!.data!.profile!.phone != null) {
      detectCountryCode(user!.data!.profile!.phone!);
    }
    bioController.text = user!.data!.profile!.bio!;
    userImage = user!.data!.profile!.userImage?.path;
    activeStatus = user!.data!.profile!.availabilityStatus == 10 ? false : true;
    lat = user!.data!.profile!.latitude;
    lng = user!.data!.profile!.longitude;
    notifyListeners();
  }

  void updateActiveStatus(bool status) {
    activeStatus = status;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    String result = await editApi.updateProfile(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        bio: bioController.text,
        activeStatus: activeStatus,
        address: address.text,
        image: userImage!,
        latitude: lat!,
        longitude: lng!);
    showToast(result);
    notifyListeners();
  }

  Future<void> fileUpload() async {
    userImage = await filePicker.addFile();

    notifyListeners();
  }
}
