import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';

class ExpertiseProvider extends ChangeNotifier{
  var expertise = [
    {
      "image": certificate,
      "expertise": "Hair Cutting",
      "status": "Verified",
    },
    {
      "image": certificate,
      "expertise": "Hair Treatment",
      "status": "Pending",
    },
    {
      "image": certificate,
      "expertise": "Hair Coloring",
      "status": "Rejected",
    }
  ];
}