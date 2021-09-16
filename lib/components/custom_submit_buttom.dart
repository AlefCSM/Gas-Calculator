import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:progress_indicators/progress_indicators.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final String prefixIcon;
  final void Function()? onPressed;
  final bool loading;
  final bool disabled;

  static const defaultTextFactor = 1.0;

  SubmitButton({
     Key? key,
    required this.text,
    required this.onPressed,
    this.loading = false,
    this.disabled = false,
    this.prefixIcon = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(bottom: loading ? 10 : 0)),
        child: Visibility(
          replacement:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Visibility(
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: SvgPicture.asset(prefixIcon),
              ),
              visible: prefixIcon.isNotEmpty,
            ),
            Text(text)
          ]),
          visible: loading,
          child: Center(
            child: MediaQuery(
              data: MediaQueryData(
                  textScaleFactor:
                      MediaQuery.of(context).textScaleFactor > defaultTextFactor
                          ? defaultTextFactor
                          : MediaQuery.of(context).textScaleFactor),
              child: JumpingDotsProgressIndicator(
                fontSize: CustomFontSize.larger,
                color: kWhiteColor,
              ),
            ),
          ),
        ),
        onPressed: disabled ? null : onPressed,
      ),
    );
  }
}
