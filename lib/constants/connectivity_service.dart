import 'dart:async';
import 'package:assignment/constants/enums.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>();

  ConnectivityService() {
    // Subscribe to the connectivity Chanaged Steam
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t

      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}