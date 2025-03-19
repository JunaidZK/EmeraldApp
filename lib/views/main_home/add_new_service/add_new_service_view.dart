import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_button.dart';
import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/app_dotted_upload.dart';
import 'package:emerald_beauty/components/app_drop_down_field.dart';
import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/model_class/services/services.dart';
import 'package:emerald_beauty/views/main_home/add_new_service/add_new_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddNewServiceView extends StatefulWidget {
  final String title;
  const AddNewServiceView({this.title = "CREATE NEW SERVICE", super.key});

  @override
  State<AddNewServiceView> createState() => _AddNewServiceViewState();
}

class _AddNewServiceViewState extends State<AddNewServiceView> {
  late AddNewServiceProvider newProvider;

  @override
  void initState() {
    super.initState();
    newProvider = AddNewServiceProvider();
    newProvider.getServices();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
        appBar: appBar(context,
            title: localization!.translate(widget.title),
            appBarheight: 8.h,
            leftWidget: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Transform.flip(flipX: localization.locale.languageCode == "ar", child: const AppSvg(svgName: arrowBack, boxfit: BoxFit.none)))),
        body: ChangeNotifierProvider(
            create: (_) => newProvider,
            child: Consumer<AddNewServiceProvider>(builder: (context, value, child) {
              return Stack(children: [
                SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          AppTextSemiBold(
                              text: localization.translate("Area of Expertise"), fontFamily: FontFamily.hermann, color: Theme.of(context).primaryColor, fontSize: 16.sp),
                          AppDropDownTextfield<Category>(
                              placeholder: localization.translate("Select Area of Expertise"),
                              placeholderColor: Theme.of(context).primaryColor,
                              fontFamily: FontFamily.raleway,
                              fontSize: 14.5.sp,
                              outlineBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                              items: value.categories.map((category) {
                                return DropdownMenuItem<Category>(value: category, child: Text(category.name));
                              }).toList(),
                              onChanged: (Category? val) {
                                if (val != null) {
                                  value.portfolio.clear();
                                  value.serviceDocuments.clear();
                                  value.selectCategory(val);
                                }
                              },
                              suffixIcon:
                                  Transform.rotate(angle: 270 * (22 / 7) / 180, child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).primaryColor, size: 17.5.sp))),
                          SizedBox(height: 1.5.h),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            AppTextSemiBold(text: localization.translate("Service"), fontFamily: FontFamily.hermann, color: Theme.of(context).primaryColor, fontSize: 16.sp),
                            SizedBox(height: 0.5.h),
                            AppDropDownTextfield<ServiceResult>(
                                placeholder: localization.translate("Select Service"),
                                placeholderColor: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: 14.5.sp,
                                outlineBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                                value: value.selectedService, // Ensure the value is correctly assigned
                                items: value.filteredServices.map((service) {
                                  return DropdownMenuItem<ServiceResult>(value: service, child: Text(service.name));
                                }).toList(),
                                onChanged: (ServiceResult? val) {
                                  if (val != null) {
                                    value.portfolio.clear();
                                    value.serviceDocuments.clear();
                                    value.selectService(val);
                                  }
                                },
                                suffixIcon:
                                    Transform.rotate(angle: 270 * (22 / 7) / 180, child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).primaryColor, size: 17.5.sp)))
                          ]),
                          SizedBox(height: 2.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextSemiBold(text: "Description (English)", fontFamily: FontFamily.hermann, color: Theme.of(context).primaryColor, fontSize: 16.sp),
                          ),
                          SizedBox(height: 0.25.h),
                          AppTextField(
                              textController: value.englishDescription,
                              placeholder: "Description (English)",
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                              submitLabel: TextInputAction.newline),
                          SizedBox(height: 1.25.h),
                          Align(
                              alignment: Alignment.centerRight,
                              child: AppTextSemiBold(text: "الوصف (عربي)", fontFamily: FontFamily.hermann, color: Theme.of(context).primaryColor, fontSize: 16.sp)),
                          SizedBox(height: 0.25.h),
                          AppTextField(
                              textController: value.arabicDescription,
                              textAlign: TextAlign.right,
                              placeholder: "الوصف (عربي)",
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                              submitLabel: TextInputAction.newline),
                          SizedBox(height: 2.5.h),
                          Row(children: [
                            Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              AppTextSemiBold(text: localization.translate("Pre-define Price"), fontSize: 16.sp, color: Theme.of(context).primaryColor),
                              AppTextField(
                                  textController: value.predefinePriceController,
                                  prefixText: "AED\t\t",
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: whiteBorderColor, width: 1.0)),
                                  outlineBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: whiteBorderColor, width: 1.0)),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: whiteBorderColor, width: 1.0)))
                            ])),
                            SizedBox(width: 5.w),
                            Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              AppTextSemiBold(text: localization.translate("Additional Price"), fontSize: 16.sp, color: Theme.of(context).primaryColor),
                              AppTextField(
                                  textController: value.additonalPriceController,
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: whiteBorderColor, width: 1.0)),
                                  outlineBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: whiteBorderColor, width: 1.0)),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: whiteBorderColor, width: 1.0)))
                            ]))
                          ]),
                          SizedBox(height: 1.h),
                          AppTextSemiBold(text: localization.translate("Service Document"), fontSize: 16.sp, color: Theme.of(context).primaryColor),
                          SizedBox(height: 1.5.h),
                          GestureDetector(
                              onTap: () async => await value.addDocuments(),
                              child: AppDottedUpload(text: localization.translate("Upload Document"), innerPadding: EdgeInsets.only(left: 2.w, top: 0.5.h, bottom: 0.5.h))),
                          SizedBox(height: 1.h),
                          Column(
                              children: value.serviceDocuments.asMap().entries.map((entry) {
                            int index = entry.key;
                            String docs = entry.value;

                            return ListTile(
                                leading: Icon(Icons.insert_drive_file, color: Theme.of(context).primaryColor),
                                title: Text(docs),
                                trailing: IconButton(icon: const Icon(Icons.delete, color: redColor), onPressed: () => value.deleteDocument(index)));
                          }).toList()),
                          SizedBox(height: 1.h),
                          AppTextSemiBold(text: localization.translate("Attached Photos/Videos"), fontSize: 16.sp, color: Theme.of(context).primaryColor),
                          SizedBox(height: 1.5.h),
                          Wrap(crossAxisAlignment: WrapCrossAlignment.start, alignment: WrapAlignment.start, runSpacing: 20, spacing: 10, children: [
                            if (value.portfolio.isNotEmpty) ...[
                              for (int index = 0; index < value.portfolio.length; index++)
                                Stack(alignment: Alignment.topRight, children: [
                                  AppNetworkImage(image: value.portfolio[index], width: 25.w, height: 12.h, fit: BoxFit.contain),
                                  GestureDetector(
                                      onTap: () => value.deletePortfolio(index),
                                      child: AppCircleShape(bgColor: redColor, widget: Icon(Icons.delete, color: whiteColor, size: 17.5.sp)))
                                ])
                            ],
                            GestureDetector(
                                onTap: () async => await value.addPortfolio(),
                                child: AppDottedUpload(
                                    svg: roundedAdd,
                                    padding:
                                        EdgeInsets.only(right: localization.locale.languageCode == "en" ? 65.w : 0.w, left: localization.locale.languageCode == "ar" ? 65.w : 0.w),
                                    innerPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h)))
                          ]),
                          SizedBox(height: 5.h),
                          Center(
                              child: App3DButton(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  borderColor: greenishBlack,
                                  tap: () async {
                                    final bool response = await value.createNewUserService();
                                    if (response) {
                                      Navigator.pop(context);
                                    } else {
                                      value.isLoading = false;
                                    }
                                  },
                                  child: AppTextBold(text: localization.translate("SUBMIT"), color: whiteColor, fontFamily: FontFamily.raleway, fontSize: 17.sp))),
                          SizedBox(height: 3.h)
                        ]))),
                value.isLoading ? const Loader() : const SizedBox.shrink()
              ]);
            })));
  }
}
