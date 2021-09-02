// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VehicleStore on _VehicleStore, Store {
  Computed<dynamic> _$hasVehicleSelectedComputed;

  @override
  dynamic get hasVehicleSelected => (_$hasVehicleSelectedComputed ??=
          Computed<dynamic>(() => super.hasVehicleSelected,
              name: '_VehicleStore.hasVehicleSelected'))
      .value;

  final _$currentVehicleAtom = Atom(name: '_VehicleStore.currentVehicle');

  @override
  Vehicle get currentVehicle {
    _$currentVehicleAtom.reportRead();
    return super.currentVehicle;
  }

  @override
  set currentVehicle(Vehicle value) {
    _$currentVehicleAtom.reportWrite(value, super.currentVehicle, () {
      super.currentVehicle = value;
    });
  }

  final _$selectedVehicleAtom = Atom(name: '_VehicleStore.selectedVehicle');

  @override
  Vehicle get selectedVehicle {
    _$selectedVehicleAtom.reportRead();
    return super.selectedVehicle;
  }

  @override
  set selectedVehicle(Vehicle value) {
    _$selectedVehicleAtom.reportWrite(value, super.selectedVehicle, () {
      super.selectedVehicle = value;
    });
  }

  final _$vehiclesListAtom = Atom(name: '_VehicleStore.vehiclesList');

  @override
  ObservableList<Vehicle> get vehiclesList {
    _$vehiclesListAtom.reportRead();
    return super.vehiclesList;
  }

  @override
  set vehiclesList(ObservableList<Vehicle> value) {
    _$vehiclesListAtom.reportWrite(value, super.vehiclesList, () {
      super.vehiclesList = value;
    });
  }

  final _$_VehicleStoreActionController =
      ActionController(name: '_VehicleStore');

  @override
  dynamic setCurrentVehicle(Vehicle value) {
    final _$actionInfo = _$_VehicleStoreActionController.startAction(
        name: '_VehicleStore.setCurrentVehicle');
    try {
      return super.setCurrentVehicle(value);
    } finally {
      _$_VehicleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedVehicle(Vehicle value) {
    final _$actionInfo = _$_VehicleStoreActionController.startAction(
        name: '_VehicleStore.setSelectedVehicle');
    try {
      return super.setSelectedVehicle(value);
    } finally {
      _$_VehicleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setVehiclesList(List<Vehicle> value) {
    final _$actionInfo = _$_VehicleStoreActionController.startAction(
        name: '_VehicleStore.setVehiclesList');
    try {
      return super.setVehiclesList(value);
    } finally {
      _$_VehicleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentVehicle: ${currentVehicle},
selectedVehicle: ${selectedVehicle},
vehiclesList: ${vehiclesList},
hasVehicleSelected: ${hasVehicleSelected}
    ''';
  }
}
