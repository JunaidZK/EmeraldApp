import 'package:flutter/material.dart';

BottomNavigationBarItem bottomAppItem(
  BuildContext context,{
    required final Widget icon,
    final String label = "Home",
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
}