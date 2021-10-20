import 'package:flutter/material.dart';
import 'package:gas_calculator/models/vehicle_model.dart';
import 'package:gas_calculator/persistence/vehicle_persistence.dart';
import 'package:mobx/mobx.dart';

part 'vehicle_store.g.dart';

class VehicleStore = _VehicleStore with _$VehicleStore;

abstract class _VehicleStore with Store {
  final vehiclePersistence = VehiclePersistence();

  @observable
  Vehicle currentVehicle = Vehicle();

  @observable
  Vehicle selectedVehicle = Vehicle();

  @observable
  bool loading = false;

  @observable
  ObservableList<Vehicle> vehiclesList = ObservableList.of([]);

  @observable
  ObservableList<DropdownMenuItem<Vehicle>> vehiclesDrodownList =
      ObservableList.of([]);

  @action
  setCurrentVehicle(Vehicle value) => currentVehicle = value;

  @action
  setSelectedVehicle(Vehicle value) => selectedVehicle = value;

  @action
  setLoading(bool value) => loading = value;

  @action
  setVehiclesList(List<Vehicle> value) =>
      vehiclesList = ObservableList.of(value);

  @computed
  get hasVehicleSelected => selectedVehicle.id !=null;

  Future<bool> saveVehicle() async {
    if (vehiclesList.length == 0) {
      currentVehicle.selected = true;
    }

    var result = await vehiclePersistence.create(currentVehicle);
    return result.id != null;
  }

  Future<bool> editVehicle() async {
    var result = await vehiclePersistence.update(currentVehicle);

    return result > 0;
  }

  Future<bool> deleteVehicle() async {
    var result =
        await vehiclePersistence.deleteVehicle(vehicle: currentVehicle);

    return result > 0;
  }

  getVehicles() async {
    setLoading(true);
    setVehiclesList(await vehiclePersistence.getVehicles());
    setLoading(false);
  }

  getSelectedVehicle() async =>
      setSelectedVehicle(await vehiclePersistence.getSelectedVehicle());

  void buildDropdownList() {
    vehiclesDrodownList.clear();
    for (final vehicle in vehiclesList) {
      vehiclesDrodownList
          .add(DropdownMenuItem(value: vehicle, child: Text(vehicle.name)));
    }
  }

  Future<void> updateSelectedVehicle(int vehicleId) async {
    await vehiclePersistence.updateSelectedVehicle(vehicleId);
    await getSelectedVehicle();
  }
}
