import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/components/custom_dropdown.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/components/refuel_card.dart';
import 'package:gas_calculator/models/vehicle_model.dart';
import 'package:gas_calculator/pages/refuel_page.dart';
import 'package:gas_calculator/pages/vehicle_page.dart';
import 'package:gas_calculator/stores/home_store/home_store.dart';
import 'package:gas_calculator/stores/login_store/login_store.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:gas_calculator/synchronization_store/synchronization_store.dart';
import 'package:get_it/get_it.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final HomeStore homeStore = GetIt.I<HomeStore>();
  final RefuelStore refuelStore = GetIt.I<RefuelStore>();
  final LoginStore loginStore = GetIt.I<LoginStore>();
  final VehicleStore vehicleStore = GetIt.I<VehicleStore>();
  final SynchronizationStore synchronizationStore =
      GetIt.I<SynchronizationStore>();

  Future<void> initRefuelVariables() async {
    if (vehicleStore.selectedVehicle.id != null) {
      refuelStore.getLastRefuel(vehicleId: vehicleStore.selectedVehicle.id!);
    }
    if (refuelStore.fuelTypeList.length == 0) {
      await refuelStore.getFuelTypes();
    }
    if (refuelStore.fuelTypeDrodownList.length == 0) {
      refuelStore.buildFuelTypeList();
    }
  }

  Future<void> initHomeVariables() async {
    await vehicleStore.getVehicles();
    vehicleStore.buildDropdownList();

    await vehicleStore.getSelectedVehicle();
    if (vehicleStore.selectedVehicle.id != null) {
      await refuelStore.getRefuels(vehicleId: vehicleStore.selectedVehicle.id!);
    }
    await synchronizationStore.sync().then((value) async {
      await vehicleStore.getVehicles();

      if (vehicleStore.vehiclesList.isNotEmpty &&
          vehicleStore.selectedVehicle.id == null) {
        vehicleStore.setSelectedVehicle(vehicleStore.vehiclesList[0]);
      }
      vehicleStore.buildDropdownList();
    });
  }

  @override
  void initState() {
    initHomeVariables();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Scaffold(
        body: Column(
          children: [
            Observer(
              builder: (_) {
                return Visibility(
                  visible: vehicleStore.selectedVehicle.id != null ||
                      vehicleStore.vehiclesList.isNotEmpty,
                  child: Column(
                    children: [
                      Text("Selected vehicle"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: CustomDropdown(
                          value: vehicleStore.selectedVehicle.id != null
                              ? vehicleStore.selectedVehicle
                              : vehicleStore.vehiclesList.length > 0
                                  ? vehicleStore.vehiclesList[0]
                                  : Vehicle(),
                          dropdownMenuItemList:
                              vehicleStore.vehiclesDrodownList,
                          onChanged: (Vehicle? vehicle) async {
                            if (vehicle != null) {
                              await vehicleStore
                                  .updateSelectedVehicle(vehicle.id!);
                              refuelStore.getRefuels(
                                  vehicleId: vehicleStore.selectedVehicle.id!);
                            }
                          },
                          isEnabled: true,
                        ),
                      )
                    ],
                  ),
                  replacement: Text("There are no vehicles selected"),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: SubmitButton(
                  text: "Add new Refuel",
                  onPressed: () async {
                    await initRefuelVariables();

                    if (vehicleStore.hasVehicleSelected) {
                      refuelStore.setCurrentFuelType(refuelStore.fuelTypeList[0]);
                      homeStore.navigateToPage(
                          context: context,
                          page: RefuelPage(
                            label: "New refuel",
                          ));
                    } else {
                      vehicleStore.setCurrentVehicle(Vehicle());
                      homeStore.navigateToPage(
                          context: context,
                          page: VehiclePage(label: "New vehicle"));
                    }
                  }),
            ),
            Observer(
                builder: (_) => ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: refuelStore.refuelList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Stack(children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: 10,
                              height: 100,
                              color: kBlack,
                              child: Center(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 15,
                                  itemBuilder: (ctx, i) => Align(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      width: 2,
                                      height: 6,
                                      color: kYellowColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              heightFactor: 3,
                              child: Container(
                                margin: EdgeInsets.only(left: 9),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: kGreenColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Icon(
                                  Icons.local_gas_station,
                                  color: kWhiteColor,
                                ),
                              ),
                            )
                          ]),
                          Expanded(
                              child: RefuelCard(
                                  refuel: refuelStore.refuelList[index]))
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
