import 'package:gas_calculator/models/refuel_model.dart';
import 'gas_calculatore_database.dart';

class RefuelPersistence {
  Future<Refuel> create(Refuel refuel) async {
    final db = await GasCalculatorDatabase.instance.database;

    final id = await db.insert(tableRefuels, refuel.toJson());

    //await db.close();
    return refuel.copy(id: id);
  }

  Future<Refuel> update(Refuel refuel) async {
    final db = await GasCalculatorDatabase.instance.database;

    final id = await db.update(tableRefuels, refuel.toJson(),
        where: '${RefuelFields.id} = ?', whereArgs: [refuel.id]);

    //await db.close();
    return refuel.copy(id: id);
  }

  Future<List<Refuel>> getRefuels(
      {required int vehicleId,
      String firebaseId = "",
      bool withoutFirebaseId = false,
      bool withFirebaseId = false,
      bool deleted = false,
      bool filterDeleted = true}) async {
    final db = await GasCalculatorDatabase.instance.database;
    List<Map<String, Object?>> queryResult = [];

    String where = "1 = 1";
    List whereArgs = [];

    if (filterDeleted) {
      where +=
          ' AND ${RefuelFields.vehicleId} = ? AND ${RefuelFields.deleted} = ?';
      whereArgs = [vehicleId];
      if (deleted) {
        whereArgs.add(1);
      } else {
        whereArgs.add(0);
      }
    }

    if (firebaseId.isNotEmpty) {
      where += " AND ${RefuelFields.firebaseId} = ?";
      whereArgs.add(firebaseId);
    } else if (withoutFirebaseId) {
      where += " AND ifnull(${RefuelFields.firebaseId}, '') = ''";
    } else if (withFirebaseId) {
      where += " AND ifnull(${RefuelFields.firebaseId}, '') != ''";
    }

    queryResult = await db.query(tableRefuels,
        where: where,
        whereArgs: whereArgs,
        orderBy: "${RefuelFields.date},${RefuelFields.odometer}");

    //await db.close();

    if (queryResult.isNotEmpty) {
      return queryResult
          .map((Map<String, dynamic> json) => Refuel.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }

  Future<Refuel> getPreviousRefuel(
      {required int vehicleId, double? odometer}) async {
    final db = await GasCalculatorDatabase.instance.database;

    String where =
        '${RefuelFields.vehicleId} = ? AND ${RefuelFields.deleted} = ?';
    List whereArgsList = [vehicleId, 0];

    if (odometer != null) {
      where += ' AND ${RefuelFields.odometer} < ?';
      whereArgsList.add(odometer);
    }

    final queryResult = await db.query(tableRefuels,
        where: where,
        orderBy: '${RefuelFields.odometer} DESC',
        whereArgs: whereArgsList);

    //await db.close();
    if (queryResult.isNotEmpty) {
      return Refuel.fromJson(queryResult.first);
    } else {
      return Refuel();
    }
  }

  Future<Refuel?> getRefuelById(int id) async {
    final db = await GasCalculatorDatabase.instance.database;

    final queryResult = await db.query(tableRefuels,
        where: '${RefuelFields.id} = ? AND ${RefuelFields.deleted} = ?',
        whereArgs: [id, 0]);

    //await db.close();
    if (queryResult.isNotEmpty) {
      return Refuel.fromJson(queryResult.first);
    } else {
      return null;
    }
  }

  Future<bool> delete(Refuel refuel) async {
    final db = await GasCalculatorDatabase.instance.database;
    refuel.deleted = true;
    final deletedRows = await db.update(tableRefuels, refuel.toJson(),
        where: '${RefuelFields.id} = ?', whereArgs: [refuel.id]);

    //await db.close();
    return deletedRows > 0;
  }

  Future<bool> deleteRefuelsFromVehicle(int vehicleId) async {
    final db = await GasCalculatorDatabase.instance.database;

    Map<String, dynamic> values = Map();

    values["${RefuelFields.deleted}"] = 1;

    final deletedRows = await db.update(tableRefuels, values,
        where: "${RefuelFields.vehicleId} = ?", whereArgs: [vehicleId]);

    //await db.close();

    return deletedRows > 0;
  }

  Future<bool> deleteRefuel(int refuelId) async {
    final db = await GasCalculatorDatabase.instance.database;

    Map<String, dynamic> values = Map();

    values["${RefuelFields.deleted}"] = 1;

    final deletedRows = await db.update(tableRefuels, values,
        where: "${RefuelFields.id} = ?", whereArgs: [refuelId]);

    //await db.close();

    return deletedRows > 0;
  }

  Future<int> cleanDeletedRefuels() async {
    final db = await GasCalculatorDatabase.instance.database;

    final deletedRows = await db.delete(tableRefuels,
        where: '${RefuelFields.deleted} = ?', whereArgs: [1]);

    //await db.close();
    return deletedRows;
  }
}
