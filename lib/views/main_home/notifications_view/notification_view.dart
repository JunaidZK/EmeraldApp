import 'package:emerald_beauty/components/app_bar.dart';
import 'package:emerald_beauty/components/app_circle_shape.dart';
import 'package:emerald_beauty/components/app_container_box.dart';
import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/components/app_text.dart';
import 'package:emerald_beauty/components/loader.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:emerald_beauty/views/main_home/notifications_view/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late NotificationProvider notificationProvider;

  @override
  void initState() {
    super.initState();
    notificationProvider = NotificationProvider();
    notificationProvider.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => notificationProvider,
      child:
          Consumer<NotificationProvider>(builder: (context, provider, child) {
        if (provider.notifications != null) {
          return Scaffold(
            appBar: appBar(context,
                title: "NOTIFICATIONS",
                appBarheight: 8.h,
                leftWidget: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const AppSvg(
                    svgName: arrowBack,
                    boxfit: BoxFit.none,
                  ),
                )),
            body: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              itemCount: provider.notifications!.data.length,
              itemBuilder: (context, index) {
                final notification = provider.notifications!.data[index];
                return AppContainerBox(
                  containerWidth: double.infinity,
                  bgColor: whiteColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.5.w, vertical: 0.5.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                AppCircleShape(
                                  verticalPadding: 2.5.h,
                                  horizontalPadding: 2.w,
                                  widget: const AppSvg(svgName: notifications),
                                ),
                                SizedBox(width: 7.5.w),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTextSemiBold(
                                        text: notification.title,
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: FontFamily.raleway,
                                        fontSize: 15.5.sp,
                                      ),
                                      SizedBox(height: 1.25.h),
                                      AppTextRegular(
                                        text: notification.message,
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: FontFamily.hermann,
                                        fontSize: 14.5.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.5.h),
                            child: AppTextThin(
                              text: notification.createdAgo,
                              color: Theme.of(context).primaryColor,
                              fontFamily: FontFamily.hermann,
                              fontSize: 13.sp,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                thickness: 1,
                height: 1.h,
              ),
            ),
          );
        } else {
          return const Loader();
        }
      }),
    );
  }
}
