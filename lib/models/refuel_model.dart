import 'package:gas_calculator/models/vehicle_model.dart';

final tableRefuels = 'refuels';

class RefuelFields {
  static final String id = '_id';
  static final String date = 'date';
  static final String odometer = 'odometer';
  static final String price = 'price';
  static final String totalCost = 'totalCost';
  static final String litres = 'litres';
  static final String vehicleId = 'vehicleId';
  static final String fuelTypeId = 'fuelTypeId';
  static final String firebaseId = 'firebaseId';
  static final String deleted = 'deleted';
}

class Refuel {
  int id;
  String date;
  double odometer;
  double price;
  double totalCost;
  double litres;
  int vehicleId;
  int fuelTypeId;
  String firebaseId;
  bool deleted;

  Refuel(
      {this.id = 0,
      this.date,
      this.odometer,
      this.price,
      this.totalCost,
      this.litres,
      this.vehicleId,
      this.fuelTypeId,
      this.firebaseId,
      this.deleted = false});

  Refuel copy(
          {int id,
          String date,
          double odometer,
          double price,
          double totalCost,
          double litres,
          Vehicle vehicle,
          String firebaseId,
          bool deleted}) =>
      Refuel(
        id: id ?? this.id,
        date: date ?? this.date,
        odometer: odometer ?? this.odometer,
        price: price ?? this.price,
        totalCost: totalCost ?? this.totalCost,
        litres: litres ?? this.litres,
        vehicleId: vehicle ?? this.vehicleId,
        fuelTypeId: fuelTypeId ?? this.fuelTypeId,
        firebaseId: firebaseId ?? this.firebaseId,
        deleted: deleted ?? this.deleted,
      );

  Refuel.fromJson(Map<String, dynamic> json, {bool sync = false}) {
    if (!sync) {
      id = int.parse('${json[RefuelFields.id]}');
    }

    date = json[RefuelFields.date];
    odometer = double.parse('${json[RefuelFields.odometer]}');
    price = double.parse('${json[RefuelFields.price]}');
    totalCost = double.parse('${json[RefuelFields.totalCost]}');
    litres = double.parse('${json[RefuelFields.litres]}');
    vehicleId = int.parse('${json[RefuelFields.vehicleId]}');
    fuelTypeId = int.parse('${json[RefuelFields.fuelTypeId]}');
    firebaseId = json[RefuelFields.firebaseId];
    deleted = json[RefuelFields.deleted] == 1;
  }

  Map<String, dynamic> toJson({bool sync = false}) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[RefuelFields.date] = "${this.date}";
    data[RefuelFields.odometer] = this.odometer ?? "";
    data[RefuelFields.price] = this.price ?? 0.0;
    data[RefuelFields.totalCost] = this.totalCost ?? 0.0;
    data[RefuelFields.litres] = this.litres ?? 0.0;
    data[RefuelFields.vehicleId] = this.vehicleId ?? 0;
    data[RefuelFields.fuelTypeId] = this.fuelTypeId ?? 0;
    if (!sync) {
      data[RefuelFields.firebaseId] = this.firebaseId ?? "";
    }
    data[RefuelFields.deleted] = this.deleted ? 1 : 0;
    return data;
  }
}
