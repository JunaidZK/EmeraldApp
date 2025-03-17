import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/components/app_toast.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/change_password/change_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordProvider(),
      child: Consumer<ChangePasswordProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Scaffold(
                appBar: appBar(context,
                    appBarheight: 8.h,
                    leftWidget: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Transform.flip(
                          flipX: localization!.locale.languageCode == "ar",
                          child: const AppSvg(
                              svgName: arrowBack, boxfit: BoxFit.none),
                        )),
                    title: localization.translate("CHANGE PASSWORD")),
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    child: Form(
                      key: value.changePasswordKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextBold(
                              text: localization.translate("Current Password"),
                              fontFamily: FontFamily.hermann,
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.sp),
                          AppTextField(
                              textController: value.currentPassword,
                              obscureText: value.currentPasswordVisible,
                              textAlign:
                                  localization.locale.languageCode == "ar"
                                      ? TextAlign.right
                                      : TextAlign.left,
                              placeholder: localization
                                  .translate("Enter current password"),
                              validator: (currentPassword) {
                                if (currentPassword == null ||
                                    currentPassword.isEmpty) {
                                  return "Current password is required.";
                                }
                                return null;
                              },
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: grayColor)),
                              suffixIcon: GestureDetector(
                                  onTap: () =>
                                      value.toggleCurrentPasswordVisibility(),
                                  child: Icon(value.currentPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                          SizedBox(height: 1.h),
                          AppTextBold(
                              text: localization.translate("New Password"),
                              fontFamily: FontFamily.hermann,
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.sp),
                          AppTextField(
                              textController: value.newPassword,
                              obscureText: value.newPasswordVisible,
                              textAlign:
                                  localization.locale.languageCode == "ar"
                                      ? TextAlign.right
                                      : TextAlign.left,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: grayColor)),
                              validator: (newPassword) {
                                if (newPassword == null ||
                                    newPassword.isEmpty) {
                                  return "New password is required.";
                                } else if (newPassword.length < 8) {
                                  return "Password must be at least 8 characters long.";
                                }
                                return null;
                              },
                              placeholder:
                                  localization.translate("Enter new password"),
                              suffixIcon: GestureDetector(
                                  onTap: () =>
                                      value.toggleNewPasswordVisibility(),
                                  child: Icon(value.newPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                          SizedBox(height: 1.h),
                          AppTextBold(
                              text: localization
                                  .translate("Confirm New Password"),
                              fontFamily: FontFamily.hermann,
                              color: Theme.of(context).primaryColor,
                              fontSize: 15.sp),
                          AppTextField(
                            textController: value.confirmNewPassword,
                            textAlign: localization.locale.languageCode == "ar"
                                ? TextAlign.right
                                : TextAlign.left,
                            obscureText: value.confirmNewPasswordVisible,
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: grayColor)),
                            placeholder: localization
                                .translate("Enter confirm new password"),
                            validator: (confirmPassword) {
                              if (confirmPassword == null ||
                                  confirmPassword.isEmpty) {
                                return "Confirmation password is required.";
                              } else if (confirmPassword !=
                                  value.newPassword.text) {
                                return "Passwords do not match.";
                              }
                              return null;
                            },
                            suffixIcon: GestureDetector(
                              onTap: () =>
                                  value.toggleConfirmNewPasswordVisibility(),
                              child: Icon(
                                value.confirmNewPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 4.h,
                      ),
                      child: App3DButton(
                        tap: () async {
                          if (value.changePasswordKey.currentState!
                              .validate()) {
                            if (value.newPassword.text ==
                                value.confirmNewPassword.text) {
                              String? result = await value.passwordChange();

                              if (result == null) {
                                showToast("Your password has been changed.");
                                Navigator.pop(context);
                              } else {
                                showToast(result);
                              }
                            } else {
                              showToast(
                                  "New password and Confirm New password does not match");
                            }
                          }
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: greenishBlack,
                        child: AppTextBold(
                          text: localization.translate("SAVE"),
                          color: whiteColor,
                          fontFamily: FontFamily.hermann,
                          fontSize: 19.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(visible: value.isLoading, child: const Loader())
            ],
          );
        },
      ),
    );
  }
}
