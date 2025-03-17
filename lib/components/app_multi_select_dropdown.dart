import 'package:emerald_beauty/components/app_svg.dart';
import 'package:emerald_beauty/constant_values/colors.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/image_files.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppMultiSelectDropdown<T extends Object> extends StatelessWidget {
  final List<DropdownItem<T>> dropDownItems;
  final MultiSelectController<T> cntrller;
  final String? Function(List<T>?)? validator;
  final bool enabled;
  const AppMultiSelectDropdown(
      {required this.dropDownItems,
      required this.cntrller,
      this.validator,
      this.enabled = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MultiDropdown<T>(
      items: dropDownItems,
      controller: cntrller,
      enabled: enabled,
      validator: (List<DropdownItem<T>>? selectedItems) {
        // Map the selected DropdownItems to their values and pass them to the validator
        final selectedValues =
            selectedItems?.map((item) => item.value).toList();
        return validator?.call(selectedValues);
      },
      chipDecoration: ChipDecoration(
          backgroundColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12.0),
          labelStyle: TextStyle(
              color: whiteColor,
              fontFamily: FontFamily.raleway.name,
              fontWeight: FontWeight.w600),
          runSpacing: 1.25.w,
          wrap: true,
          spacing: 0.5.h,
          deleteIcon: Icon(
            Icons.cancel,
            color: whiteColor,
            size: 15.sp,
          )),
      fieldDecoration: FieldDecoration(
          hintText: "Area of Expertise",
          hintStyle: TextStyle(
              color: grayColor,
              fontFamily: FontFamily.raleway.name,
              fontWeight: FontWeight.w300,
              fontSize: 14.sp),
          suffixIcon: const AppSvg(
            svgName: dropDownIcon,
            boxfit: BoxFit.none,
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 0.5))),
    );
  }
}
