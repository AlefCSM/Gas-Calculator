import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  final logger = Logger("ConnectivityStore");
  @observable
  bool isConnected = true;

  @action
  void setConnection(bool value) => isConnected = value;
  StreamSubscription<InternetConnectionStatus>? listener;

  _ConnectivityStore() {
    initConnectionListener();
  }

  void initConnectionListener() {
    logger.info("Iniciou Listener de conexão.");
    if (listener == null) {
      InternetConnectionChecker().checkInterval = Duration(seconds: 3);
      listener = InternetConnectionChecker().onStatusChange.listen((event) {
        if (event == InternetConnectionStatus.disconnected) {
          setConnection(false);
        }

        if(event == InternetConnectionStatus.connected) {
          setConnection(true);
        }
      });
    }
  }

  void cancelListener() {
    logger.info("Cancelou Listener de conexão.");
    if (listener != null) {
      listener?.cancel();
      listener = null;
    }
  }
}
