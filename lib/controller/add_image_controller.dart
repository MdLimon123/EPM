import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class AddImageController extends GetxController{

  RxList selectedImage = [].obs;

  RxString selectedDate = ''.obs;

  Future<void> pickImageGallery()async{
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();

    if(images != null){
      selectedImage.addAll(images);
      
  
    }
  }

  Future<void> pickImageCamera()async{
    final picker = ImagePicker();
    final images = await picker.pickImage(source:ImageSource.camera );

    if(images != null){
      selectedImage.add(images);
    
 
    }
  }

  Future<void> selectDate() async{
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
       initialDate: DateTime.now(), 
       firstDate: DateTime(2000),
        lastDate: DateTime(2050));

        if(pickedDate != null){
          final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          selectedDate.value = formattedDate;
        }


  }

}