import 'package:flutter/material.dart';

void bottomSheet(BuildContext context, Widget widget){
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return widget;
      }
  );
}