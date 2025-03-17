import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppMobileTextfield extends StatelessWidget {
  final String countryCode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? placeholder;
  final Color? backgroundColor;
  final TextEditingController textController;
  final double? fontSize;
  final FontFamily? fontFamily;
  final TextInputType? keyboardType;
  final TextInputAction? submitLabel;
  final void Function(PhoneNumber)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool? isTextFieldEnabled;
  final Color? placeholderColor;
  final InputBorder? outlineBorder;

  const AppMobileTextfield({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.placeholder = "Mobile Number",
    this.countryCode = "AE",
    this.backgroundColor = whiteColor,
    required this.textController,
    this.fontSize = 16.0,
    this.fontFamily =
        FontFamily.hermann, // replace with your actual font family
    this.keyboardType = TextInputType.text,
    this.submitLabel = TextInputAction.next,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.isTextFieldEnabled = true,
    this.placeholderColor = lightGreen,
    this.outlineBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: lightGray, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: IntlPhoneField(
            enabled: isTextFieldEnabled!,
            controller: textController,
            textAlignVertical: TextAlignVertical.bottom,
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: fontFamily.toString(),
                color: placeholderColor),
            dropdownTextStyle: TextStyle(
                fontSize: fontSize,
                fontFamily: fontFamily.toString(),
                color: placeholderColor),
            decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: lightGray, width: 0.5, style: BorderStyle.none),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0),
                ),
                counterText: ""),
            initialCountryCode: countryCode, // Set a default country code
            onChanged: onChanged,
            showCountryFlag: true, // Display country flag
          ),
        ),
        // Size
      ],
    );
  }
}
