import 'package:flutter/material.dart';

class ScreenUtil {
  static const TEXT_FACTOR_0_7 = 0.7;
  static const TEXT_FACTOR_0_9 = 0.9;
  static const TEXT_FACTOR_1_0 = 1.0;
  static const TEXT_FACTOR_1_03 = 1.03;
  static const TEXT_FACTOR_1_05 = 1.05;
  static const TEXT_FACTOR_1_1 = 1.1;
  static const TEXT_FACTOR_1_2 = 1.2;
  static const TEXT_FACTOR_1_3 = 1.3;

  static void hideKeyboard(context) {
    FocusScope.of(context).unfocus();
  }

  static bool keyboardIsVisible(context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }



  MediaQueryData mediaQueryTextFactor(
      BuildContext context, double defaultTextFactor) {
    return MediaQueryData(
        textScaleFactor: MediaQuery.of(context).textScaleFactor > 1
            ? defaultTextFactor
            : MediaQuery.of(context).textScaleFactor);
  }
}