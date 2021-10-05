// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportStore on _ReportStore, Store {
  final _$ethanolRefuelsListAtom =
      Atom(name: '_ReportStore.ethanolRefuelsList');

  @override
  List<dynamic> get ethanolRefuelsList {
    _$ethanolRefuelsListAtom.reportRead();
    return super.ethanolRefuelsList;
  }

  @override
  set ethanolRefuelsList(List<dynamic> value) {
    _$ethanolRefuelsListAtom.reportWrite(value, super.ethanolRefuelsList, () {
      super.ethanolRefuelsList = value;
    });
  }

  final _$dieselRefuelsListAtom = Atom(name: '_ReportStore.dieselRefuelsList');

  @override
  List<dynamic> get dieselRefuelsList {
    _$dieselRefuelsListAtom.reportRead();
    return super.dieselRefuelsList;
  }

  @override
  set dieselRefuelsList(List<dynamic> value) {
    _$dieselRefuelsListAtom.reportWrite(value, super.dieselRefuelsList, () {
      super.dieselRefuelsList = value;
    });
  }

  final _$gasolineRefuelsListAtom =
      Atom(name: '_ReportStore.gasolineRefuelsList');

  @override
  List<dynamic> get gasolineRefuelsList {
    _$gasolineRefuelsListAtom.reportRead();
    return super.gasolineRefuelsList;
  }

  @override
  set gasolineRefuelsList(List<dynamic> value) {
    _$gasolineRefuelsListAtom.reportWrite(value, super.gasolineRefuelsList, () {
      super.gasolineRefuelsList = value;
    });
  }

  final _$generalReportAtom = Atom(name: '_ReportStore.generalReport');

  @override
  ReportModel get generalReport {
    _$generalReportAtom.reportRead();
    return super.generalReport;
  }

  @override
  set generalReport(ReportModel value) {
    _$generalReportAtom.reportWrite(value, super.generalReport, () {
      super.generalReport = value;
    });
  }

  final _$ethanolReportAtom = Atom(name: '_ReportStore.ethanolReport');

  @override
  ReportModel get ethanolReport {
    _$ethanolReportAtom.reportRead();
    return super.ethanolReport;
  }

  @override
  set ethanolReport(ReportModel value) {
    _$ethanolReportAtom.reportWrite(value, super.ethanolReport, () {
      super.ethanolReport = value;
    });
  }

  final _$dieselReportAtom = Atom(name: '_ReportStore.dieselReport');

  @override
  ReportModel get dieselReport {
    _$dieselReportAtom.reportRead();
    return super.dieselReport;
  }

  @override
  set dieselReport(ReportModel value) {
    _$dieselReportAtom.reportWrite(value, super.dieselReport, () {
      super.dieselReport = value;
    });
  }

  final _$gasolineReportAtom = Atom(name: '_ReportStore.gasolineReport');

  @override
  ReportModel get gasolineReport {
    _$gasolineReportAtom.reportRead();
    return super.gasolineReport;
  }

  @override
  set gasolineReport(ReportModel value) {
    _$gasolineReportAtom.reportWrite(value, super.gasolineReport, () {
      super.gasolineReport = value;
    });
  }

  final _$_ReportStoreActionController = ActionController(name: '_ReportStore');

  @override
  dynamic setEthanolRefuelList(List<dynamic> value) {
    final _$actionInfo = _$_ReportStoreActionController.startAction(
        name: '_ReportStore.setEthanolRefuelList');
    try {
      return super.setEthanolRefuelList(value);
    } finally {
      _$_ReportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDieselRefuelList(List<dynamic> value) {
    final _$actionInfo = _$_ReportStoreActionController.startAction(
        name: '_ReportStore.setDieselRefuelList');
    try {
      return super.setDieselRefuelList(value);
    } finally {
      _$_ReportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setGasolineRefuelList(List<dynamic> value) {
    final _$actionInfo = _$_ReportStoreActionController.startAction(
        name: '_ReportStore.setGasolineRefuelList');
    try {
      return super.setGasolineRefuelList(value);
    } finally {
      _$_ReportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEthanolReport(ReportModel value) {
    final _$actionInfo = _$_ReportStoreActionController.startAction(
        name: '_ReportStore.setEthanolReport');
    try {
      return super.setEthanolReport(value);
    } finally {
      _$_ReportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDieselReport(ReportModel value) {
    final _$actionInfo = _$_ReportStoreActionController.startAction(
        name: '_ReportStore.setDieselReport');
    try {
      return super.setDieselReport(value);
    } finally {
      _$_ReportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setGasolineReport(ReportModel value) {
    final _$actionInfo = _$_ReportStoreActionController.startAction(
        name: '_ReportStore.setGasolineReport');
    try {
      return super.setGasolineReport(value);
    } finally {
      _$_ReportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setGeneralReport(ReportModel value) {
    final _$actionInfo = _$_ReportStoreActionController.startAction(
        name: '_ReportStore.setGeneralReport');
    try {
      return super.setGeneralReport(value);
    } finally {
      _$_ReportStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ethanolRefuelsList: ${ethanolRefuelsList},
dieselRefuelsList: ${dieselRefuelsList},
gasolineRefuelsList: ${gasolineRefuelsList},
generalReport: ${generalReport},
ethanolReport: ${ethanolReport},
dieselReport: ${dieselReport},
gasolineReport: ${gasolineReport}
    ''';
  }
}
