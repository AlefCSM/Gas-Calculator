import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';

final tableFuelTypes = 'fuelTypes';

class FuelTypeFields {
  static final String id = '_id';
  static final String name = 'name';
}

class FuelType {
  int id;
  String name;

  FuelType({
    this.id = 1,
    this.name = "Ethanol",
  });

  static FuelType fromJson(Map<String, dynamic> json) => FuelType(
      id: int.parse('${json[FuelTypeFields.id]}'),
      name: json[FuelTypeFields.name]);

  String nameFromId(int id) {
    if (id == FuelTypes.ETHANOL.id) {
      return FuelTypes.ETHANOL.text;
    }
    if (id == FuelTypes.DIESEL.id) {
      return FuelTypes.DIESEL.text;
    }
    if (id == FuelTypes.GASOLINE.id) {
      return FuelTypes.GASOLINE.text;
    }
    return "";
  }
}
