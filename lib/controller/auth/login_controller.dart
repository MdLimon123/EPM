import 'package:epm/Routes/routes.dart';
import 'package:epm/controller/common_controller.dart';
import 'package:epm/local_storage/my_preference.dart';
import 'package:epm/model/log_in_model.dart';

import 'package:epm/services/api_services.dart';
import 'package:epm/views/ProfileScreen/model/profile_model.dart';
import 'package:epm/widgets/data_controller.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final CommonController _commonController = Get.put(CommonController());
  final DataController _dataController = Get.put(DataController());

  var isVisibility = false.obs;

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  late SharedPreferences preferences;

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
  }

  // handle login method
  userLogin({required String userName, required String password}) async {
    isLoading(true);

    try {
      var result =
          await ApiServices.handleLogin(username: userName, password: password);
      if (result.runtimeType == int) {
        Fluttertoast.showToast(msg: "Invalid Credentials");
        debugPrint("Opps sign in Error $result");
      } else {
        LogInModel allData = result;
        await MyPreference.setString(
            key: Constance.accessToken, value: allData.accessToken);
        _dataController.setData(bearerTokenD: allData.accessToken);
        await getProfileData();
        Get.offAllNamed(Routes.mainDashboardScreen);

        userNameController.clear();
        passwordController.clear();

        debugPrint("Sign in Successfully");
      }
    } on Exception catch (e) {
      debugPrint("Opps sign in Error $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getProfileData() async {
    try {
      var result = await ApiServices.userProfile();
      if (result.runtimeType == int) {
        debugPrint('Photo Error :$result');
      } else {
        ProfileModel model = result;
        debugPrint('=========> profile Data ${model.data.id}');
        _commonController.setData(id: model.data.id!, roleD: model.data.role!);
      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    }
  }

// user logout

  handleUserLogout() async {
    try {
      isLoading(true);
      var result = await ApiServices.userLogout();

      if (result) {
        Get.toNamed(Routes.loginScreen);
        preferences = await SharedPreferences.getInstance();
        String email = preferences.getString("remeberEmail") ?? "";
        String password = preferences.getString("rememberPassword") ?? "";

        preferences.clear();

        preferences.setString("remeberEmail", email);
        preferences.setString("rememberPassword", password);
        Fluttertoast.showToast(msg: "Author logged out successfully");
        isLoading(false);
      } else {
        debugPrint("user not logout");
        isLoading(false);
      }
    } on Exception catch (e) {
      isLoading(false);
      debugPrint("Opps logout error $e");
    }
  }
}
