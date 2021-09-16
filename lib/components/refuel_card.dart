import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/models/fuel_type_model.dart';
import 'package:gas_calculator/models/refuel_model.dart';

class RefuelCard extends StatelessWidget {
  final Refuel refuel;

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("${refuel.odometer} km"), Text("${refuel.date}")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$ ${refuel.price}"),
                Text("${FuelType().nameFromId(refuel.fuelTypeId)} (${refuel.litres} L)")
              ],
            ),
            Text("${FuelType().nameFromId(refuel.fuelTypeId)} (${refuel.litres} L)")
          ],
        ));
  }
}
