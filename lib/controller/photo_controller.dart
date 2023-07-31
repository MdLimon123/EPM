import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/photo_model.dart';

class PhotoController extends GetxController {
  var isLoading = false.obs;

  late PhotoModel photoModel;

  final workController = Get.find<WorksOrderController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getPhoto(int id) async {
    isLoading(true);

    try {
      var result = await ApiServices.fetchPhoto(id);
      if (result.runtimeType == int) {
        debugPrint('Photo Error :$result');
      } else {
        photoModel = result;
        debugPrint(photoModel.toString());
      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    } finally {
      isLoading(false);
    }
  }
}
