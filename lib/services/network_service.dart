import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkService {
  /// Checks if the device is currently connected to a network (mobile or wifi).
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) || 
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    }
    return false;
  }

  /// Checks connection and shows a SnackBar if offline.
  /// Returns true if connected, false if offline.
  static Future<bool> checkConnection(BuildContext context) async {
    bool connected = await isConnected();
    if (!connected) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No internet connection! Please check your network."),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      }
      return false;
    }
    return true;
  }
}
