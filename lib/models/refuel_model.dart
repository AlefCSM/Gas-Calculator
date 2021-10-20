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
  static final String isFillingUp = 'isFillingUp';
}

class Refuel {
  late int? id;
  late String date;
  late double odometer;
  late double price;
  late double totalCost;
  late double litres;
  late int vehicleId;
  late int fuelTypeId;
  late String firebaseId;
  late bool isFillingUp;
  late bool deleted;
  late double consuption;

  Refuel({
    this.id,
    this.date = "",
    this.odometer = 0.0,
    this.price = 0.0,
    this.totalCost = 0.0,
    this.litres = 0.0,
    this.vehicleId = 0,
    this.fuelTypeId = 0,
    this.firebaseId = "",
    this.isFillingUp = true,
    this.deleted = false,
    this.consuption = 0.0,
  });

  Refuel copy(
          {int? id,
          String? date,
          double? odometer,
          double? price,
          double? totalCost,
          double? litres,
          int? vehicleId,
          String? firebaseId,
          bool? deleted,
          bool? isFillingUp}) =>
      Refuel(
        id: id ?? this.id,
        date: date ?? this.date,
        odometer: odometer ?? this.odometer,
        price: price ?? this.price,
        totalCost: totalCost ?? this.totalCost,
        litres: litres ?? this.litres,
        vehicleId: vehicleId ?? this.vehicleId,
        fuelTypeId: fuelTypeId,
        firebaseId: firebaseId ?? this.firebaseId,
        deleted: deleted ?? this.deleted,
        isFillingUp: isFillingUp ?? this.isFillingUp,
      );

  static Refuel fromJson(Map<String, dynamic> json, {bool firebase = false}) =>
      Refuel(
        id: firebase ? null : json[RefuelFields.id] as int,
        date: json[RefuelFields.date],
        odometer: double.parse('${json[RefuelFields.odometer]}'),
        price: double.parse('${json[RefuelFields.price]}'),
        totalCost: double.parse('${json[RefuelFields.totalCost]}'),
        litres: double.parse('${json[RefuelFields.litres]}'),
        vehicleId: firebase ? 0 : json[RefuelFields.vehicleId] as int,
        fuelTypeId: json[RefuelFields.fuelTypeId] as int,
        firebaseId: json[RefuelFields.firebaseId] ?? "",
        deleted: json[RefuelFields.deleted] == 1,
        isFillingUp: json[RefuelFields.isFillingUp] == 1,
      );

  Map<String, dynamic> toJson({bool firebase = false}) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[RefuelFields.date] = "${this.date}";
    data[RefuelFields.odometer] = this.odometer;
    data[RefuelFields.price] = this.price;
    data[RefuelFields.totalCost] = this.totalCost;
    data[RefuelFields.litres] = this.litres;
    data[RefuelFields.fuelTypeId] = this.fuelTypeId;
    if (!firebase) {
      data[RefuelFields.firebaseId] = this.firebaseId;
      data[RefuelFields.vehicleId] = this.vehicleId;
    }
    data[RefuelFields.deleted] = this.deleted ? 1 : 0;
    data[RefuelFields.isFillingUp] = this.isFillingUp ? 1 : 0;
    return data;
  }
}
