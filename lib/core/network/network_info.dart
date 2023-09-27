import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnectedByConnectivity;
  Future<bool> get isConnectedByConnectionChecker;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnectedByConnectivity async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<bool> get isConnectedByConnectionChecker =>
      InternetConnectionChecker().hasConnection;
}
