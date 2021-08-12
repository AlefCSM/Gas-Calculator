import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gas_calculator/pages/home_page.dart';
import 'package:gas_calculator/pages/login_page.dart';
import 'package:gas_calculator/stores/home/home_store.dart';
import 'package:gas_calculator/stores/login/login_store.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:get_it/get_it.dart';

void main() async {
  getItLocators();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

void getItLocators() {
  GetIt.I.registerSingleton(LoginStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(RefuelStore());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final LoginStore loginStore = GetIt.I<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text("Error"),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return GasCalculator();
          }

          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Container(
              child: Text("Loading"),
            ),
          );
        });
  }
}

class GasCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  LoginPage(),
    );
  }
}
