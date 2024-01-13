import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  bool isConnected = false;

  void internetConnectivity() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    });
  }
}
