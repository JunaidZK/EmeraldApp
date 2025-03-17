import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class AppDropDownTextfield<T> extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? placeholder;
  final Color? backgroundColor;
  final bool? isSecured;
  final double? fontSize;
  final FontFamily? fontFamily;
  final TextInputType? keyboardType;
  final TextInputAction? submitLabel;
  final void Function(T?)? onChanged;
  final void Function(T?)? onFieldSubmitted;
  final String? validator;
  final VoidCallback? onTap;
  final bool? isTextFieldEnabled;
  final Color? placeholderColor;
  final InputBorder? outlineBorder;
  final bool obscureText;
  final List<DropdownMenuItem<T>>? items;
  final double textFieldPadding;
  final String? Function(T?)? validation;
  final T? value;

  const AppDropDownTextfield({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.placeholder,
    this.backgroundColor = Colors.white,
    this.isSecured = false,
    this.fontSize = 13.0,
    this.fontFamily = FontFamily.hermann,
    this.keyboardType = TextInputType.text,
    this.submitLabel = TextInputAction.next,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator = 'textfield',
    this.onTap,
    this.isTextFieldEnabled = true,
    this.placeholderColor = lightGreen,
    this.outlineBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: lightGray, width: 2.0),
    ),
    this.obscureText = false,
    this.textFieldPadding = 0,
    this.items,
    this.validation,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<T>(
        value: value,
        icon: suffixIcon,
        items: items,
        style: TextStyle(
          color: placeholderColor,
          fontSize: fontSize,
          fontFamily: fontFamily.toString(),
        ),
        onChanged: (T? val) {
          onChanged?.call(val);
        },
        onTap: onTap,
        onSaved: (T? val) {
          onFieldSubmitted?.call(val);
        },
        decoration: InputDecoration(
          fillColor: whiteColor,
          border: outlineBorder,
          focusedBorder: outlineBorder,
          hintStyle: TextStyle(
              fontSize: 14,
              color: placeholderColor,
              fontWeight: FontWeight.w600),
          prefixIcon: prefixIcon,
          hintText: placeholder,
        ),
        validator: validation ??
            (T? value) {
              if (value == null) {
                return 'Please select a value';
              }
              return null;
            },
      ),
    );
  }
}
