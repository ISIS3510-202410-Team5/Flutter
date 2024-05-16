import 'dart:isolate';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
  }

  checkNetwork(SendPort sendPort) async {
    var a = true;
    while (a) {
      List<ConnectivityResult> connectivityResult = await defineConnection();
      // defineConnection().then((status) => connectivityResult = status);
      if (connectivityResult.contains(ConnectivityResult.none)) {
        sendPort.send(1);
      }
    }
  }

  Future<List<ConnectivityResult>> defineConnection() async {
    // List<ConnectivityResult> ret = await (connectivity.checkConnectivity());
    return await (connectivity.checkConnectivity());
  }
}
