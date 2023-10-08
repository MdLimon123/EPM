import 'dart:convert';
import 'dart:io';

import 'package:epm/local_storage/my_preference.dart';
import 'package:epm/model/document_model.dart';
import 'package:epm/model/log_in_model.dart';
import 'package:epm/model/photo_model.dart';
import 'package:epm/model/work_order_model.dart';

import 'package:epm/services/api_component.dart';
import 'package:epm/views/ChatScreen/Models/user_chat_model.dart';
import 'package:epm/views/ProfileScreen/model/profile_model.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiServices {
  static var client = http.Client();

  // handle login api n
  static Future<dynamic> handleLogin(
      {required String email, required String password}) async {
    try {
      http.Response response = await client.post(
        Uri.parse(loginApi),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        return logInModelFromJson(response.body);
      } else {
        return 1;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint('Login Error ${e.toString()}');
      }
      return 1;
    }
  }

// fetch work order
  static dynamic fetchWorkOrders() async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };
      print(workOrder);
      print(accessToken);
      http.Response response =
          await client.get(Uri.parse(workOrder), headers: headers);
      if (response.statusCode == 200) {
        return workOrderModelFromJson(response.body);
      } else {
        return 1;
      }
      // var request = http.Request('GET', Uri.parse(workOrder));
      // request.headers.addAll(headers);

      // http.StreamedResponse response = await request.send();
      // if (response.statusCode == 200) {
      //   var data = await response.stream.bytesToString();
      //   return workOrderModelFromJson(data);
      // } else {
      //   return response.statusCode;
      // }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint('Work orders fetch Error. Reason ${e.toString()}');
      }
      return 0;
    }
  }

  // post work order photo

  static Future uploadPhoto<dynmic>(
      {required List<XFile> imagePath,
      required String workOrderName,
      required int workOrderId}) async {
    debugPrint(" Image Length : ${imagePath.length}");
    var accessToken = await MyPreference.getToken();
    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://epm.essential-infotech.com/api/work-order-photos-store'));
      request.fields.addAll({
        'work_order_name': workOrderName,
        'work_order_id': workOrderId.toString()
      });
      imagePath.forEach((element) async {
        print(element.path);
        request.files
            .add(await http.MultipartFile.fromPath('photo[]', element.path));
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        debugPrint("success ${await response.stream.bytesToString()}");
        return true;
      } else {
        debugPrint("faild ${await response.stream.bytesToString()}");
        return false;
      }
    } on Exception catch (e) {
      debugPrint("Image Upload error $e");
      return false;
    }
  }

  //  pdf document method

  static uploadDocument(
      {required List<File> filePath,
      required String workOrderName,
      required int workOrderId}) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };

      var request = http.MultipartRequest('POST', Uri.parse(documentPostApi));

      request.fields.addAll({
        "work_order_name": workOrderName,
        "work_order_id": workOrderId.toString()
      });

      filePath.forEach((element) async {
        request.files
            .add(await http.MultipartFile.fromPath('file[]', element.path));
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        debugPrint("success ${await response.stream.bytesToString()}");

        return true;
      } else {
        debugPrint("faild ${await response.stream.bytesToString()}");

        return false;
      }
    } on Exception catch (e) {
      debugPrint("Image Upload error $e");
      return false;
    }
  }

// fetch photo
  static fetchPhoto(int id) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var response =
          await client.get(Uri.parse("$photoUrlGet$id"), headers: headers);
      if (response.statusCode == 200) {
        return photoModelFromJson(response.body);
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Photo Fetch Error: ${e.toString()}');
      }
      return 0;
    }
  }

// delete photo
  static dynamic deletePhoto(int id) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken'};

      var response =
          await client.get(Uri.parse("$photoDelete$id"), headers: headers);

      if (response.statusCode == 200) {
        return jsonEncode(response.body);
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Image Delete Error : $e');
      }
      return 1;
    }
  }

  // delete document
  static dynamic deleteDocument(int id) async {
    var accessToken = await MyPreference.getToken();
    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };

      var response = await client.get(Uri.parse("$documentDeleteApi$id"),
          headers: headers);
      if (response.statusCode == 200) {
        return jsonEncode(response.body);
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Document Delete Error : $e');
      }
      return 1;
    }
  }

// fetch document
  static fetchDocument(int id) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };

      var response =
          await client.get(Uri.parse("$getDocumentApi$id"), headers: headers);

      if (response.statusCode == 200) {
        return documentModelFromJson(response.body);
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Document Fetch Error: ${e.toString()}');
      }
      return 0;
    }
  }

// usre logout
  static Future<bool> userLogout() async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken'};

      var request = http.MultipartRequest('GET', Uri.parse(logout));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        debugPrint(await response.stream.bytesToString());
        return true;
      } else {
        debugPrint(response.reasonPhrase);
        return false;
      }
    } on Exception catch (e) {
      debugPrint('User logout error : $e');

      return false;
    }
  }

// user profile

  static dynamic userProfile() async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken'};

      var response = await client.get(Uri.parse(profile), headers: headers);

      if (response.statusCode == 200) {
        print(response.body);
        return profileModelFromJson(response.body);
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Profile Data Fetch Error: ${e.toString()}');
      }
      return 0;
    }
  }

  // user get chat message

  static dynamic getUserChatMessage({required int id}) async {
    var accessToken = await MyPreference.getToken();

    var headers = {'Authorization': 'Bearer $accessToken'};

    try {
      var respone =
          await client.get(Uri.parse("$getChatApi$id"), headers: headers);

      if (respone.statusCode == 200) {
        print(respone.body);

        return userChatModelFromJson(respone.body);
      } else {
        return respone.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("User Message fetch Error. Reason ${e.toString()}");
      }
      return 0;
    }
  }

  /// send message to user

  static Future<bool> postMessageToUser({ required int workOrderId,required int memberId,required int vendorId,
  required String message})async{

    var accessToken = await MyPreference.getToken();

    try {
      var headers = {
        'Authorization': 'Bearer $accessToken'
      };

      var request = http.MultipartRequest('POST', Uri.parse(postChatMessage));
      request.fields.addAll({
        "work_order_id": workOrderId.toString(),
        "message": message,
        "member_id": memberId.toString(),
        "vendor_id":vendorId.toString()
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if(response.statusCode == 200){
        return true;
      }else{
        if(kDebugMode){
          print(response.reasonPhrase);
        }
        return false;
      }
    } on Exception catch (e) {
      if(kDebugMode){
        print("User Message send Error. Reason ${e.toString()}");
      }
      return false;
    }

  }

}
