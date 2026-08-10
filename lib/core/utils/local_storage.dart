
import 'package:firebase_setup/core/utils/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static String tokenStr = "token";
  static String emailStr = "email";
  static String idStr = "id";
  static String isLoginStr = "isLogin";

  static SharedPreferences get prefs => getIt<SharedPreferences>();

  static Future<void> saveStringValue(String key, String value) async {
    await prefs.setString(key, value);
  }

  static String? getStringValue(String key) {
    return prefs.getString(key);
  }

  static Future<void> saveIntValue(String key, int value) async {
    await prefs.setInt(key, value);
  }

  static int? getIntValue(String key) {
    return prefs.getInt(key);
  }

  static Future<void> saveBooleanValue(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? getBoolValue(String key) {
    return prefs.getBool(key);
  }
}
