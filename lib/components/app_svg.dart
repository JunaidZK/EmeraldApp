import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvg extends StatelessWidget {
  final String svgName;
  final double? width;
  final double? height;
  final BoxFit boxfit;
  final Color? color;
  final Alignment alignment;
  const AppSvg({
    required this.svgName,
    this.width,
    this.height,
    this.boxfit = BoxFit.contain,
    this.color,
    this.alignment = Alignment.center,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgName,
      width: width,
      alignment: alignment,
      height: height,
      fit: boxfit,
      color: color,
    );
  }
}