import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/contact_us/contact_us_view.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/customer_support_provider.dart';
import 'package:emerald_beauty/views/main_home/profile_tab/communication/customer_support/faqs/faqs_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomerSupportView extends StatefulWidget {
  const CustomerSupportView({super.key});

  @override
  State<CustomerSupportView> createState() => _CustomerSupportViewState();
}

class _CustomerSupportViewState extends State<CustomerSupportView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeNotifierProvider(
      create: (_) => CustomerSupportProvider(this, context),
      child:
          Consumer<CustomerSupportProvider>(builder: (context, value, child) {
        return Stack(
          children: [
            Scaffold(
                appBar: appBar(
                  context,
                  appBarheight: 8.h,
                  leftWidget: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Transform.flip(
                      flipX: localization!.locale.languageCode == "ar",
                      child: const AppSvg(
                        svgName: arrowBack,
                        boxfit: BoxFit.none,
                      ),
                    ),
                  ),
                  title: localization.translate("SUPPORT CENTER"),
                ),
                body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Column(
                      children: [
                        TabBar(
                          controller: value.tabController,
                          dividerHeight: 1.5,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorWeight: 1.5,
                          unselectedLabelColor: grayColor,
                          labelColor: Theme.of(context).primaryColor,
                          dividerColor: whiteBorderColor,
                          tabs: value.tabs,
                        ),
                        Expanded(
                            child: TabBarView(
                                controller: value.tabController,
                                children: const [FaqsView(), ContactUsView()]))
                      ],
                    ))),
            if (value.isLoading)
              const Center(
                child: Loader(),
              )
          ],
        );
      }),
    );
  }
}
