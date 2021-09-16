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
  static final String consumption = 'consumption';
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
          bool? deleted}) =>
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
      );

  static Refuel fromJson(Map<String, dynamic> json, {bool firebase = false}) =>
      Refuel(
          id: firebase ? null : json[RefuelFields.id] as int,
          date: json[RefuelFields.date],
          odometer: double.parse('${json[RefuelFields.odometer]}'),
          price: double.parse('${json[RefuelFields.price]}'),
          totalCost: double.parse('${json[RefuelFields.totalCost]}'),
          litres: double.parse('${json[RefuelFields.litres]}'),
          vehicleId: json[RefuelFields.vehicleId] as int,
          fuelTypeId: json[RefuelFields.fuelTypeId] as int,
          firebaseId: json[RefuelFields.firebaseId],
          deleted: json[RefuelFields.deleted] == 1,
          consuption:
              firebase ? 0.0 : double.parse('${json[RefuelFields.consumption]}'),);

  Map<String, dynamic> toJson({bool sync = false}) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[RefuelFields.date] = "${this.date}";
    data[RefuelFields.odometer] = this.odometer;
    data[RefuelFields.price] = this.price;
    data[RefuelFields.totalCost] = this.totalCost;
    data[RefuelFields.litres] = this.litres;
    data[RefuelFields.vehicleId] = this.vehicleId;
    data[RefuelFields.fuelTypeId] = this.fuelTypeId;
    if (!sync) {
      data[RefuelFields.firebaseId] = this.firebaseId;
      data[RefuelFields.consumption] = this.consuption;
    }
    data[RefuelFields.deleted] = this.deleted ? 1 : 0;
    return data;
  }
}
