import 'package:emerald_beauty/animated_navigation/animated_navigation.dart';
import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_circular_image.dart';
import 'package:emerald_beauty/components/app_gmaps/app_gmap_view.dart';
import 'package:emerald_beauty/components/app_mobile_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_swithcer.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/globals.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/profile_management/edit_profile/edit_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProfileView extends StatefulWidget {
  final Users user;
  const EditProfileView({required this.user, super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late EditProfileProvider editProvider;
  bool showLoader = false;
  @override
  void initState() {
    super.initState();
    editProvider = EditProfileProvider();
    editProvider.fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: appBar(context,
          appBarheight: 8.h,
          leftWidget: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Transform.flip(
                  flipX: localization!.locale.languageCode == "ar",
                  child:
                      const AppSvg(svgName: arrowBack, boxfit: BoxFit.none))),
          title: localization.translate("EDIT PROFILE")),
      body: ChangeNotifierProvider(
        create: (_) => editProvider,
        child: Consumer<EditProfileProvider>(
          builder: (context, value, child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.75.h),
                        GestureDetector(
                          onTap: showLoader
                              ? () {}
                              : () async {
                                  setState(() => showLoader = true);

                                  await value.fileUpload().then((a) {
                                    setState(() => showLoader = false);
                                  });
                                },
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Center(
                                child: AppCircularImage(
                                  networkImage: value.userImage,
                                  imgHeight: 10.h,
                                  alignment: Alignment.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12.5.w),
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: greenishBlack, width: 1.5)),
                                  child: const AppSvg(svgName: camera),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppSwithcer(
                              borderColor: greenishBlack,
                              swithcerValue: value.activeStatus,
                              valueChanged: (val) {
                                value.updateActiveStatus(val);
                              },
                            ),
                            SizedBox(width: 2.5.w),
                            AppTextThin(
                              text: value.activeStatus
                                  ? localization.translate("Active")
                                  : localization.translate("In-active"),
                              color: Theme.of(context).primaryColor,
                              fontFamily: FontFamily.raleway,
                              fontSize: 15.sp,
                            )
                          ],
                        ),
                        SizedBox(height: 2.h),
                        //MARK: - Name
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextSemiBold(
                                    text: localization.translate("First Name"),
                                    fontFamily: FontFamily.raleway,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15.sp,
                                  ),
                                  AppTextField(
                                    textController: value.firstNameController,
                                    enabledBorder: null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextSemiBold(
                                    text: localization.translate("Last Name"),
                                    fontFamily: FontFamily.raleway,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15.sp,
                                  ),
                                  AppTextField(
                                    textController: value.lastNameController,
                                    enabledBorder: null,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        //MARK: - Email Address
                        Visibility(
                          visible: widget.user == Users.employee ||
                              (widget.user == Users.freelancer &&
                                  globalProvider.globalRequestFrom ==
                                      RequestFrom.email),
                          child: AppTextSemiBold(
                            text: localization.translate("Email Address"),
                            fontFamily: FontFamily.raleway,
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.sp,
                          ),
                        ),
                        Visibility(
                          visible: widget.user == Users.employee ||
                              (widget.user == Users.freelancer &&
                                  globalProvider.globalRequestFrom ==
                                      RequestFrom.email),
                          child: AppTextField(
                            textController: value.emailAddressController,
                            enabledBorder: null,
                            isTextFieldEnabled: false,
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        //MARK: - Mobile Number
                        Visibility(
                          visible: widget.user == Users.employee ||
                              (widget.user == Users.freelancer &&
                                  globalProvider.globalRequestFrom ==
                                      RequestFrom.phone),
                          child: AppTextSemiBold(
                            text: localization.translate("Mobile Number"),
                            fontFamily: FontFamily.raleway,
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.sp,
                          ),
                        ),
                        Visibility(
                          visible: widget.user == Users.employee ||
                              (widget.user == Users.freelancer &&
                                  globalProvider.globalRequestFrom ==
                                      RequestFrom.phone),
                          child: AppMobileTextfield(
                            placeholder: "",
                            textController: value.mobileNumberController,

                            countryCode:
                                value.countryCode, // Updated country code here
                            isTextFieldEnabled: false,
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        //MARK: - Bio
                        AppTextSemiBold(
                          text: localization.translate("Bio"),
                          fontFamily: FontFamily.raleway,
                          color: Theme.of(context).primaryColor,
                          fontSize: 15.sp,
                        ),
                        AppTextField(
                          textController: value.bioController,
                          enabledBorder: null,
                          keyboardType: TextInputType.multiline,
                          submitLabel: TextInputAction.newline,
                          minLine: 1,
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextBold(
                              text: localization.translate("YOUR LOCATION"),
                              fontFamily: FontFamily.raleway,
                              fontSize: 17.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                            const AppSvg(svgName: dropDownIcon)
                          ],
                        ),
                        SizedBox(height: 1.h),

                        //MARK: - Country
                        AppTextSemiBold(
                          text: localization.translate("Address"),
                          fontFamily: FontFamily.raleway,
                          color: Theme.of(context).primaryColor,
                          fontSize: 15.sp,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              AnimatedNavigation.bottomSlide(
                                  const AppGMapsView()),
                            );
                            if (result != null && result['address'] != null) {
                              // If result is not null, extract the data and update the TextField
                              double latitude = result['latitude'];
                              double longitude = result['longitude'];
                              TextEditingController address = result['address'];

                              // Set the address to the locationController
                              value.address.text = address.text;

                              // You can also store the latitude and longitude for further use if needed
                              value.lat = latitude;
                              value.lng = longitude;
                            }
                          },
                          child: AppTextField(
                            textController: value.address,
                            enabledBorder: null,
                            isTextFieldEnabled: false,
                          ),
                        ),

                        SizedBox(height: 7.h),
                        //MARK: - SAVE
                        Center(
                          child: App3DButton(
                            tap: () async {
                              await value.updateProfile();
                              Navigator.pop(context);
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            borderColor: greenishBlack,
                            child: AppTextBold(
                              text: localization.translate("SAVE"),
                              color: whiteColor,
                              fontFamily: FontFamily.raleway,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
                showLoader
                    ? const Center(
                        child: CircularProgressIndicator(color: greenishBlack))
                    : const SizedBox.shrink()
              ],
            );
          },
        ),
      ),
    );
  }
}
