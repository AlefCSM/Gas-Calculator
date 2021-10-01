class ReportModel {
  late double totalCost;
  late double totalKm;
  late double totalVolume;
  late double consumption;
  late double lowestConsumption;
  late double highestConsumption;
  late double averageConsumption;
  late double lastConsumption;

  ReportModel({
    this.totalCost = 0.0,
    this.totalKm = 0.0,
    this.totalVolume = 0.0,
    this.consumption = 0.0,
    this.lowestConsumption = 0.0,
    this.highestConsumption = 0.0,
    this.averageConsumption = 0.0,
    this.lastConsumption = 0.0,
  });
}
