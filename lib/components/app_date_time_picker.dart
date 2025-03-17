import 'package:emerald_beauty/components/app_text_field.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDateTimePicker extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final VoidCallback onTap;
  final bool enabled;
  final Widget icon;
  const AppDateTimePicker(
      {required this.controller,
      required this.labelText,
      required this.onTap,
      this.enabled = true,
      this.icon = const Icon(Icons.access_time, color: primaryColor),
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: enabled,
        child: AppTextField(
            textController: controller,
            placeholder: labelText,
            placeholderColor: Theme.of(context).primaryColor,
            fontSize: 15.5.sp,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1.0)),
            isTextFieldEnabled: enabled,
            suffixIcon: icon),
      ),
    );
  }
}
