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
  ObservableList<Vehicle> vehiclesList = ObservableList.of([]);

  @action
  setCurrentVehicle(Vehicle value) => currentVehicle = value;

  @action
  setSelectedVehicle(Vehicle value) => selectedVehicle = value;

  @action
  setVehiclesList(List<Vehicle> value) =>
      vehiclesList = ObservableList.of(value);

  @computed
  get hasVehicleSelected => selectedVehicle.id>0;

  Future<Vehicle> saveVehicle() async {
    if (vehiclesList.length == 0) {
      currentVehicle.selected = true;
    }

  return await vehiclePersistence.create(currentVehicle);
  }

  getVehicles() async =>
      setVehiclesList(await vehiclePersistence.getVehicles());

  getSelectedVehicle() async =>
      setSelectedVehicle(await vehiclePersistence.getSelectedVehicle());
}
