import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {
  var id = 0.obs;
  var username = "".obs;
  var profileImage = "".obs;
  var email = "".obs;
  var password = "".obs;
  var bearerToken = "".obs;

  late SharedPreferences preferences;

  getData() async {
    preferences = await SharedPreferences.getInstance();
    id.value = preferences.getInt(CommonData.id) ?? 0;
    email.value = preferences.getString(CommonData.email) ?? "";
    username.value = preferences.getString(CommonData.username) ?? "";
    password.value = preferences.getString(CommonData.password) ?? "";
    profileImage.value = preferences.getString(CommonData.profileImage) ?? "";
    bearerToken.value = preferences.getString(CommonData.bearerToken) ?? "";
  }

  setData(
      {
     
  
      required String bearerTokenD,
     }) async {
 
   
  
    bearerToken.value = bearerTokenD;


    preferences = await SharedPreferences.getInstance();


    preferences.setString(CommonData.bearerToken, bearerTokenD);
  
  }
}

class CommonData {
  static var id = "id";
  static String username = "username";
  static String email = "email";
  static String profileImage = "profileImage";
  static String password = "password";
  static String bearerToken = "bearerToken";
}
