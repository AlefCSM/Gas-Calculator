import 'package:gas_calculator/models/fuel_type_model.dart';
import 'gas_calculatore_database.dart';

class FuelTypePersistence {
  Future<List<FuelType>> getFuelTypes() async {
    final db = await GasCalculatorDatabase.instance.database;
    final queryResult = await db.query(tableFuelTypes);

    if (queryResult.isNotEmpty) {
      return queryResult
          .map((Map<String, dynamic> json) => FuelType.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }

  Future<FuelType?> getFuelTypeById(int id) async{
    final db = await GasCalculatorDatabase.instance.database;
    final queryResult = await db.query(tableFuelTypes);

    if (queryResult.isNotEmpty) {
      return  FuelType.fromJson(queryResult.first);
    } else {
      return null;
    }
  }
}
