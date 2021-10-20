import 'package:gas_calculator/models/refuel_model.dart';
import 'package:gas_calculator/models/report_model.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'report_store.g.dart';

class ReportStore = _ReportStore with _$ReportStore;

abstract class _ReportStore with Store {
  RefuelStore refuelStore = GetIt.I<RefuelStore>();

  @observable
  List ethanolRefuelsList = [];

  @observable
  List dieselRefuelsList = [];

  @observable
  List gasolineRefuelsList = [];

  @observable
  ReportModel generalReport = ReportModel();

  @observable
  ReportModel ethanolReport = ReportModel();

  @observable
  ReportModel dieselReport = ReportModel();

  @observable
  ReportModel gasolineReport = ReportModel();

  @action
  setEthanolRefuelList(List value) => ethanolRefuelsList = value;

  @action
  setDieselRefuelList(List value) => dieselRefuelsList = value;

  @action
  setGasolineRefuelList(List value) => gasolineRefuelsList = value;

  @action
  setEthanolReport(ReportModel value) => ethanolReport = value;

  @action
  setDieselReport(ReportModel value) => dieselReport = value;

  @action
  setGasolineReport(ReportModel value) => gasolineReport = value;

  @action
  setGeneralReport(ReportModel value) => generalReport = value;

  List getRefuelsByFuelType(int fuelTypeId) {
    var list = List.from(refuelStore.refuelList);
    return list.where((refuel) => refuel.fuelTypeId == fuelTypeId).toList();
  }

  loadRefuelsByFuelType() {
    setEthanolRefuelList(getRefuelsByFuelType(FuelTypes.ETHANOL.id));
    setDieselRefuelList(getRefuelsByFuelType(FuelTypes.DIESEL.id));
    setGasolineRefuelList(getRefuelsByFuelType(FuelTypes.GASOLINE.id));
  }

  loadFuelTypeReport({int? fuelTypeId, bool generalReport = false}) {
    ReportModel report = ReportModel();
    List<Refuel> refuelList = [];
    if (generalReport) {
      refuelList = List.from(refuelStore.refuelList);
    } else {
      if (fuelTypeId == null) return report;
      refuelList = List.from(refuelStore.refuelList
          .where((element) => element.fuelTypeId == fuelTypeId));
    }

    if (refuelList.isNotEmpty) {
      report.totalVolume =
          refuelList.fold(0.0, (sum, item) => sum + item.litres);
      report.totalCost =
          refuelList.fold(0.0, (sum, item) => sum + item.totalCost);

      report.totalKm = refuelList.last.odometer - refuelList.first.odometer;

      report.lowestConsumption = getLowestConsumption(refuelList);
      report.highestConsumption = getHighestConsumption(refuelList);
      report.averageConsumption = getAverageConsumption(refuelList);
      report.lastConsumption =
          refuelList.isEmpty ? 0.0 : refuelList.last.consuption;
    }

    switch (fuelTypeId) {
      case 1:
        setEthanolReport(report);
        break;
      case 2:
        setDieselReport(report);
        break;
      case 3:
        setGasolineReport(report);
        break;
      default:
        setGeneralReport(report);
    }
  }

  double getLowestConsumption(List<Refuel> refuels) {
    refuels.removeWhere(
        (refuel) => refuel.consuption == 0.0 || !refuel.isFillingUp);

    if (refuels.isEmpty) return 0.0;

    return refuels.reduce((value, element) {
      if (value.consuption < element.consuption) {
        return value;
      } else {
        return element;
      }
    }).consuption;
  }

  double getHighestConsumption(List<Refuel> refuels) {
    if (refuels.isEmpty) return 0.0;
    return refuels.reduce((value, element) {
      if (value.consuption > element.consuption) {
        return value;
      } else {
        return element;
      }
    }).consuption;
  }

  double getAverageConsumption(List<Refuel> refuels) {
    if (refuels.isEmpty) return 0.0;
    double sumConsumption =
        refuels.fold(0.0, (sum, item) => sum + item.consuption);

    return sumConsumption / refuels.length;
  }
}
