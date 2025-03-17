import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSilverBar extends StatelessWidget {
  final bool? isDarkMode;
  final void Function()? onTap;
  const AppSilverBar({super.key, this.isDarkMode, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 27.5.h,
        maxHeight: 27.5.h,
        child: Container(
          color: whiteColor,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: AppImage(
                image: appBarHeader,
                width: MediaQuery.of(context).size.width,
                height: 27.5.h,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double currentHeight =
        maxExtent - shrinkOffset.clamp(0.0, maxExtent - minExtent);

    return SizedBox(
      height: currentHeight,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent ||
        child != (oldDelegate as SliverAppBarDelegate).child;
  }
}
