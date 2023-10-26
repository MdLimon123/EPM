import 'package:epm/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../model/photo_model.dart';

class PhotoController extends GetxController {
  var isLoading = false.obs;

  late PhotoModel photoModel;
  RxList<Datum> data = <Datum>[].obs;


  var isAllSelectedData = false.obs;



// fetch image
  getPhoto(int id) async {
    isLoading(true);
    try {
      var result = await ApiServices.fetchPhoto(id);
      if (result.runtimeType == int) {
        debugPrint('Photo Error :$result');
      } else {
        photoModel = result;
        data.value = photoModel.data;
        data.value.forEach((element) {
          print(element.isSelected);
        });
        debugPrint(photoModel.toString());
      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    } finally {
      isLoading(false);
    }
  }

  RxList<String> isVisible = <String>[].obs;


  isSelected(int index, bool dataSelected, String url) {
    data.value[index].isSelected = !dataSelected;
    if(dataSelected){
      isVisible.value.remove(url);
    }else{
      isVisible.value.add(url);
    }

    data.refresh();
  }

  isAllSelected() {
    for (var i = 0; i < data.value.length; i++) {
      data.value[i].isSelected = true;
      isAllSelectedData.value = true;
      if(data.value[i].isSelected == false){
        isVisible.value.add(data.value[i].url!);
      }
      data.refresh();
    }
  }

  isAllUnSelected() {
    for (var i = 0; i < data.value.length; i++) {
      data.value[i].isSelected = false;
      isAllSelectedData.value = false;
      if(data.value[i].isSelected == false){
        isVisible.value.remove(data.value[i].url!);
      }
      data.refresh();
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
