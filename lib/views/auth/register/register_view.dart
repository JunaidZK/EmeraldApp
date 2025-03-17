import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_auth_bottom_text.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_gmaps/app_gmap_view.dart';
import 'package:emerald_beauty/components/app_mobile_field.dart';
import 'package:emerald_beauty/components/app_multi_select_dropdown.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/components/app_upload_image.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/auth/register/documents_session_register_view.dart';
import 'package:emerald_beauty/views/auth/register/register_provider.dart';
import 'package:emerald_beauty/views/auth/user_choice/user_choice_view.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterView extends StatelessWidget {
  final RequestFrom requestFrom;
  const RegisterView({required this.requestFrom, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Consumer<RegisterProvider>(builder: (context, provider, child) {
        return Form(
          key: provider.registerKey,
          child: Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: <Widget>[
                  const AppSilverBar(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.25.h),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const AppSvg(svgName: arrowBack),
                          ),
                          SizedBox(height: 0.5.h),
                          AppTextMedium(
                            text: "CREATE YOUR\nACCOUNT",
                            color: primaryColor,
                            fontSize: 23.sp,
                          ),
                          SizedBox(height: 2.h),
                          AppTextRegular(
                            text:
                                'Sign up and start booking beauty services\ntailored just for you.',
                            fontSize: 16.5.sp,
                            color: grayColor,
                          ),
                          SizedBox(height: 1.25.h),
                          GestureDetector(
                            onTap: () async {
                              await provider.fileUpload();
                            },
                            child: AppUploadImage(
                              imageLink: provider.imageUrl,
                            ),
                          ),
                          SizedBox(height: 0.25.h),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                    textController:
                                        provider.firstNameController,
                                    placeholder: "First Name",
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "First Name is required";
                                      }
                                      return null;
                                    },
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColor))),
                              ),
                              SizedBox(width: 2.5.w),
                              Expanded(
                                child: AppTextField(
                                    textController: provider.lastNameController,
                                    placeholder: "Last Name",
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Last Name is required";
                                      }
                                      return null;
                                    },
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColor))),
                              )
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          AppTextField(
                              textController: provider.userNameController,
                              placeholder: "Username",
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Username is required";
                                }
                                return null;
                              },
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                          SizedBox(height: 0.5.h),
                          Visibility(
                            visible: requestFrom == RequestFrom.email,
                            child: AppTextField(
                                textController: provider.inputController,
                                placeholder: "Email Address",
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Email Address is required";
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                      .hasMatch(value)) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor))),
                          ),
                          Visibility(
                              visible: requestFrom == RequestFrom.phone,
                              child: AppMobileTextfield(
                                textController: provider.inputController,
                                placeholder: "Mobile Number",
                                onChanged: (PhoneNumber phoneNumber) {
                                  String fullPhoneNumber =
                                      phoneNumber.completeNumber;

                                  provider.setPhoneNumber(fullPhoneNumber);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Mobile Number is required";
                                  }

                                  // Validate the mobile number (check for digits and length)
                                  if (!RegExp(r"^\+?[1-9]\d{1,14}$")
                                      .hasMatch(value)) {
                                    return "Enter a valid mobile number"; // International format validation
                                  }

                                  return null;
                                },
                              )),
                          SizedBox(height: 0.5.h),
                          AppTextField(
                            textController: provider.passwordController,
                            placeholder: "Password",
                            obscureText: provider.passwordVisibility,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                provider.passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColor,
                                size: 17.5.sp,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Password is required";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters long";
                              }
                              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return "Password must contain at least one uppercase letter";
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return "Password must contain at least one numeric value";
                              }
                              if (!RegExp(r'[\W_]').hasMatch(value)) {
                                return "Password must contain at least one special character";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 0.5.h),
                          GestureDetector(
                            onTap: () async {
                              // Navigate to AppGMapsView and wait for the result
                              var result = await Navigator.push(
                                context,
                                AnimatedNavigation.bottomSlide(
                                    const AppGMapsView()),
                              );
                              if (result != null && result['address'] != null) {
                                // If result is not null, extract the data and update the TextField
                                double latitude = result['latitude'];
                                double longitude = result['longitude'];
                                TextEditingController address =
                                    result['address'];

                                // Set the address to the locationController
                                provider.locationController.text = address.text;

                                // You can also store the latitude and longitude for further use if needed
                                provider.latitude = latitude;
                                provider.longitude = longitude;
                              }
                            },
                            child: AppTextField(
                                textController: provider.locationController,
                                isTextFieldEnabled: false,
                                placeholder: "Location Auto Select",
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Location is required";
                                  }
                                  return null;
                                },
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor))),
                          ),
                          SizedBox(height: 0.5.h),
                          AppMultiSelectDropdown<int>(
                            dropDownItems: provider.dropDownItems,
                            cntrller: provider.areaofExpertiseController,
                            validator: (selectedItems) {
                              if (selectedItems == null ||
                                  selectedItems.isEmpty) {
                                return "Please select at least one item.";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                  bottom: 0.25.h, top: 1.5.h), // Adjust padding as needed
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  App3DButton(
                    tap: () {
                      if (provider.registerKey.currentState?.validate() ??
                          false) {
                        Navigator.push(
                          context,
                          AnimatedNavigation.bottomSlide(
                            DocumentsSessionRegisterView(
                              requestFrom: requestFrom,
                              firstName: provider.firstNameController.text,
                              lastName: provider.lastNameController.text,
                              userName: provider.userNameController.text,
                              password: provider.passwordController.text,
                              address: provider.locationController.text,
                              lat: provider.latitude!,
                              lng: provider.longitude!,
                              imageUrl: provider.imageUrl,
                              input: provider.inputController.text,
                              selectedCategoryIds:
                                  provider.selectedCategoryIds, // Pass IDs
                              selectedCategoryNames: provider
                                  .areaofExpertiseController.selectedItems
                                  .map((item) => item.label)
                                  .toList(),
                            ),
                          ),
                        );
                      }
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    borderColor: greenishBlack,
                    child: AppTextSemiBold(
                      text: "NEXT",
                      fontSize: 15.sp,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  AppAuthBottomText(
                    lightText: "Already have an account?",
                    boldText: "Login",
                    lightTextColor: greenishBlack,
                    btnTextColor: lightTurquoise,
                    boldTextPressed: () {
                      Navigator.pushReplacement(
                          context,
                          AnimatedNavigation.bottomSlide(const UserChoiceView(
                              display: DisplayType.login)));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
