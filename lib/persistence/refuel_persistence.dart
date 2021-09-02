import 'package:flutter/cupertino.dart';
import 'package:gas_calculator/models/refuel_model.dart';
import 'gas_calculatore_database.dart';

class RefuelPersistence {
  Future<Refuel> create(Refuel refuel) async {
    final db = await GasCalculatorDatabase.instance.database;

    final id = await db.insert(tableRefuels, refuel.toJson());

    await db.close();
    return refuel.copy(id: id);
  }

  Future<Refuel> update(Refuel refuel) async {
    final db = await GasCalculatorDatabase.instance.database;

    final id = await db.update(tableRefuels, refuel.toJson(),
        where: '${RefuelFields.id} = ?', whereArgs: [refuel.id]);

    await db.close();
    return refuel.copy(id: id);
  }

  Future<List<Refuel>> getRefuels(
      {@required int vehicleId,
      String firebaseId = "",
      bool withoutFirebaseId = false,
      bool withFirebaseId = false,
      bool deleted = false}) async {
    final db = await GasCalculatorDatabase.instance.database;

    String where =
        '${RefuelFields.vehicleId} = ? AND ${RefuelFields.deleted} = ?';
    List whereArgs = [vehicleId];
    if (deleted) {
      whereArgs.add(1);
    } else {
      whereArgs.add(0);
    }

    if (firebaseId.isNotEmpty) {
      where += " AND ${RefuelFields.firebaseId} = ?";
      whereArgs.add(firebaseId);
    } else if (withoutFirebaseId) {
      where += " AND ifnull(${RefuelFields.firebaseId}, '') = ''";
    }else if(withFirebaseId){
      where += " AND ifnull(${RefuelFields.firebaseId}, '') != ''";
    }


    final queryResult =
        await db.query(tableRefuels, where: where, whereArgs: whereArgs);

    await db.close();
    if (queryResult.isNotEmpty) {
      return queryResult
          .map((Map<String, dynamic> json) => Refuel.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }

  Future<Refuel> getPreviousRefuel(
      {@required int vehicleId, int refuelId = 0}) async {
    final db = await GasCalculatorDatabase.instance.database;

    String where =
        '${RefuelFields.vehicleId} = ? AND ${RefuelFields.deleted} = ?';
    List whereArgsList = [vehicleId, 0];

    if (refuelId > 0) {
      where = ' AND ${RefuelFields.id} = ?';
      whereArgsList.add(refuelId - 1);
    }

    final queryResult = await db.query(tableRefuels,
        where: where,
        orderBy: '${RefuelFields.date} DESC',
        whereArgs: whereArgsList);

    await db.close();
    if (queryResult.isNotEmpty) {
      return Refuel.fromJson(queryResult.first);
    } else {
      return Refuel();
    }
  }

  Future<Refuel> getRefuelById(int id) async {
    final db = await GasCalculatorDatabase.instance.database;

    final queryResult = await db.query(tableRefuels,
        where: '${RefuelFields.id} = ? AND ${RefuelFields.deleted} = ?',
        whereArgs: [id, 0]);

    await db.close();
    if (queryResult.isNotEmpty) {
      return Refuel.fromJson(queryResult.first);
    } else {
      return null;
    }
  }

  Future<bool> delete(int id) async {
    final db = await GasCalculatorDatabase.instance.database;

    final deletedRows = await db
        .delete(tableRefuels, where: '${RefuelFields.id} = ?', whereArgs: [id]);

    await db.close();
    return deletedRows > 0;
  }

  Future<int> cleanDeletedRefuels() async {
    final db = await GasCalculatorDatabase.instance.database;

    final deletedRows = await db.delete(tableRefuels,
        where: '${RefuelFields.deleted} = ?', whereArgs: [1]);

    await db.close();
    return deletedRows;
  }
}
