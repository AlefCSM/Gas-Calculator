import 'package:gas_calculator/models/vehicle_model.dart';
import 'gas_calculatore_database.dart';

class VehiclePersistence {
  Future<Vehicle> create(Vehicle vehicle) async {
    final db = await GasCalculatorDatabase.instance.database;

    final id = await db.insert(tableVehicles, vehicle.toJson());

    //await db.close();
    return vehicle.copy(id: id);
  }

  Future<int> update(Vehicle vehicle) async {
    final db = await GasCalculatorDatabase.instance.database;

    final id = await db.update(tableVehicles, vehicle.toJson(),
        where: "${VehicleFields.id} = ?", whereArgs: [vehicle.id]);

    //await db.close();
    return id;
  }

  Future<List<Vehicle>> getVehicles(
      {String firebaseId = "",
      bool withoutFirebaseId = false,
      bool withFirebaseId = false,
      bool filterDeleted = true,
      bool deleted = false}) async {
    final db = await GasCalculatorDatabase.instance.database;

    String where = "1=1 ";
    List whereArgs = [];

    if (filterDeleted) {
      where += "AND ${VehicleFields.deleted} = ?";
      if (deleted) {
        whereArgs.add(1);
      } else {
        whereArgs.add(0);
      }
    }

    if (firebaseId.isNotEmpty) {
      where += " AND ${VehicleFields.firebaseId} = ?";
      whereArgs.add(firebaseId);
    } else if (withoutFirebaseId) {
      where += " AND ifnull(${VehicleFields.firebaseId}, '') = ''";
    } else if (withFirebaseId) {
      where += " AND ifnull(${VehicleFields.firebaseId}, '') != ''";
    }

    final queryResult =
        await db.query(tableVehicles, where: where, whereArgs: whereArgs);

    //await db.close();
    if (queryResult.isNotEmpty) {
      return queryResult
          .map((Map<String, dynamic> json) => Vehicle.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }

  Future<Vehicle> getSelectedVehicle() async {
    final db = await GasCalculatorDatabase.instance.database;

    final queryResult = await db.query(tableVehicles,
        where: '${VehicleFields.selected} = ? AND ${VehicleFields.deleted} = ?',
        whereArgs: [1, 0]);

    //await db.close();
    if (queryResult.isNotEmpty) {
      return Vehicle.fromJson(queryResult.first);
    } else {
      return Vehicle();
    }
  }

  Future<void> updateSelectedVehicle(int vehicleId) async {
    final db = await GasCalculatorDatabase.instance.database;
    Map<String, dynamic> values = Map();

    values["${VehicleFields.selected}"] = 0;
    await db.update(tableVehicles, values,
        where: "${VehicleFields.id} != ?", whereArgs: [vehicleId]);

    values["${VehicleFields.selected}"] = 1;
    await db.update(tableVehicles, values,
        where: "${VehicleFields.id} = ?", whereArgs: [vehicleId]);

    //await db.close();
    // return id;
  }

  Future<int> deleteVehicle({required Vehicle vehicle}) async {
    final db = await GasCalculatorDatabase.instance.database;

    vehicle.deleted = true;
    final deletedRows = await db.update(tableVehicles, vehicle.toJson(),
        where: '${VehicleFields.deleted} = ? AND ${VehicleFields.id} = ?',
        whereArgs: [0, vehicle.id]);

    //await db.close();
    return deletedRows;
  }

  Future<int> cleanDeletedVehicles() async {
    final db = await GasCalculatorDatabase.instance.database;

    final deletedRows = await db.delete(tableVehicles,
        where: '${VehicleFields.deleted} = ?', whereArgs: [1]);

    //await db.close();
    return deletedRows;
  }
}
