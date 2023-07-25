import 'package:epm/Routes/routes.dart';
import 'package:epm/local_storage/my_preference.dart';
import 'package:epm/model/login_model';
import 'package:epm/services/api_services.dart';
import 'package:epm/widgets/data_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _dataController = Get.put(DataController());

  late SharedPreferences preferences;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // handle login method
  userLogin(
      {
      required String email,
      required String password}) async {
   
      isLoading(true);
    

    try {
      var result =
          await ApiServices.handleLogin(email: email, password: password);
      if (result.runtimeType == int) {
        if (kDebugMode) {
          Get.offAllNamed(Routes.loginScreen);
          _dataController.getData();
        } else {
          Fluttertoast.showToast(msg: "Invalid Credentials");
        }
        debugPrint("Opps sign in Error $result");
      } else {
        LoginModel allData = result;

        await MyPreference.isLoggedSave(
            email: emailController.text, password: passwordController.text);
        await MyPreference.setToken(allData.accessToken);
        Get.offAllNamed(Routes.workOrderScreen);
        var accessToken = await MyPreference.getToken();

        debugPrint("Last token $accessToken");


        emailController.clear();
        passwordController.clear();

        debugPrint("Sign in Successfull");
      }
    } on Exception catch (e) {
      debugPrint("Opps sign in Error $e");
    } finally {
      
        isLoading(false);
      
    }
  }
}