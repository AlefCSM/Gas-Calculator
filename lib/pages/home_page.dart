import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/stores/connectivity_store/connectivity_store.dart';
import 'package:gas_calculator/stores/home_store/home_store.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:gas_calculator/tabs/home_tab.dart';
import 'package:gas_calculator/tabs/profile_tab.dart';
import 'package:gas_calculator/tabs/reports_tab.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  HomeStore homeStore = GetIt.I<HomeStore>();
  VehicleStore vehicleStore = GetIt.I<VehicleStore>();
  RefuelStore refuelStore = GetIt.I<RefuelStore>();
  ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  final tabs = [HomeTab(), ReportsTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) {
            return tabs[homeStore.tabIndex];
          },
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          return BottomNavigationBar(
            currentIndex: homeStore.tabIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: CustomFontSize.large,
            unselectedFontSize: CustomFontSize.regular,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: "Reports",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              )
            ],
            onTap: (index) {
              homeStore.setTab(index);
            },
          );
        },
      ),
    );
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state != AppLifecycleState.resumed) {
      connectivityStore.cancelListener();
    } else if (state == AppLifecycleState.resumed) {
      connectivityStore.initConnectionListener();
    }
  }
}
