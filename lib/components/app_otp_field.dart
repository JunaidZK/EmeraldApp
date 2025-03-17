import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppOtpField extends StatelessWidget {
  final Color? placeholderColor;
  final double? fontSize;
  final FontFamily? fontFamily;
  final Function(String) onOtpEntered;
  const AppOtpField(
      {this.placeholderColor = lightGreen,
      this.fontSize = 16.0,
      this.fontFamily = FontFamily.hermann,
      required this.onOtpEntered,
      super.key});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 4,
      fieldWidth: 20.w,
      textStyle: TextStyle(
        color: placeholderColor,
        fontSize: fontSize,
        fontFamily: fontFamily.toString(),
      ),
      focusedBorderColor: Theme.of(context).primaryColor,
      showFieldAsBox: false,
      cursorColor: Theme.of(context).primaryColor,
      onSubmit: (otp) {
        onOtpEntered(otp); // Pass the OTP to the callback
      },
    );
  }
}
