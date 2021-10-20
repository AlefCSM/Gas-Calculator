import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/util/screen_util/screen_util.dart';

class WarningDialog extends StatelessWidget with ScreenUtil {
  final String title;
  final String description;
  final String textButton;
  final String? icon;
  final Function()? onOkFunction;
  final bool unlimitedText;
  final double? okTextFontSize;

  WarningDialog({
    required this.title,
    required this.description,
    required this.textButton,
    this.icon = "lib/assets/images/no-internet.png",
    this.onOkFunction,
    this.unlimitedText = false,
    this.okTextFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: MediaQuery(
        data: mediaQueryTextFactor(context, ScreenUtil.TEXT_FACTOR_1_0),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CustomFontSize.large,
            color: kDarkGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 15.0),
      content: MediaQuery(
        data: mediaQueryTextFactor(context, ScreenUtil.TEXT_FACTOR_1_2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  icon!,
                  height: 60,
                  width: 60,
                ),
                margin: EdgeInsets.only(bottom: 20),
              ),
              Text(
                description,
                maxLines: unlimitedText ? null : 2,
                textAlign: TextAlign.center,
                overflow: unlimitedText
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: CustomFontSize.small,
                  color: kGrey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(45),
                  ),
                  child: Text(
                    textButton,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: okTextFontSize != null
                          ? okTextFontSize
                          : CustomFontSize.smallest,
                      color: kDarkBlueColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (onOkFunction != null) {
                      onOkFunction!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
