import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gas_calculator/assets/custom_colors/color_constants.dart';
import 'package:gas_calculator/pages/home_page.dart';
import 'package:gas_calculator/pages/login_page.dart';
import 'package:gas_calculator/pages/splash_screen_page.dart';
import 'package:gas_calculator/stores/connectivity_store/connectivity_store.dart';
import 'package:gas_calculator/stores/home_store/home_store.dart';
import 'package:gas_calculator/stores/login_store/login_store.dart';
import 'package:gas_calculator/stores/refuel_store/refuel_store.dart';
import 'package:gas_calculator/stores/report_store/report_store.dart';
import 'package:gas_calculator/stores/vehicle_store/vehicle_store.dart';
import 'package:gas_calculator/synchronization_store/synchronization_store.dart';
import 'package:get_it/get_it.dart';

void main() async {
  getItLocators();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

void getItLocators() {
  GetIt.I.registerSingleton(LoginStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(ConnectivityStore());
  GetIt.I.registerSingleton(VehicleStore());
  GetIt.I.registerSingleton(RefuelStore());
  GetIt.I.registerSingleton(ReportStore());
  GetIt.I.registerSingleton(SynchronizationStore());
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
              child: loading(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            loginStore.getUser();
            return Observer(
                builder: (_) =>
                    loginStore.loading ? loading() : GasCalculator());
          }

          return loading();
        });
  }

  Widget loading() {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        child: SplashScreenPage(),
      ),
    );
  }
}

class GasCalculator extends StatelessWidget {
  final LoginStore loginStore = GetIt.I<LoginStore>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: kDarkBlueColor,
          appBarTheme: AppBarTheme(
            systemOverlayStyle:
                SystemUiOverlayStyle.dark,
          ),
          scaffoldBackgroundColor: kBackgroundGrey),
      home: Observer(
          builder: (_) => loginStore.currentUser != null
              ? HomePage(
                  title: "Gas Calculator",
                )
              : LoginPage()),
    );
  }
}
