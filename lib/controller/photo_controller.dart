import 'dart:io';

import 'package:epm/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/photo_model.dart';
import 'package:http/http.dart' as http;



class PhotoController extends GetxController {
  var isLoading = false.obs;

  late PhotoModel photoModel;
  RxList<Datum> data = <Datum>[].obs;

  RxBool isAllChecked = false.obs;

  RxList<String> selectedImages = <String>[].obs;

  void addImage(String imagePath) {
    selectedImages.add(imagePath);
  }

  void removeImage(String imagePath) {
    selectedImages.remove(imagePath);
  }


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


  Future<void>downloadImages(List<String> imageUrl)async{

    for(var url in imageUrl){
      try {
        var response = await http.get(Uri.parse(url));
        List<int> bytes = response.bodyBytes;
        String imageName = url.split('/').last;
        await File('path_to_save/$imageName').writeAsBytes(bytes);
      } on Exception catch (e) {
        print("Error downloading image: $e");
      }
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
