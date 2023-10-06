import 'package:epm/services/api_services.dart';
import 'package:epm/views/ProfileScreen/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  late ProfileModel profileModel;

  RxList<Data> profileData = <Data>[].obs;

  getProfileData() async {
    isLoading(true);
    try {
      var result = await ApiServices.userProfile();

      if (result.runtimeType == int) {
        debugPrint('Photo Error :$result');
      } else {
        profileModel = result;
        print(profileData);
      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    } finally {
      isLoading(false);
    }
  }
}
