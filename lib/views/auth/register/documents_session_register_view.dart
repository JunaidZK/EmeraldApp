// ignore_for_file: use_build_context_synchronously

import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_auth_bottom_text.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_dotted_upload.dart';
import 'package:emerald_beauty/components/app_silver_app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/auth/otp/otp_view.dart';
import 'package:emerald_beauty/views/auth/register/documents_session_register_provider.dart';
import 'package:emerald_beauty/views/auth/user_choice/user_choice_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DocumentsSessionRegisterView extends StatelessWidget {
  final RequestFrom requestFrom;
  final String input;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final String address;
  final double lat;
  final double lng;
  final String? imageUrl;
  final List<int> selectedCategoryIds;
  final List<String> selectedCategoryNames;

  const DocumentsSessionRegisterView({
    super.key,
    required this.requestFrom,
    required this.input,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.userName,
    required this.lat,
    required this.lng,
    this.imageUrl,
    required this.password,
    required this.selectedCategoryIds,
    required this.selectedCategoryNames,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DocumentsSessionRegisterProvider(),
      child: Consumer<DocumentsSessionRegisterProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Scaffold(
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
                                onTap: () => Navigator.pop(context),
                                child: const AppSvg(svgName: arrowBack),
                              ),
                              SizedBox(height: 0.5.h),
                              AppTextMedium(
                                text: "CREATE YOUR ACCOUNT",
                                color: primaryColor,
                                fontSize: 23.sp,
                              ),
                              SizedBox(height: 1.5.h),
                              AppTextRegular(
                                text: 'Sign up and start beauty services tailored just for you.',
                                fontSize: 16.5.sp,
                                color: grayColor,
                              ),
                              SizedBox(height: 2.h),
                              ...selectedCategoryNames.map((categoryName) {
                                return
                                    //  provider.isLoading
                                    //     ? const Loader()
                                    //     :
                                    Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildUploadSection(
                                      context,
                                      provider,
                                      categoryName,
                                      "Certificate",
                                      provider.uploadCertificates,
                                      provider.addCertificate,
                                      provider.removeCertificate,
                                    ),
                                    SizedBox(height: 2.h),
                                    _buildUploadSection(
                                      context,
                                      provider,
                                      categoryName,
                                      "Documents",
                                      provider.uploadedDocuments,
                                      provider.addDocument,
                                      provider.removeDocument,
                                    ),
                                    SizedBox(height: 2.h),
                                    _buildUploadSection(
                                      context,
                                      provider,
                                      categoryName,
                                      "Portfolio",
                                      provider.uploadedPortfolio,
                                      provider.addPortfolio,
                                      provider.removePortfolio,
                                    ),
                                    SizedBox(height: 5.h),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: _buildBottomSection(context, provider),
              ),
              Visibility(visible: provider.isLoading, child: const Loader())
            ],
          );
        },
      ),
    );
  }

  Widget _buildUploadSection(BuildContext context, DocumentsSessionRegisterProvider provider, String category, String docType, Map<String, List<String>> uploadMap,
      Function(String) addFile, Function(String, int) removeFile) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppTextRegular(text: "Upload $docType for $category", fontSize: 14.5.sp, color: Theme.of(context).primaryColor),
      SizedBox(height: 0.75.h),
      GestureDetector(onTap: () => addFile(category), child: AppDottedUpload(innerPadding: EdgeInsets.only(left: 2.w, top: 0.5.h, bottom: 0.5.h), text: "Upload $docType")),
      ...uploadMap[category]?.map((file) =>
              ListTile(title: Text(file), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => removeFile(category, uploadMap[category]!.indexOf(file))))) ??
          []
    ]);
  }

  Widget _buildBottomSection(BuildContext context, DocumentsSessionRegisterProvider provider) {
    return Padding(
        padding: EdgeInsets.only(bottom: 0.25.h, top: 1.5.h),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          App3DButton(
              tap: () async {
                final bool response = await provider.createFreelancer(
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
                    selectedCategoryNames: selectedCategoryNames);

                if (response) {
                  Navigator.push(
                      context, AnimatedNavigation.bottomSlide(OtpView(requestFrom: requestFrom, input: input, displayType: DisplayType.register, user: Users.freelancer)));
                }
              },
              backgroundColor: Theme.of(context).primaryColor,
              borderColor: greenishBlack,
              child: AppTextSemiBold(text: "Register", fontSize: 15.sp, color: whiteColor)),
          SizedBox(height: 0.1.h),
          AppAuthBottomText(
              lightText: "Already have an account?",
              boldText: "Login",
              lightTextColor: greenishBlack,
              btnTextColor: lightTurquoise,
              boldTextPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserChoiceView(display: DisplayType.login)));
              })
        ]));
  }
}
