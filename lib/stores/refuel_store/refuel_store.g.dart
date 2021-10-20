// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refuel_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RefuelStore on _RefuelStore, Store {
  Computed<bool>? _$fillPriceComputed;

  @override
  bool get fillPrice => (_$fillPriceComputed ??=
          Computed<bool>(() => super.fillPrice, name: '_RefuelStore.fillPrice'))
      .value;
  Computed<bool>? _$fillTotalComputed;

  @override
  bool get fillTotal => (_$fillTotalComputed ??=
          Computed<bool>(() => super.fillTotal, name: '_RefuelStore.fillTotal'))
      .value;
  Computed<bool>? _$fillLitresComputed;

  @override
  bool get fillLitres =>
      (_$fillLitresComputed ??= Computed<bool>(() => super.fillLitres,
              name: '_RefuelStore.fillLitres'))
          .value;

  final _$priceInputControllerAtom =
      Atom(name: '_RefuelStore.priceInputController');

  @override
  TextEditingController get priceInputController {
    _$priceInputControllerAtom.reportRead();
    return super.priceInputController;
  }

  @override
  set priceInputController(TextEditingController value) {
    _$priceInputControllerAtom.reportWrite(value, super.priceInputController,
        () {
      super.priceInputController = value;
    });
  }

  final _$totalInputControllerAtom =
      Atom(name: '_RefuelStore.totalInputController');

  @override
  TextEditingController get totalInputController {
    _$totalInputControllerAtom.reportRead();
    return super.totalInputController;
  }

  @override
  set totalInputController(TextEditingController value) {
    _$totalInputControllerAtom.reportWrite(value, super.totalInputController,
        () {
      super.totalInputController = value;
    });
  }

  final _$litresInputControllerAtom =
      Atom(name: '_RefuelStore.litresInputController');

  @override
  TextEditingController get litresInputController {
    _$litresInputControllerAtom.reportRead();
    return super.litresInputController;
  }

  @override
  set litresInputController(TextEditingController value) {
    _$litresInputControllerAtom.reportWrite(value, super.litresInputController,
        () {
      super.litresInputController = value;
    });
  }

  final _$refuelListAtom = Atom(name: '_RefuelStore.refuelList');

  @override
  List<Refuel> get refuelList {
    _$refuelListAtom.reportRead();
    return super.refuelList;
  }

  @override
  set refuelList(List<Refuel> value) {
    _$refuelListAtom.reportWrite(value, super.refuelList, () {
      super.refuelList = value;
    });
  }

  final _$currentRefuelAtom = Atom(name: '_RefuelStore.currentRefuel');

  @override
  Refuel get currentRefuel {
    _$currentRefuelAtom.reportRead();
    return super.currentRefuel;
  }

  @override
  set currentRefuel(Refuel value) {
    _$currentRefuelAtom.reportWrite(value, super.currentRefuel, () {
      super.currentRefuel = value;
    });
  }

  final _$currentFuelTypeAtom = Atom(name: '_RefuelStore.currentFuelType');

  @override
  FuelType get currentFuelType {
    _$currentFuelTypeAtom.reportRead();
    return super.currentFuelType;
  }

  @override
  set currentFuelType(FuelType value) {
    _$currentFuelTypeAtom.reportWrite(value, super.currentFuelType, () {
      super.currentFuelType = value;
    });
  }

  final _$_RefuelStoreActionController = ActionController(name: '_RefuelStore');

  @override
  dynamic setPriceInput(String value) {
    final _$actionInfo = _$_RefuelStoreActionController.startAction(
        name: '_RefuelStore.setPriceInput');
    try {
      return super.setPriceInput(value);
    } finally {
      _$_RefuelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTotalInput(String value) {
    final _$actionInfo = _$_RefuelStoreActionController.startAction(
        name: '_RefuelStore.setTotalInput');
    try {
      return super.setTotalInput(value);
    } finally {
      _$_RefuelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLitresInput(String value) {
    final _$actionInfo = _$_RefuelStoreActionController.startAction(
        name: '_RefuelStore.setLitresInput');
    try {
      return super.setLitresInput(value);
    } finally {
      _$_RefuelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentRefuel(Refuel refuel) {
    final _$actionInfo = _$_RefuelStoreActionController.startAction(
        name: '_RefuelStore.setCurrentRefuel');
    try {
      return super.setCurrentRefuel(refuel);
    } finally {
      _$_RefuelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRefuelList(List<Refuel> list) {
    final _$actionInfo = _$_RefuelStoreActionController.startAction(
        name: '_RefuelStore.setRefuelList');
    try {
      return super.setRefuelList(list);
    } finally {
      _$_RefuelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentFuelType(FuelType value) {
    final _$actionInfo = _$_RefuelStoreActionController.startAction(
        name: '_RefuelStore.setCurrentFuelType');
    try {
      return super.setCurrentFuelType(value);
    } finally {
      _$_RefuelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
priceInputController: ${priceInputController},
totalInputController: ${totalInputController},
litresInputController: ${litresInputController},
refuelList: ${refuelList},
currentRefuel: ${currentRefuel},
currentFuelType: ${currentFuelType},
fillPrice: ${fillPrice},
fillTotal: ${fillTotal},
fillLitres: ${fillLitres}
    ''';
  }
}
