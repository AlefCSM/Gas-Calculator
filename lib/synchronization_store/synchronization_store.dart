import 'package:gas_calculator/models/refuel_model.dart';
import 'package:gas_calculator/models/vehicle_model.dart';
import 'package:gas_calculator/persistence/refuel_persistence.dart';
import 'package:gas_calculator/persistence/vehicle_persistence.dart';
import 'package:gas_calculator/repositories/refuel_repository.dart';
import 'package:gas_calculator/repositories/vehicle_repository.dart';
import 'package:gas_calculator/stores/login_store/login_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'synchronization_store.g.dart';

class SynchronizationStore = _SynchronizationStore with _$SynchronizationStore;

abstract class _SynchronizationStore with Store {
  final vehiclePersistence = VehiclePersistence();
  final vehicleRepository = VehicleRepository();
  final refuelPersistence = RefuelPersistence();
  final refuelRepository = RefuelRepository();
  final LoginStore loginStore = GetIt.I<LoginStore>();

  List<Vehicle> firebaseVehicleList = [];
  List<Vehicle> databaseVehicleList = [];
  List<Refuel> firebaseRefuelList = [];
  List<Refuel> databaseRefuelList = [];

  @observable
  bool synchronizing = false;

  @action
  setSynchronizing(bool value) => synchronizing = value;

  Future<void> sync() async {
    if (!synchronizing) {
      setSynchronizing(true);
      String userId = loginStore.currentUser!.uid;

      await syncVehicles(userId);
      await syncRefuels(userId);

      await refuelPersistence.cleanDeletedRefuels();
      await vehiclePersistence.cleanDeletedVehicles();
      setSynchronizing(false);
    }
  }

  Future<void> syncVehicles(String userId) async {
    firebaseVehicleList =
        await vehicleRepository.getFirebaseVehicles(userId: userId);

    for (final vehicle in firebaseVehicleList) {
      databaseVehicleList = await vehiclePersistence.getVehicles(
          firebaseId: vehicle.firebaseId, filterDeleted: false);
      if (databaseVehicleList.length < 1) {
        vehiclePersistence.create(vehicle);
      }
    }

    databaseVehicleList =
        await vehiclePersistence.getVehicles(withoutFirebaseId: true);

    for (final vehicle in databaseVehicleList) {
      var id = await vehicleRepository.saveFirebaseVahicle(
          userId: userId, vehicle: vehicle);
      vehicle.firebaseId = id;

      await vehiclePersistence.update(vehicle);
    }

    databaseVehicleList =
        await vehiclePersistence.getVehicles(withFirebaseId: true);

    for (final vehicle in databaseVehicleList) {
      await vehicleRepository.updateFirebaseVahicle(
          userId: userId, vehicle: vehicle);
    }

    databaseVehicleList = await vehiclePersistence.getVehicles(deleted: true);
    for (final vehicle in databaseVehicleList) {
      await refuelPersistence.deleteRefuelsFromVehicle(vehicle.id!);
      await vehicleRepository.deleteFirebaseVehicle(
          userId: userId, vehicle: vehicle);
    }
  }

  Future<void> syncRefuels(String userId) async {
    databaseVehicleList = await vehiclePersistence.getVehicles(filterDeleted: false);

    for (final vehicle in databaseVehicleList) {
      if (vehicle.id != null)
        firebaseRefuelList = await refuelRepository.getFirebaseRefuels(
            userId: userId, vehicle: vehicle);

      for (final refuel in firebaseRefuelList) {
        databaseRefuelList = await refuelPersistence.getRefuels(
            vehicleId: vehicle.id!, firebaseId: refuel.firebaseId);
        if (databaseRefuelList.length < 1) {
          refuelPersistence.create(refuel);
        }
      }

      databaseRefuelList = await refuelPersistence.getRefuels(
          vehicleId: vehicle.id!, withoutFirebaseId: true);

      for (final refuel in databaseRefuelList) {
        var id = await refuelRepository.saveFirebaseRefuel(
            userId: userId,
            vehicleFirebaseId: vehicle.firebaseId,
            refuel: refuel);

        refuel.firebaseId = id;

        await refuelPersistence.update(refuel);
      }

      databaseRefuelList = await refuelPersistence.getRefuels(
          vehicleId: vehicle.id!, withFirebaseId: true);

      for (final refuel in databaseRefuelList) {
        await refuelRepository.updateFirebaseRefuel(
            userId: userId,
            vehicleFirebaseId: vehicle.firebaseId,
            refuel: refuel);
      }

      databaseRefuelList = await refuelPersistence.getRefuels(
          vehicleId: vehicle.id!, deleted: true);

      for (final refuel in databaseRefuelList) {
        await refuelRepository.deleteFirebaseRefuel(
            userId: userId,
            vehicleFirebaseId: vehicle.firebaseId,
            refuel: refuel);
      }
    }
  }
}
