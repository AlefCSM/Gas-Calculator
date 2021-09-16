import 'package:flutter/material.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?>? onChanged;
  final T value;
  final bool isEnabled;
  CustomDropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    this.isEnabled = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: kLighterGreyColor,
              width: 1,
            ),
            color: isEnabled ? kWhiteColor : kLighterGrey),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            itemHeight: 50.0,
            style: TextStyle(
                fontSize: CustomFontSize.regular,
                color:  kGrey),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            value: value,
          ),
        ),
      ),
    );
  }
}
