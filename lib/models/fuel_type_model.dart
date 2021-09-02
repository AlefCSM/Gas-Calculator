
final tableFuelTypes = 'fuelTypes';

class FuelTypeFields {
  static final String id = '_id';
  static final String name = 'name';
}

class FuelType {
  int id;
  String name;

  FuelType({
    this.id = 0,
    this.name = "",
  });

  FuelType.fromJson(Map<String, dynamic> json) {
    id = int.parse('${json[FuelTypeFields.id]}');
    name = json[FuelTypeFields.name];
  }
}
