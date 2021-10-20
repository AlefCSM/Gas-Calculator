import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/stores/connectivity_store/connectivity_store.dart';
import 'package:gas_calculator/stores/home_store/home_store.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with WidgetsBindingObserver {
  HomeStore homeStore = GetIt.I<HomeStore>();
  VehicleStore vehicleStore = GetIt.I<VehicleStore>();
  RefuelStore refuelStore = GetIt.I<RefuelStore>();
  ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  static const _LOGO_IMAGE = "lib/assets/images/wheel.png";
  static const _LINKEDIN_URL = "https://www.linkedin.com/in/alef-moreira/";
  static const _LINKEDIN_IMAGE = "lib/assets/images/linkedin.svg";
  static const _GITHUB_URL = "https://github.com/AlefCSM";
  static const _GITHUB_IMAGE = "lib/assets/images/github.svg";
  static const _IMAGE_PATH = "lib/assets/images/creator.jpeg";
  static const _APP_DESCRIPTION =
      "Gas Calculator is an app developed to make you have a better perception of the fuel consumption in your vehicle as well as how much money do you spent on your refuels and more related data.";
  static const _CREATOR_DESCRIPTION =
      "A Full-Stack developer that loves to create great products, solve problems and a good cup of coffee ☕️";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 32, bottom: 30),
                child: Column(
                  children: [
                    Image.asset(
                      _LOGO_IMAGE,
                      height: 150,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Stack(
                          children: [
                            Text(
                              "Gas Calculator",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: CustomFontSize.largest,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = kDoveGrey),
                            ),
                            Text(
                              "Gas Calculator",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor,
                                  fontSize: CustomFontSize.largest),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                  child: Text(
                _APP_DESCRIPTION,
                style: TextStyle(fontSize: CustomFontSize.large),
              )),
              Container(
                  margin: EdgeInsets.only(top: 30, bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(64.0)),
                          child: Image.asset(
                            _IMAGE_PATH,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Creator",
                            style: TextStyle(
                                color: kLightGrey,
                                fontWeight: FontWeight.w500,
                                fontSize: CustomFontSize.largest),
                          ),
                          Text(
                            "Alef Moreira",
                            style: TextStyle(
                                color: kLightGrey,
                                fontWeight: FontWeight.w300,
                                fontSize: CustomFontSize.larger),
                          )
                        ],
                      ),
                    ],
                  )),
              Container(
                child: Text(
                  _CREATOR_DESCRIPTION,
                  style: TextStyle(fontSize: CustomFontSize.large),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  "Where to find me",
                  style: TextStyle(
                      fontSize: CustomFontSize.larger,
                      fontWeight: FontWeight.w400,
                      color: kLightGrey),
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 70,
                    child: GestureDetector(
                      child: SvgPicture.asset(_GITHUB_IMAGE),
                      onTap: () async {
                        if (await canLaunch(_GITHUB_URL)) {
                          await launch(_GITHUB_URL);
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      child: SvgPicture.asset(_LINKEDIN_IMAGE),
                      onTap: () async {
                        if (await canLaunch(_LINKEDIN_URL)) {
                          await launch(_LINKEDIN_URL);
                        }
                      },
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
