import 'dart:io';

import 'package:epm/model/document_model.dart';
import 'package:epm/services/api_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentController extends GetxController {
  var isLoading = false.obs;

  List<File> filePth = <File>[].obs;
  String workOrder = "";
  int id = (-0);

  late DocumentModel documentModel;
  RxList<Datum> data = <Datum>[].obs;

  uploadDocument() async {
    isLoading(true);
    try {
      var result = await ApiServices.uploadDocument(
          filePath: filePth, workOrderName: workOrder, workOrderId: id);

      if (!result) {
        if (kDebugMode) {
          debugPrint("$result");
          Get.snackbar('Error', "File Upload Faild",
              backgroundColor: Colors.red);
        }
      } else {
        filePth.clear();
        Get.snackbar('success', 'File Upload seccess',
            backgroundColor: Colors.white);
        getDocument(id);
      }
    } on Exception catch (e) {
      debugPrint('Error $e');
    } finally {
      isLoading(false);
    }
  }

  // fetch document

  getDocument(int id) async {
    isLoading(true);
    try {
      var result = await ApiServices.fetchDocument(id);
      if (result.runtimeType == int) {
        debugPrint('Docemnt Error :$result');
      } else {
        documentModel = result;
        data.value = documentModel.data;
        debugPrint(documentModel.toString());
      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    } finally {
      isLoading(false);
    }
  }

  // delete document

  Future<void> deleteDocument(int id, int index) async {
    try {
      var result = await ApiServices.deleteDocument(id);
      if (result.runtimeType == int) {
        if (kDebugMode) {
          print('Delete Faild : $result');
        }
      } else {
        //getDocument(id);
        data.removeAt(index);
        Get.snackbar('Delete Document', 'Success',
            backgroundColor: Colors.white);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Not Delete Document ${e.toString()}");
      }
    }
  }

// selected file

  Future<void> selectFile() async {
    List<File> files = [];
    FilePickerResult? filePicker = await FilePicker.platform.pickFiles(
        allowedExtensions: ['jpg', 'pdf', 'doc'], type: FileType.custom);

    if (filePicker != null && filePicker.files.isNotEmpty) {
      files = filePicker.files
          .map((platformFile) => File(platformFile.path!))
          .toList();

      debugPrint("$files");
      filePth = files;
      filePth = files;
    }
  }

//uploade and file name short
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

  // filePath.value = '';
}
