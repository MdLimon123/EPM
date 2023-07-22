import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentController extends GetxController {
  var selecetedFile = ''.obs;
  final TextEditingController fileByController = TextEditingController();
  final RxList<String> _fileList = <String>[].obs;
  List<String> get fileList => _fileList;
  var filePath = ''.obs;

  Future<void> selectFile() async {
    FilePickerResult? filePicker = await FilePicker.platform.pickFiles();
    if (filePicker != null) {
      selecetedFile.value = filePicker.files.single.path!;
      fileByController.text = selecetedFile.value;
      filePath.value = selecetedFile.value;
    } else {
      fileByController.text = "No file chosen";
    }
  }

  Future<void> uploadFile() async {
    if (filePath.isEmpty) {
      return;
    }
    _fileList.add(filePath.value);
    filePath.value = '';
  }
}
