import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  const AppImage(
      {required this.image,
      this.width,
      this.height,
      this.fit = BoxFit.contain,
      this.alignment = Alignment.centerLeft,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
      fit: fit,
      alignment: alignment,
    );
  }
}

class AppNetworkImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final String? dummyImage;

  const AppNetworkImage(
      {required this.image,
      this.width,
      this.height,
      this.fit = BoxFit.contain,
      this.alignment = Alignment.centerLeft,
      this.dummyImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      cacheWidth: width?.toInt(),
      cacheHeight: height?.toInt(),
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        // Show dummy image if the URL fails to load
        return AppImage(
          image: dummyImage ?? serviceImage,
          fit: BoxFit.cover, // Replace with your dummy image
          width: width,
          height: height,
        );
      },
    );
  }
}
