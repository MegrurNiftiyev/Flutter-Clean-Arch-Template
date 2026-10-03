import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkManager {
  static Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}
