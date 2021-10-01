import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_calculator/models/fuel_type_model.dart';
import 'package:gas_calculator/models/refuel_model.dart';
import 'package:gas_calculator/persistence/fuel_type_persistence.dart';
import 'package:gas_calculator/persistence/refuel_persistence.dart';
import 'package:gas_calculator/repositories/vehicle_repository.dart';
import 'package:mobx/mobx.dart';

part 'refuel_store.g.dart';

class RefuelStore = _RefuelStore with _$RefuelStore;

enum RefuelInput { PRICE, TOTAL, LITRES }

enum FuelTypes { ETHANOL, DIESEL, GASOLINE }

extension FuelTypeExtension on FuelTypes {
  int get id {
    switch (this) {
      case FuelTypes.ETHANOL:
        return 1;
      case FuelTypes.DIESEL:
        return 2;
      case FuelTypes.GASOLINE:
        return 3;
      default:
        return 0;
    }
  }

  String get text {
    switch (this) {
      case FuelTypes.ETHANOL:
        return "Ethanol";
      case FuelTypes.DIESEL:
        return "Diesel";
      case FuelTypes.GASOLINE:
        return "Gasoline";
      default:
        return "";
    }
  }
}

abstract class _RefuelStore with Store {
  final refuelPersistence = RefuelPersistence();
  final fuelTypePersistence = FuelTypePersistence();
  final vehicleRepository = VehicleRepository();

  List<FuelType> fuelTypeList = [];
  List<DropdownMenuItem<FuelType>> fuelTypeDrodownList = [];

  String date = "";
  String time = "";

  Refuel lastRefuel = Refuel();

  @observable
  TextEditingController priceInputController = TextEditingController();

  @observable
  TextEditingController totalInputController = TextEditingController();

  @observable
  TextEditingController litresInputController = TextEditingController();

  @observable
  List<Refuel> refuelList = [];

  @observable
  Refuel currentRefuel = Refuel();

  @observable
  FuelType currentFuelType = FuelType();

  @action
  setPriceInput(String value) => priceInputController.text = value;

  @action
  setTotalInput(String value) => totalInputController.text = value;

  @action
  setLitresInput(String value) => litresInputController.text = value;

  @action
  setCurrentRefuel(Refuel refuel) => currentRefuel = refuel;

  @action
  setRefuelList(List<Refuel> list) => refuelList = list;

  @action
  setCurrentFuelType(FuelType value) => currentFuelType = value;

  @computed
  bool get fillPrice =>
      totalInputController.text.isNotEmpty &&
      litresInputController.text.isNotEmpty;

  @computed
  bool get fillTotal =>
      priceInputController.text.isNotEmpty &&
      litresInputController.text.isNotEmpty;

  @computed
  bool get fillLitres =>
      priceInputController.text.isNotEmpty &&
      totalInputController.text.isNotEmpty;

  getFuelTypes() async =>
      fuelTypeList = await fuelTypePersistence.getFuelTypes();

  getLastRefuel({required int vehicleId, double? odometer}) async {
    lastRefuel = await refuelPersistence.getPreviousRefuel(
        vehicleId: vehicleId, odometer: odometer);
  }

  getRefuels({required int vehicleId}) async {
    if (vehicleId > 0) {
      var refuels = await refuelPersistence.getRefuels(vehicleId: vehicleId);

      for (int i = 0; i < refuels.length; i++) {
        refuels[i].consuption = getConsumption(i, refuels);
      }

      setRefuelList(refuels);
    }
  }

  void fillLastInput() {
    double price;
    double total;
    double litres;

    if (fillLitres) {
      price = double.parse(priceInputController.text);
      total = double.parse(totalInputController.text);
      litres = total / price;
      setLitresInput(litres.toStringAsFixed(3));
    }

    if (fillTotal) {
      price = double.parse(priceInputController.text);
      litres = double.parse(litresInputController.text);
      total = price * litres;
      setTotalInput(total.toStringAsFixed(3));
    }

    if (fillPrice) {
      total = double.parse(totalInputController.text);
      litres = double.parse(litresInputController.text);
      price = total / litres;
      setPriceInput(price.toStringAsFixed(3));
    }
  }

  void buildFuelTypeList() {
    for (final fuelType in fuelTypeList) {
      fuelTypeDrodownList
          .add(DropdownMenuItem(value: fuelType, child: Text(fuelType.name)));
    }
  }

  Future<Refuel> saveRefuel() {
    if (currentRefuel.id != null) {
      return refuelPersistence.update(currentRefuel);
    } else {
      return refuelPersistence.create(currentRefuel);
    }
  }

  Future<bool> deleteRefuelsFromVehicle(int vehicleId) async {
    var result = await refuelPersistence.deleteRefuelsFromVehicle(vehicleId);

    return result;
  }

  Future<bool> deleteRefuel(int refuelId) async {
    var result = await refuelPersistence.deleteRefuel(refuelId);

    return result;
  }

  double getConsumption(int index, List refuels) {
    if ((index + 1) == refuels.length) return 0.0;

    Refuel currentRefuel = refuels[index + 1];
    Refuel lastRefuel = refuels[index];

    var kilometers = currentRefuel.odometer - lastRefuel.odometer;

    return kilometers / currentRefuel.litres;
  }
}
