import 'dart:io';

import 'package:epm/services/api_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../utils/app_color.dart';

class DocumentController extends GetxController {

  final TextEditingController fileByController = TextEditingController();


  RxList selecetedFile = [].obs;

  var isLoading = false.obs;

  List<File> filePth = <File>[].obs;
  String workOrder = "";
  int id = (-0);

  uploadDocument() async {
    isLoading(true);
    try {
      var result = await ApiServices.uploadDocument(
          filePath: filePth, workOrderName: workOrder, workOrderId: id);

      if (!result) {
        if (kDebugMode) {
          debugPrint("$result");
          Get.snackbar('Error', "File Upload Faild",
              backgroundColor: AppColor.deepOrange);
              print(selecetedFile);
        }
      } else {
        selecetedFile.value = filePth;
        print(selecetedFile);
        Get.snackbar('success', 'File Upload seccess',
            backgroundColor: AppColor.deepOrange);
      }
    } on Exception catch (e) {
      debugPrint('Error $e');
    } finally {
      isLoading(false);
    }
  }

// selected file

  Future<void> selectFile() async {
    List<File> files = [];
   FilePickerResult? filePicker = await FilePicker.platform.pickFiles(allowedExtensions: ['jpg', 'pdf', 'doc'],
   type: FileType.custom);
   
    if (filePicker != null && filePicker.files.isNotEmpty) {
      files = filePicker.files.map((platformFile) => File(platformFile.path!)).toList();
  //  selecetedFile.value = filePicker.paths.map((path) => File(path!)).toList();
  print(files);
      selecetedFile.value = files;
     // selecetedFile.add(files);
  
    }
  }

// uploade and file name short
  // Future<void> uploadFile() async {
  //   if (filePath.isEmpty) {
  //     return;
  //   }
  //   String fileName = path.basename(filePath.value);
  //   if (fileName.length > 20) {
  //     String fileNameWithoutExt = path.basenameWithoutExtension(fileName);
  //     String fileExtension = path.extension(fileName);
  //     if (fileNameWithoutExt.length > 18) {
  //       fileNameWithoutExt = fileNameWithoutExt.substring(0, 15);
  //     }
  //     fileName = "$fileNameWithoutExt $fileExtension";
  //   }
  //   filePth.add(fileName);

  //   filePath.value = '';
  // }


}
