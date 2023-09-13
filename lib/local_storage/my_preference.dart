import 'package:shared_preferences/shared_preferences.dart';

class MyPreference {
  static SharedPreferences? sharedPreferences;

  static Future<void> setOnBoard(bool isOnboard) async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String accessToken) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Constance.accessToken, accessToken);
  }

  static Future<void> setString({required String key, value}) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constance.accessToken) ?? "";
  }

  static Future<String> getString({required String key}) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<void> isLoggedSave(
      {required String email, required String password}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString(Constance.isLoggedEmail, email);
    sharedPreferences!.setString(Constance.isLoggedPassword, password);
  }

  static Future<String?> getEmail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString(Constance.isLoggedEmail);
  }

  static Future<String?> getPassword() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString(Constance.isLoggedPassword);
  }
}

class Constance {
  static String accessToken = "";
  static String isLoggedEmail = "isLoggedEmail";
  static String isLoggedPassword = "isLoggedPassword";
}
