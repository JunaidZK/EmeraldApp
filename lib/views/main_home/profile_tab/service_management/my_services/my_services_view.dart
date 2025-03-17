import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_box.dart';
import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/components/app_search_field.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/service_management/my_services/detailed_service_overview/detailed_service_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/service_management/my_services/my_services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyServicesView extends StatefulWidget {
  final Users user;
  const MyServicesView({required this.user, super.key});

  @override
  State<MyServicesView> createState() => _MyServicesViewState();
}

class _MyServicesViewState extends State<MyServicesView> {
  late MyServicesProvider serviceProvider;

  @override
  void initState() {
    super.initState();
    serviceProvider = MyServicesProvider();
    serviceProvider.fetchAllEmployeeServices();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
        create: (_) => serviceProvider,
        child: Consumer<MyServicesProvider>(builder: (context, value, child) {
          if (value.employeeServices == null ||
              value.employeeServices!.data.isEmpty) {
            return const Loader();
          } else {
            return Scaffold(
                appBar: appBar(context,
                    appBarheight: 8.h,
                    title: localization!.translate("SERVICE MANAGEMENT"),
                    leftWidget: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Transform.flip(
                          flipX: localization.locale.languageCode == "ar",
                          child: const AppSvg(
                              svgName: arrowBack, boxfit: BoxFit.none),
                        ))),
                body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Column(children: [
                      SizedBox(height: 2.5.h),
                      AppSearchField(
                          cntrller: value.searchController,
                          text: "${localization.translate("Search here")}...",
                          style: TextStyle(
                              color: lightGray,
                              fontFamily: FontFamily.raleway.toString()),
                          icon: Icon(Icons.search,
                              color: Theme.of(context).primaryColor),
                          fillColor: whiteColor),
                      SizedBox(height: 3.h),
                      if (value.filteredServices.isNotEmpty)
                        Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio: 1),
                                itemCount: value.filteredServices.length,
                                itemBuilder: (context, index) {
                                  var service = value.filteredServices[index];
                                  var employeeService =
                                      value.employeeServices!.data[index];
                                  return GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailedServiceView(
                                                      service: service,
                                                      employeeService:
                                                          employeeService))),
                                      child: AppBox(
                                          elevation: 0,
                                          bgColor: whiteColor,
                                          borderColor: greenishBlack,
                                          borderWidth: 1.5,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w,
                                                  vertical: 0.75.h),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        child: AppNetworkImage(
                                                            image: service
                                                                .data
                                                                .coverPhoto
                                                                .path,
                                                            height: 13.5.h,
                                                            width: 45.w)),
                                                    SizedBox(height: 0.3.h),
                                                    AppTextSemiBold(
                                                        text: localization
                                                                    .locale
                                                                    .languageCode ==
                                                                "en"
                                                            ? employeeService
                                                                .service!.name
                                                            : employeeService
                                                                .service!
                                                                .arabicName,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontFamily:
                                                            FontFamily.raleway,
                                                        fontSize: localization
                                                                    .locale
                                                                    .languageCode ==
                                                                "en"
                                                            ? 14.5.sp
                                                            : 13.sp),
                                                    SizedBox(height: 1.h),
                                                    AppTextSemiBold(
                                                        text: employeeService
                                                                    .price !=
                                                                0
                                                            ? employeeService
                                                                .price
                                                                .toString()
                                                            : employeeService
                                                                .service!.price
                                                                .toString(),
                                                        fontFamily:
                                                            FontFamily.raleway,
                                                        fontSize: 15.sp,
                                                        color: tealColor)
                                                  ]))));
                                })),
                      if (value.filteredServices.isEmpty)
                        Center(
                            child: AppTextMedium(
                                text: "No Services Found",
                                color: Theme.of(context).primaryColor,
                                fontFamily: FontFamily.raleway,
                                fontSize: 15.sp))
                    ])));
          }
        }));
  }
}
