import 'package:emerald_beauty/components/app_image.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';

class AppCircularImage extends StatelessWidget {
  final String image;
  final String? networkImage;
  final double borderWidth;
  final Color? borderColor;
  final double imgHeight;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;

  const AppCircularImage(
      {super.key, this.image = dummyUploadedImage, this.networkImage, this.borderWidth = 2, this.borderColor, this.imgHeight = 100, this.fit = BoxFit.cover, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: imgHeight,
        height: imgHeight,
        alignment: alignment,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(imgHeight / 2)), border: Border.all(color: borderColor ?? Theme.of(context).secondaryHeaderColor, width: borderWidth)),
        child: networkImage != null
            ? ClipOval(child: AppNetworkImage(image: networkImage!, width: imgHeight, height: imgHeight, fit: fit!, dummyImage: image))
            : AppImage(image: image, width: imgHeight, height: imgHeight, fit: fit!));
  }
}
