
import 'package:epm/controller/photo_controller.dart';
import 'package:epm/services/api_services.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


 final _photoController = Get.find<PhotoController>();
class AddImageController extends GetxController {

  var isLoading = false.obs;

  String workOrder = "";
  int id = (-0);

 

  RxList selectedImage = [].obs;

  RxString selectedDate = ''.obs;
  List<XFile> imagePth = <XFile>[].obs;

 

  Future<void> pickImageGallery() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      imagePth = images;
  
      selectedImage.add(images);
      selectedDate();


    }
  }


// image upload

  uploadImage() async {
    try {
      isLoading(true);

      var result = await ApiServices.uploadPhoto(
          imagePath: imagePth, workOrderName: workOrder, workOrderId: id);
      if (!result) {
        if (kDebugMode) {
          debugPrint("$result");
          Get.snackbar('Error', "Image Upload Faild",
              backgroundColor: Colors.red);
        }
      } else {
        selectedImage.value = imagePth;
    debugPrint("$selectedImage");
           _photoController.getPhoto(id );
        selectedImage.clear();
     
        Get.snackbar('success', 'Image Upload seccess',
            backgroundColor: Colors.white);
      }
    } on Exception catch (e) {
      debugPrint('Error $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> pickImageCamera() async {
    final picker = ImagePicker();
  XFile? images = await picker.pickImage(source: ImageSource.camera);

    if (images != null) {

       selectedImage.add(images);
    }
  }

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      selectedDate.value = formattedDate;
    }
  }

  // delete image
  Future<void> deleteImage(int id)async{

    try {
  var result = await ApiServices.deletePhoto(id);
  if(result.runtimeType == int){
    if(kDebugMode){
      print('Delete Faild : $result');
    }
  }else{
    
    Get.snackbar('Delete Image', 'Success',
    backgroundColor: Colors.white);
  }
} on Exception catch (e) {
  if(kDebugMode){
    print("Not Delete Image ${e.toString()}");
  }
}
    
  }
}
