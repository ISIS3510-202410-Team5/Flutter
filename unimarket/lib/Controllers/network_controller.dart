import 'dart:isolate';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unimarket/Views/login_view.dart';

class NetworkController {
  final Connectivity connectivity = Connectivity();
  final LoginView logview = const LoginView();

  @override
  void onInit() {}

  void checkNetwork(List arguments) async {
    SendPort sendPort = arguments[0];
    RootIsolateToken rootToken = arguments[1];
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
    var a = true;

    while (a) {
      List<ConnectivityResult> connectivityResult =
          await (arguments[2].checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        sendPort.send(1);
        Isolate.exit();
      }
    }
  }
}
