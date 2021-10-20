import 'package:flutter/material.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';

class CustomErrorText extends StatelessWidget {
  final String text;
  final TextAlign align;

  CustomErrorText({
    Key? key,
    required this.text,
    this.align = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Text(
        text,
        style: TextStyle(
          fontSize: CustomFontSize.small,
          fontWeight: FontWeight.w400,
          color: kRedColor,
        ),
        textAlign: align,
      ),
    );
  }
}
