import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/assets/custom_font_size/custom_font_size_constants.dart';
import 'package:gas_calculator/stores/home/home_store.dart';
import 'package:gas_calculator/tabs/profile_tab.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore homeStore = GetIt.I<HomeStore>();

  final tabs = [
    Center(child: Text("Home")),
    Center(child: Text("Charts")),
    ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          return tabs[homeStore.tab];
        },
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          return BottomNavigationBar(
            currentIndex: homeStore.tab,
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
                label: "Charts",
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
  void dispose() {

    super.dispose();
  }
}
