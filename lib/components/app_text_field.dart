import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? placeholder;
  final Color? backgroundColor;
  final TextEditingController textController;
  final bool? isSecured;
  final double? fontSize;
  final FontFamily? fontFamily;
  final TextInputType? keyboardType;
  final TextInputAction? submitLabel;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool? isTextFieldEnabled;
  final Color? placeholderColor;
  final InputBorder? outlineBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final bool obscureText;
  final double textFieldPadding;
  final int? minLine;
  final int? maxLine;
  final Function()? onTap;
  final TextAlign textAlign;
  final String? prefixText;
  const AppTextField(
      {this.prefixIcon,
      this.suffixIcon,
      this.placeholder,
      this.backgroundColor = Colors.white,
      required this.textController,
      this.isSecured = false,
      this.fontSize = 12.0,
      this.fontFamily =
          FontFamily.raleway, // replace with your actual font family
      this.keyboardType = TextInputType.text,
      this.submitLabel = TextInputAction.next,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator,
      this.isTextFieldEnabled = true,
      this.placeholderColor = lightGreen,
      this.outlineBorder = const UnderlineInputBorder(
        borderSide: BorderSide(
            color: primaryColor, width: 0.5, style: BorderStyle.none),
      ),
      this.focusedBorder = const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2.0),
      ),
      this.enabledBorder = const UnderlineInputBorder(
        borderSide: BorderSide(
            color: primaryColor, width: 0.5, style: BorderStyle.none),
      ),
      this.obscureText = false,
      this.textFieldPadding = 0,
      this.minLine,
      this.maxLine,
      this.onTap,
      this.textAlign = TextAlign.left,
      this.prefixText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // maxLines: (minLine ?? 1) > 0 ? null : 1,
      onTap: onTap,
      minLines: minLine,
      controller: textController,
      keyboardType: keyboardType,
      textInputAction: submitLabel,
      enabled: isTextFieldEnabled,
      obscureText: obscureText,
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily.toString(),
          fontWeight: FontWeight.w400,
          color: placeholderColor),
      cursorColor: placeholderColor,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        prefixText: prefixText,
        border: outlineBorder,
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        // labelText: placeholder,
        // labelStyle: TextStyle(fontSize: 14, color: placeholderColor, fontWeight: FontWeight.w400, fontFamily: fontFamily.toString()),
        // hintStyle: TextStyle(color: placeholderColor),
        hintText: placeholder,
        hintStyle: TextStyle(color: placeholderColor),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator ?? (_) => 'TextField is not Empty',
    );
  }
}
