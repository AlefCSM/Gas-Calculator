import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'dart:math' as math;

import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  static const SPINNING_ICON = "lib/assets/images/wheel.png";

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlueColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Image.asset(
                SPINNING_ICON,
                height: 150,
              ),
            ),
            Container(margin: EdgeInsets.only(top: 10),child:
            Text(
              "Gas Calculator",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                  fontSize: CustomFontSize.largest),
            ))
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
