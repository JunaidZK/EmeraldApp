import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    primaryColorLight: secondaryPrimaryColor,
    scaffoldBackgroundColor: whiteColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: primaryTextColor),
      displayMedium: TextStyle(color: primaryTextColor),
      displaySmall: TextStyle(color: primaryTextColor),
      headlineLarge: TextStyle(color: primaryTextColor),
      headlineMedium: TextStyle(color: primaryTextColor),
      headlineSmall: TextStyle(color: primaryTextColor),
      titleLarge: TextStyle(color: primaryTextColor),
      titleMedium: TextStyle(color: primaryTextColor),
      titleSmall: TextStyle(color: primaryTextColor),
      bodyLarge: TextStyle(color: primaryTextColor),
      bodyMedium: TextStyle(color: primaryTextColor),
      bodySmall: TextStyle(color: primaryTextColor),
      labelLarge: TextStyle(color: primaryTextColor),
      labelMedium: TextStyle(color: primaryTextColor),
      labelSmall: TextStyle(color: primaryTextColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    dividerColor: lightGray,
    tabBarTheme: const TabBarTheme(
      dividerHeight: 0,
      // indicator: BoxDecoration()
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(lightTurquoise),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: whiteColor,
      hourMinuteShape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: const BorderSide(
          color: lightTurquoise,
          width: 1.0
        )
      ),
      hourMinuteColor: primaryColor,
      hourMinuteTextColor: lightTurquoise,
      dayPeriodColor: primaryColor,
      dayPeriodTextColor: lightTurquoise,
      confirmButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(whiteColor),
        backgroundColor: WidgetStatePropertyAll(primaryColor),
        textStyle: WidgetStatePropertyAll(TextStyle(
          color: whiteColor
        ))
      ),
      cancelButtonStyle: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(redColor),
        textStyle: WidgetStatePropertyAll(TextStyle(
          color: redColor
        ))
      ),
      dialHandColor: whiteColor,
      dialBackgroundColor: primaryColor,
      dialTextColor: lightTurquoise,
    )
  );
}