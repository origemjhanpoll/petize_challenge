import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  Future<bool> get hasInternet async {
    final connectivity = Connectivity();
    final connectivityResult = await connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
