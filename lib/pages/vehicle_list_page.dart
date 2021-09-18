import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/components/custom_submit_buttom.dart';
import 'package:gas_calculator/models/vehicle_model.dart';
import 'package:gas_calculator/pages/vehicle_page.dart';
import 'package:gas_calculator/stores/home_store/home_store.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:get_it/get_it.dart';

class VehicleListPage extends StatefulWidget {
  @override
  _VehicleListPageState createState() => _VehicleListPageState();
}

class _VehicleListPageState extends State<VehicleListPage> {
  HomeStore homeStore = GetIt.I<HomeStore>();
  VehicleStore vehicleStore = GetIt.I<VehicleStore>();

  @override
  void initState() {
    vehicleStore.getVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Observer(
                builder: (_) => Visibility(
                      visible: !vehicleStore.loading,
                      child: SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 32),
                        child: Column(
                          children: [
                            SubmitButton(
                              text: "Add new Vehicle",
                              onPressed: () {
                                vehicleStore.setCurrentVehicle(Vehicle());
                                homeStore.navigateToPage(
                                    context: context,
                                    page: VehiclePage(
                                      label: "New vehicle",
                                    ),
                                    callback: () {});
                              },
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: vehicleStore.vehiclesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final vehicle =
                                    vehicleStore.vehiclesList[index];
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    vehicleStore.setCurrentVehicle(vehicle);
                                    homeStore.navigateToPage(
                                        context: context,
                                        page: VehiclePage(
                                            label: "Edit vehicle", edit: true),
                                        callback: () {});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text("${vehicle.name}"),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )),
                    ))));
  }
}
