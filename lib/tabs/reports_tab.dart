import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/components/report_card.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/report_store/report_store.dart';
import 'package:get_it/get_it.dart';

class ReportsTab extends StatefulWidget {
  @override
  _ReportsTabState createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  ReportStore reportStore = GetIt.I<ReportStore>();
  RefuelStore refuelStore = GetIt.I<RefuelStore>();

  @override
  void initState() {
    reportStore.loadRefuelsByFuelType();
    reportStore.loadFuelTypeReport(generalReport: true);

    for (final fuelType in refuelStore.fuelTypeList) {
      reportStore.loadFuelTypeReport(fuelTypeId: fuelType.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "General",
                      style: TextStyle(
                          color: kDarkGrey,
                          fontSize: CustomFontSize.larger,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 10)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Total cost",
                              style: TextStyle(
                                  color: kDarkGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("U\$ ${reportStore.generalReport.totalCost}",
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
                            Text(
                              "Total volume",
                              style: TextStyle(
                                  color: kDarkGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("${reportStore.generalReport.totalVolume} L",
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
                            Text(
                              "Total km",
                              style: TextStyle(
                                  color: kDarkGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("${reportStore.generalReport.totalKm} km",
                                style: TextStyle(
                                    color: kDarkGrey,
                                    fontWeight: FontWeight.w500))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10),
                      child: Text("Fuel efficiency",
                          style: TextStyle(
                              color: kDarkGrey,
                              fontSize: CustomFontSize.large,
                              fontWeight: FontWeight.bold))),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Average",
                                style: TextStyle(
                                    color: kDarkGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "${reportStore.generalReport.averageConsumption.toStringAsFixed(3)} km/L",
                                  style: TextStyle(
                                      color: kDarkGrey,
                                      fontWeight: FontWeight.w500))
                            ],
                          )
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(),
                  ),
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Last",
                                style: TextStyle(
                                    color: kDarkGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "${reportStore.generalReport.lastConsumption} km/L",
                                  style: TextStyle(
                                      color: kDarkGrey,
                                      fontWeight: FontWeight.w500))
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
                              Text(
                                "Lowest",
                                style: TextStyle(
                                    color: kDarkRedColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "${reportStore.generalReport.lowestConsumption} km/L",
                                  style: TextStyle(
                                      color: kDarkGrey,
                                      fontWeight: FontWeight.w500))
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
                              Text(
                                "Highest",
                                style: TextStyle(
                                    color: kDarkGreenColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "${reportStore.generalReport.highestConsumption} km/L",
                                  style: TextStyle(
                                      color: kDarkGrey,
                                      fontWeight: FontWeight.w500))
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Observer(builder: (_) {
                  return Visibility(
                      visible: reportStore.dieselRefuelsList.isNotEmpty,
                      child: ReportCard(
                        fuelTypeId: FuelTypes.DIESEL.id,
                      ));
                })),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Observer(builder: (_) {
                  return Visibility(
                      visible: reportStore.ethanolRefuelsList.isNotEmpty,
                      child: ReportCard(
                        fuelTypeId: FuelTypes.ETHANOL.id,
                      ));
                })),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Observer(builder: (_) {
                  return Visibility(
                      visible: reportStore.gasolineRefuelsList.isNotEmpty,
                      child: ReportCard(
                        fuelTypeId: FuelTypes.GASOLINE.id,
                      ));
                })),
          ],
        ),
      ),
    );
  }
}
