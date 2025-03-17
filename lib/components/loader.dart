import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust duration as needed
    )..repeat(); // Continuous looping animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.black.withOpacity(0.8),
      width: width,
      height: height,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Apply flipping animation
            double angle = _controller.value * 3.14159 * 2; // Full rotation
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(angle), // Rotate along Y-axis for horizontal flipping
              child: AppImage(
                image: logo,
                width: 10.w,
                height: 10.h,
              ),
            );
          },
        ),
      ),
    );
  }
}
