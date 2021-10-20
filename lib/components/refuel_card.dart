import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/models/fuel_type_model.dart';
import 'package:gas_calculator/models/refuel_model.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:get_it/get_it.dart';

class RefuelCard extends StatelessWidget {
  final Refuel refuel;
  final RefuelStore refuelStore = GetIt.I<RefuelStore>();

  RefuelCard({required this.refuel});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("${refuel.odometer} km",
                  style: TextStyle(
                      color: kDarkGrey,
                      fontSize: CustomFontSize.large,
                      fontWeight: FontWeight.bold)), Text("${refuel.date}",
                  style: TextStyle(
                      color: kLightGrey,
                      fontSize: CustomFontSize.small))],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$ ${refuel.price}",
                    style: TextStyle(
                        color: kDarkGrey,
                        fontWeight: FontWeight.w500)),
                Text(
                    "${FuelType().nameFromId(refuel.fuelTypeId)} (${refuel.litres} L)",
                    style: TextStyle(
                        color: kDarkGrey,
                        fontWeight: FontWeight.w500))
              ],
            ),
            Text("${refuel.consuption.toStringAsFixed(2)} km/L",
                style: TextStyle(
                    color: kDarkGrey,
                    fontWeight: FontWeight.w500))
          ],
        ));
  }
}
