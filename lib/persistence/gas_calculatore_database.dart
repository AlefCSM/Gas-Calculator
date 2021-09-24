import 'package:gas_calculator/models/fuel_type_model.dart';
import 'package:gas_calculator/models/refuel_model.dart';
import 'package:gas_calculator/models/vehicle_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GasCalculatorDatabase {
  static final GasCalculatorDatabase instance = GasCalculatorDatabase._init();

  static Database? _database;

  GasCalculatorDatabase._init();

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;

    _database = await initDB('gasCalculator.db');

    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 1, onCreate: createDB, onUpgrade: upgradeDB);
  }

  Future createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final textTypeNotNull = 'TEXT NOT NULL';
    final datetimeTypeNotNull = 'DATETIME NOT NULL';
    final integerType = 'INTEGER';
    final integerTypeNotNull = 'INTEGER NOT NULL';
    final numberType = 'NUMBER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableFuelTypes (
      ${FuelTypeFields.id} $idType,
      ${FuelTypeFields.name} $textTypeNotNull
    ); ''');
    await db.execute('''    
    CREATE TABLE $tableVehicles (
      ${VehicleFields.id} $idType,
      ${VehicleFields.firebaseId} $textType,
      ${VehicleFields.name} $textTypeNotNull,
      ${VehicleFields.fuelCapacity} $numberType,
      ${VehicleFields.fuelTypeId} $integerTypeNotNull,
      ${VehicleFields.selected} $integerTypeNotNull,
      ${VehicleFields.deleted} $integerTypeNotNull
    ); ''');
    await db.execute('''    
    CREATE TABLE $tableRefuels (
      ${RefuelFields.id} $idType,
      ${RefuelFields.date} $datetimeTypeNotNull,
      ${RefuelFields.odometer} $numberType,
      ${RefuelFields.price} $numberType,
      ${RefuelFields.totalCost} $numberType,
      ${RefuelFields.litres} $numberType,
      ${RefuelFields.vehicleId} $integerType,
      ${RefuelFields.fuelTypeId} $integerType,
      ${RefuelFields.firebaseId} $textType,
      ${RefuelFields.deleted} $integerTypeNotNull,
      FOREIGN KEY (${RefuelFields.vehicleId}) REFERENCES $tableVehicles(${VehicleFields.id}),
      FOREIGN KEY (${RefuelFields.fuelTypeId}) REFERENCES $tableFuelTypes(${FuelTypeFields.id})
    ); ''');

    await db.execute('''    
    INSERT INTO $tableFuelTypes (${FuelTypeFields.name}) values ('Ethanol');
    ''');
    await db.execute('''
    INSERT INTO $tableFuelTypes (${FuelTypeFields.name}) values ('Diesel');
    ''');
    await db.execute('''
    INSERT INTO $tableFuelTypes (${FuelTypeFields.name}) values ('Gasoline');

 ''');
  }

  Future upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (newVersion == 2) {}
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
