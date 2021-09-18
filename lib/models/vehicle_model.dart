final tableVehicles = 'vehicles';

class VehicleFields {
  static final values = [id, name, firebaseId, fuelCapacity, selected, deleted];

  static final String id = '_id';
  static final String name = 'name';
  static final String firebaseId = 'firebaseId';
  static final String fuelCapacity = 'fuelCapacity';
  static final String fuelTypeId = 'fuelTypeId';
  static final String selected = 'selected';
  static final String deleted = 'deleted';
}

class Vehicle {
  int? id;
  String name;
  String firebaseId;
  double fuelCapacity;
  int fuelTypeId;
  bool selected;
  bool deleted;

  @override
  bool operator ==(Object other) =>
      other is Vehicle && other.name == name && other.id == id;

  @override
  int get hashCode => name.hashCode;

  Vehicle({
    this.id,
    this.name = "",
    this.firebaseId = "",
    this.fuelCapacity = 0.0,
    this.selected = false,
    this.deleted = false,
    this.fuelTypeId = 1,
  });

  Vehicle copy({
    int? id,
    String? name,
    String? firebaseId,
    double? fuelCapacity,
    int? fuelTypeId,
    bool? selected,
    bool? deleted,
  }) =>
      Vehicle(
        id: id ?? this.id,
        name: name ?? this.name,
        firebaseId: firebaseId ?? this.firebaseId,
        fuelCapacity: fuelCapacity ?? this.fuelCapacity,
        fuelTypeId: fuelTypeId ?? this.fuelTypeId,
        selected: selected ?? this.selected,
        deleted: deleted ?? this.deleted,
      );

  static Vehicle fromJson(Map<String, dynamic> json, {bool firebase = false}) =>
      Vehicle(
          id: firebase ? null : json[VehicleFields.id] as int?,
          name: json[VehicleFields.name],
          firebaseId: json[VehicleFields.firebaseId]??"",
          fuelCapacity: double.parse('${json[VehicleFields.fuelCapacity]}'),
          fuelTypeId: int.parse('${json[VehicleFields.fuelTypeId]}'),
          selected: firebase ? false : json[VehicleFields.selected] == 1,
          deleted: json[VehicleFields.deleted] == 1);

  Map<String, dynamic> toJson({bool firebase = false}) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[VehicleFields.name] = this.name;
    data[VehicleFields.fuelCapacity] = this.fuelCapacity;
    data[VehicleFields.fuelTypeId] = this.fuelTypeId;
    data[VehicleFields.deleted] = this.deleted ? 1 : 0;
    if (!firebase) {
      data[VehicleFields.firebaseId] = this.firebaseId;
      data[VehicleFields.selected] = this.selected ? 1 : 0;
    }
    return data;
  }
}
