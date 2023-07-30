import 'dart:io';
import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/services/api_services.dart';
import 'package:epm/utils/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../model/work_order_model.dart';

class AddImageController extends GetxController {
  final TextEditingController workOrderController = TextEditingController();
  final TextEditingController workIdController = TextEditingController();

  final workController = Get.find<WorksOrderController>();

  var isLoading = false.obs;
  String workOrder = "";
  int id = (-0);

  RxList selectedImage = [].obs;

  RxString selectedDate = ''.obs;
  List<XFile> imagePth = <XFile>[].obs;

  void addImage(File image) {}

  Future<void> pickImageGallery() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      // uploadImage(images);
      imagePth = images;
      print(" Image Length : ${images.length}");
      selectedImage.add(images);

      // selectedImage.addAll(imagePth as Iterable);
      // uploadImage(image.toString())
      //uploadImage(imagePth);
    }
  }

  // void addImageFile(File imageFile){
  //   image.add(imageFile);
  // }

  uploadImage() async {
    try {
      isLoading(true);

      var result = await ApiServices.uploadPhoto(
          imagePath: imagePth, workOrderName: workOrder, workOrderId: id);
      if (!result) {
        if (kDebugMode) {
          debugPrint("$result");
          Get.snackbar('Error', "Image Upload Faild",
              backgroundColor: AppColor.deepOrange);
        }
      } else {
        selectedImage.value = imagePth;
        print(selectedImage);
        Get.snackbar('success', 'Image Upload seccess',
            backgroundColor: AppColor.deepOrange);
      }
    } on Exception catch (e) {
      debugPrint('Error $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> pickImageCamera() async {
    final picker = ImagePicker();
    final images = await picker.pickImage(source: ImageSource.camera);

    if (images != null) {
      // selectedImage.add(images);
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
}
