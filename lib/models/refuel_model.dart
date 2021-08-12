import 'package:gas_calculator/models/vehicle_model.dart';

class Refuel {
  int id;
  String date;
  double odometer;
  double price;
  double totalCost;
  double litres;
  Vehicle vehicle;

  Refuel(this.date, this.odometer, this.price, this.totalCost,
      this.litres, this.vehicle);
}
