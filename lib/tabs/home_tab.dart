import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/pages/refuel_page.dart';
import 'package:gas_calculator/pages/vehicle_page.dart';
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
  final RefuelStore refuelStore = GetIt.I<RefuelStore>();
  final LoginStore loginStore = GetIt.I<LoginStore>();
  final VehicleStore vehicleStore = GetIt.I<VehicleStore>();
  final SynchronizationStore synchronizationStore = GetIt.I<SynchronizationStore>();

  Future<void> initRefuelVariables() async {

      refuelStore.getLastRefuel(vehicleId: vehicleStore.selectedVehicle.id);

    if (refuelStore.fuelTypeList.length == 0) {
      await refuelStore.getFuelTypes();
    }
    if (refuelStore.fuelTypeDrodownList.length == 0) {
      refuelStore.buildFuelList();
    }
  }

  Future<void> initHomeVariables() async{
    if (!vehicleStore.hasVehicleSelected) {
      await vehicleStore.getSelectedVehicle();
    }

    await vehicleStore.getSelectedVehicle();
    await refuelStore.getRefuels(vehicleId: vehicleStore.selectedVehicle.id);
    synchronizationStore.sync();
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
            Observer(builder: (_)=>Visibility(
              // visible:true,
              visible: vehicleStore.selectedVehicle.id > 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Column(
                        children: [
                          Text("Selected vehicle"),
                          Text("${vehicleStore.selectedVehicle.name}")
                        ],
                      )),
                  IconButton(
                      icon: Icon(Icons.swap_horiz),
                      onPressed: () {
                        synchronizationStore.sync();
                      })
                ],
              ),
              replacement: Text("There are no vehicles selected"),
            ),)
            ,
            SubmitButton(
                text: "Add new Refuel",
                onPressed: () async {
                  await initRefuelVariables();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        if (vehicleStore.hasVehicleSelected) {
                          return RefuelPage(
                            label: "New refuel",
                          );
                        } else {
                          return VehiclePage(label: "New vehicle");
                        }
                      },
                    ),
                  );
                }),
            Observer(



                builder: (_) => ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: refuelStore.refuelList.length,
                    itemBuilder: (contexts, index) {
                      return Text("${refuelStore.refuelList[index].odometer}");
                    }))
          ],
        ),
      ),
    );
  }
}