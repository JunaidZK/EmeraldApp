import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_tab_item.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/add_new_service/add_new_service_view.dart';
import 'package:emerald_beauty/views/main_home/main_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainHomeView extends StatefulWidget {
  final Users user;
  final RequestFrom requestFrom;
  const MainHomeView(
      {this.user = Users.employee, required this.requestFrom, super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView>
    with SingleTickerProviderStateMixin {
  late MainHomeProvider provider;

  @override
  void initState() {
    super.initState();
    // Initialize the provider locally and fetch categories
    provider = MainHomeProvider(this, widget.user, widget.requestFrom);
    provider.toggleLoader(true);
    provider.fetchUserProfile();
    provider.getAllBookings().then((val) {
      provider.getHistoryBookings();
    });
    provider.getUnreadNotifications();
    provider.toggleLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => provider,
      child: Consumer<MainHomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const PopScope(canPop: false, child: Loader());
          } else {
            return PopScope(
              canPop: false,
              child: Stack(
                children: [
                  Scaffold(
                    body: BottomBar(
                      width: width * 0.925,

                      barColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(24.0),
                      // Update: Set the PageView as the main body to listen to swiping
                      body: (context, scrollController) => PageView(
                          controller: provider.pageController,
                          onPageChanged: (index) {
                            // Trigger setPage only once on page change
                            if (provider.currentPage != index) {
                              provider.setPage(index);
                            }
                          },
                          children: provider.pages
                              .map((page) => page(scrollController))
                              .toList()),
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          TabBar(
                              controller: provider.tabController,
                              padding: EdgeInsets.symmetric(vertical: 0.5.h),
                              indicator: const BoxDecoration(),
                              tabs: [
                                TabItem(
                                    label: localization!.translate("Home"),
                                    svgName: home,
                                    index: 0),
                                TabItem(
                                    label: localization.translate("Booking"),
                                    svgName: booking,
                                    index: 1),
                                TabItem(
                                    label: localization.translate("Message"),
                                    svgName: message,
                                    index: 2),
                                TabItem(
                                    label: localization.translate("Profile"),
                                    svgName: profileBottomIcon,
                                    index: 3)
                              ]),
                          Visibility(
                            visible: widget.user == Users.freelancer,
                            child: Positioned(
                                top: -32.5,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddNewServiceView()));
                                  },
                                  child: AppCircleShape(
                                      bgColor: Theme.of(context).primaryColor,
                                      borderColor:
                                          Theme.of(context).primaryColor,
                                      horizontalPadding: 5.w,
                                      verticalPadding: 2.5.h,
                                      widget: const Center(
                                        child: AppSvg(svgName: addIcon),
                                      )),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
