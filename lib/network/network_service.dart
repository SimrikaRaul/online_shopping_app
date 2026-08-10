import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService {
  static final InternetConnection connection = InternetConnection();
  static Future<bool> isConnected() {
    return connection.hasInternetAccess;
  }
}