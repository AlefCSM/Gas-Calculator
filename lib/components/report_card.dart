import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/models/report_model.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/report_store/report_store.dart';
import 'package:gas_calculator/util/screen_util/string_extension.dart';
import 'package:get_it/get_it.dart';

class ReportCard extends StatelessWidget {
  final ReportStore reportStore = GetIt.I<ReportStore>();
  final int fuelTypeId;
  static const ETHANOL_ICON = "lib/assets/images/ethanol.png";
  static const DIESEL_ICON = "lib/assets/images/diesel.png";
  static const GASOLINE_ICON = "lib/assets/images/gasoline.png";
  static const ETHANOL_ID = 1;
  static const DIESEL_ID = 2;
  static const GASOLINE_ID = 3;

  ReportCard({required this.fuelTypeId});

  ReportModel getReportByFuelType(int fuelTypeId) {
    switch (fuelTypeId) {
      case ETHANOL_ID:
        return reportStore.ethanolReport;
      case DIESEL_ID:
        return reportStore.dieselReport;
      case GASOLINE_ID:
        return reportStore.gasolineReport;
      default:
        return ReportModel();
    }
  }

  String getReportTitle(int fuelTypeId) {
    switch (fuelTypeId) {
      case ETHANOL_ID:
        return FuelTypes.ETHANOL.text.capitalize();
      case DIESEL_ID:
        return FuelTypes.DIESEL.text.capitalize();
      case GASOLINE_ID:
        return FuelTypes.GASOLINE.text.capitalize();
      default:
        return "";
    }
  }

  String getReportIcon(int fuelTypeId) {
    switch (fuelTypeId) {
      case ETHANOL_ID:
        return ETHANOL_ICON;
      case DIESEL_ID:
        return DIESEL_ICON;
      case GASOLINE_ID:
        return GASOLINE_ICON;
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    ReportModel report = getReportByFuelType(fuelTypeId);
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          color: kLighterGrey,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: kDarkGrey,
              blurRadius: 12,
              spreadRadius: -5.2,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  getReportIcon(fuelTypeId),
                  height: 60,
                  width: 60,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 5, right: 60),
                            alignment: Alignment.center,
                            child: Text(
                              getReportTitle(fuelTypeId),
                              style: TextStyle(
                                color: kDarkGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: CustomFontSize.larger,
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text("Total cost",
                                    style: TextStyle(
                                        color: kDarkGrey,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "U\$ ${report.totalCost.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: kDarkGrey,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Container(
                              height: 30,
                              width: .5,
                              color: kLightGrey,
                            ),
                            Column(
                              children: [
                                Text("Total volume",
                                    style: TextStyle(
                                        color: kDarkGrey,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "${report.totalVolume.toStringAsFixed(3)} L",
                                    style: TextStyle(
                                        color: kDarkGrey,
                                        fontWeight: FontWeight.w500))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 5),
              child: Text("Fuel efficiency",
                  style: TextStyle(
                      color: kDarkGrey,
                      fontSize: CustomFontSize.large,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Average",
                          style: TextStyle(
                              color: kDarkGrey, fontWeight: FontWeight.bold)),
                      Text(
                          "${report.averageConsumption.toStringAsFixed(3)} km/L",
                          style: TextStyle(
                              color: kDarkGrey, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Last",
                          style: TextStyle(
                              color: kDarkGrey, fontWeight: FontWeight.bold)),
                      Text("${report.lastConsumption.toStringAsFixed(3)} km/L",
                          style: TextStyle(
                              color: kDarkGrey, fontWeight: FontWeight.w500))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 30,
                    width: .5,
                    color: kLightGrey,
                  ),
                  Column(
                    children: [
                      Text("Lowest",
                          style: TextStyle(
                              color: kDarkRedColor,
                              fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Text(
                              "${report.lowestConsumption.toStringAsFixed(3)} km/L",
                              style: TextStyle(
                                  color: kDarkGrey,
                                  fontWeight: FontWeight.w500))
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 30,
                    width: .5,
                    color: kLightGrey,
                  ),
                  Column(
                    children: [
                      Text("Highest",
                          style: TextStyle(
                              color: kDarkGreenColor,
                              fontWeight: FontWeight.bold)),
                      Text(
                          "${report.highestConsumption.toStringAsFixed(3)} km/L",
                          style: TextStyle(
                              color: kDarkGrey, fontWeight: FontWeight.w500))
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
