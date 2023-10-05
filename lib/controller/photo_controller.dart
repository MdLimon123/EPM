import 'package:epm/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/photo_model.dart';

class PhotoController extends GetxController {
  var isLoading = false.obs;

  late PhotoModel photoModel;
  RxList<Datum> data = <Datum>[].obs;

  RxBool isAllChecked = false.obs;



// fetch image
  getPhoto(int id) async {
    isLoading(true);
    try {
      var result = await ApiServices.fetchPhoto(id);
      if (result.runtimeType == int) {
        debugPrint('Photo Error :$result');
      } else {
        photoModel = result;
        data.value =photoModel.data;
        debugPrint(photoModel.toString());
      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    } finally {
      isLoading(false);
    }
  }

  // delete image
  Future<void> deleteImage(int id, int index) async {
    try {
      var result = await ApiServices.deletePhoto(id);
      if (result.runtimeType == int) {
        if (kDebugMode) {
          print('Delete Failed : $result');
        }
      } else {
         data.removeAt(index);

        Get.snackbar('Delete Image', 'Success', backgroundColor: Colors.white);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Not Delete Image ${e.toString()}");
      }
    }
  }



}
