import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus {online, offline}

class ConnectivityService {

  StreamController<NetworkStatus> controller = StreamController();
  //controller.

  NetworkStatus _networkStatus(List<ConnectivityResult> connectivityResult){
    return connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi) 
      ? NetworkStatus.online : NetworkStatus.offline;
  }

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((event) {
      controller.add(_networkStatus(event));
    });
  }
}