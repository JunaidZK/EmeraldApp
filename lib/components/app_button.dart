import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class App3DButton extends StatelessWidget {
  final GestureTapCallback? tap;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final Color borderColor;
  final Widget? child;
  final double borderRadius;
  const App3DButton(
      {this.tap,
      this.height = 45,
      this.width = 180,
      required this.backgroundColor,
      required this.borderColor,
      this.child,
      this.borderRadius = 26.0,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius)),
            child: Center(
              child: child,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 1.w, top: 0.2.h),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: borderColor)),
            ),
          )
        ],
      ),
    );
  }
}
