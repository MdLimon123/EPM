import 'package:shared_preferences/shared_preferences.dart';

class MyPreference{

  static SharedPreferences? sharedPreferences;

  static Future<void> setOnBoard(bool isOnboard)async{

    sharedPreferences = await SharedPreferences.getInstance();


  }

  static Future<void> setToken(String accessToken)async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString(Constance.accessToken, accessToken);
  }

  static Future<String> getToken ()async{
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString(Constance.accessToken) ?? "";
  }

  static Future<void> isLoggedSave({required String email, required String password})async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString(Constance.isLoggedEmail, email);
    sharedPreferences!.setString(Constance.isLoggedPassword, password);
  }

  static Future<String?> getEmail()async{
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString(Constance.isLoggedEmail);
  
  }

  static Future<String?> getPassword()async{
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString(Constance.isLoggedPassword);
  }


 

}
 class Constance{
   static String accessToken = "";
   static String isLoggedEmail = "isLoggedEmail";
   static String isLoggedPassword = "isLoggedPassword";

  }