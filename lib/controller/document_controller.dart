import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class DocumentController extends GetxController {
  var selecetedFile = ''.obs;
  final TextEditingController fileByController = TextEditingController();
  final RxList<String> _fileList = <String>[].obs;
  List<String> get fileList => _fileList;
  var filePath = ''.obs;
  var shortPath = ''.obs;


// selected file

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

// uploade and file name short 
  Future<void> uploadFile() async {
    if (filePath.isEmpty) {
      return;
    }
    String fileName = path.basename(filePath.value);
    if(fileName.length >20){
      String fileNameWithoutExt = path.basenameWithoutExtension(fileName);
      String fileExtension = path.extension(fileName);
      if(fileNameWithoutExt.length>18){
        fileNameWithoutExt = fileNameWithoutExt.substring(0,15);

      }
      fileName = "$fileNameWithoutExt $fileExtension";

    }
    _fileList.add(fileName);

    //  String shortName = filePath.value.split('/').last;
    //  String shortenedFileName = shortName.substring(0,10);
    //  shortPath.value = filePath.value.replaceFirst(shortName, shortenedFileName);
    //_fileList.add(filePath.value);
    // _fileList.add(shortPath.value);

    filePath.value = '';
    
   
  
  
  }
}
