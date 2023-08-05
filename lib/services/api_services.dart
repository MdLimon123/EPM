import 'dart:convert';
import 'dart:io';

import 'package:epm/local_storage/my_preference.dart';
import 'package:epm/model/document_model.dart';
import 'package:epm/model/login_model';
import 'package:epm/model/photo_model.dart';
import 'package:epm/model/work_order_model.dart';

import 'package:epm/services/api_component.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiServices {
  static var client = http.Client();

  // handle login api n
  static Future<dynamic> handleLogin(
      {required String email, required String password}) async {
    try {
      var request = http.Request('POST', Uri.parse(loginApi));

      request.bodyFields = {'email': email, 'password': password};

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        return loginModelFromJson(data);
      } else {
        Map d = json.decode(await response.stream.bytesToString());
        debugPrint("$d");

        if (kDebugMode) {
          debugPrint(response.reasonPhrase);
        }
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
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6IllCUnkyQ0Q1emI3NGVlWXNIcWxyUWc9PSIsInZhbHVlIjoiZ0RZaTNDOXVla1FDY0VPRjVmbHYvRXkxNWg5OTVpWElReDBhSjF0Umo3WWw5c2g4TlRVS0hVSnlWck1UOVJjL2x3b2VZMzV1ZUlWbnNvMmJRSGptVC9nZmpGdzduZlZlQXhuQ2pDNStrVkgySElQWHVVeHdESEtvYmNzN0RDcS8iLCJtYWMiOiIwNmFlMWVlMmJhMmZlNzMxYjU4MDc3MTkyMmMzZGY2OWViYzkxYjBmZjA4ZDhkOGQ0M2IzNGMzNmJhNzAxOWRiIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6IjFwdXdKRWlyQ1NzOHU5WFpENE00Qnc9PSIsInZhbHVlIjoiYURnWlJnUVdVMkFaSzBrM01EYkVzNStYeS9BUS9laEd5cVMzc0tucXhuTm93Qjk5SW5YM29YcGw2ZUNoVmY5R3h3YnpSVHF0NUV0RU5BeThtRFk2K1htS0pFUHliRFpSNHVERmJYRTBEZEVHOGtQeTRubWgwK2RkUnptV3pIU3AiLCJtYWMiOiI2ZThlM2EyOTk3MjMzYjUyODIwMjdiNmM2ODM4ZTc3YjBlNzI0ZDMxZDcxNTNlZDMzMzZiZmM2YTk0MWNlM2ViIiwidGFnIjoiIn0%3D'
      };

      var request = http.Request('GET', Uri.parse(workOrder));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        return workOrderModelFromJson(data);
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint('Work orders fetch Error. Reason ${e.toString()}');
      }
      return 0;
    }
  }

  // post work order photo

  static uploadPhoto<Uint8List>(
      {required List<XFile> imagePath,
      required String workOrderName,
      required int workOrderId}) async {
    debugPrint(" Image Length : ${imagePath.length}");
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6Im94NUhJOG5iOG56UXZsZXdQcldTeGc9PSIsInZhbHVlIjoiZHcxRno2RGZBMlRNbEpZTWZVTFR2Tm9JczV1L0JCMEF0UitMUWNVU2FHQkhBVmE2V05GNWNvMS9tVzdSSXIwdnNWRXBUR2ExTzBHaXU0U3N2TVNSRExkTWpacnZYQUR2QytXVE5UanZjSHJ2WjQvS0tzdVo5ZVdpK0haNEs1a0oiLCJtYWMiOiI3MTYyYmI0NDNkNTk4ODY4ZWJkZTQzNTA4YTllY2E4YzRhN2QxNjk1MDg0NzlmYTIyMzI2YTg1NDY3MDgyNGYyIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6IllsSlZTaVhGL2dsNkl3TEV6aUMwZ0E9PSIsInZhbHVlIjoidkc4T2QweE1xZ0FMTFFoVkVVNW5GYnV5Q3VYbXFPNnBTazVXQlJHeWRXN3BDMEpFeGtuV1NOVmVpRFVac1VUZmgxdVJzeFZqNnlabklnZWZDUDczR0QxdE8yVkxCaExZbHpjYjlwYkhCRTlTeXlGTEVHTzkrOGFkMGI5TkhXVWYiLCJtYWMiOiJhZWNkZGFhYzBmODg2NjA1MWYyNDNiZmRkNmQxNTUwODhjYTk3Y2M2NzllNzQ1NmJjYmRlNWQ0YjFlNjc5Yjg4IiwidGFnIjoiIn0%3D'
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
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6ImtWQU4rRXI1d2QwbFpxdXhkSnNHalE9PSIsInZhbHVlIjoianNVRXFnUGhVZmthMy9ObHJUc0RIM1Zhd09Za0dRUVdLTi9nVzJrMWJXY0kzblhBM1BjbGpkVGNxOHJnOTdKVWpNaiszRkF3Rnh0VFZEL0t3dnNiZnRxS0pIL0oxVHFzdlVkODgvTVNzVFladE1wc2xQRHZRbEVzU1BuUUxCcW8iLCJtYWMiOiJhMDRkNTA2MDkwNjQzM2QwM2FlMDU1ZjcwYjE3ZmE1ZTdhYmY0Yzc5ZjhkNTJmOTcyZGEwMTdkMGM3NTVhYWZjIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6IlFqMUwzRHhsb1hNaWpNZkVvcnFaaWc9PSIsInZhbHVlIjoiWkVnRUZ6NG5VSGRXdUNvNi9kY3VPWlBXVTVBYlk3Vm5VZTdlUVh6RmhqZUs0am1seDBuaXBsUGNReWJxVTVPWVh0a0IzbkVCc2hXQ2xIU3VOVDVTelRuM1FIL3Jlc09XL1BOZERLbEtWNFJxRjFUemVFMzhtbHA3bXl0UlRubGciLCJtYWMiOiIzMmNiODRjNDIwNDQ5NTk4ODE2NjdmOWIxMjRhNTNiMjZhNWM3OTQ1NjZkOWU0YmVhZGIwMmI2OWU3OTIxZTI4IiwidGFnIjoiIn0%3D'
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
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6IjlQVzZScDZQMnNsUkZ2RXBxWWgwOFE9PSIsInZhbHVlIjoiV0NTVEZFZkRhTHZMaUtrMzlXS21pYTVGbnJwR2JBQXV0NXZ2bnBmWS9PVHQyTXJFN2ZncHE3UVpBTE9abHA5UmFpUzZucDdPMUtONlcrWFh2bHMxTXJ6QjBiOFBYeXA1S2lPb0N4V0s5L242MUJ5dXFIWWNmOStURWFRUGdWR2IiLCJtYWMiOiI0NDE1OGJlMGUxNjdlNzU1MjdmMDM2YTc2NmE3NjM2ODgyYWVmNmIxMmU2Zjc2MTM1MGM1NWJmOWU4MzYxMTYzIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6InBJSGcvSll2bHJ6dTF6TnJHbUhPNWc9PSIsInZhbHVlIjoibk9XMlVkSkhBUVNsV1FYd0c3YU1LWm5KWm94Qis1aWh3d3dhc1V2WTZxbkVOQlRNcVR5UmtuMWxGeUJIdi9zZzNoUEFxMmoySVVqSFlHS1c3ZW5CVXNWcmZ5dzQwVWtNQVRCUVBqUkQ5V01XMUd1QnlabHRhdGtQakQ2WFlVOSsiLCJtYWMiOiJhMzVkZjhlODk0N2RmMTJmNjYyYjYzZWNhMTJiNzUxMzNiYTNiM2EwNTBlZTk0MjE1ZjVkNzE2MDA3ZDU0M2ZjIiwidGFnIjoiIn0%3D'
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
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6IklxcnFUUzdkUlBPTVpkY3BVeDFXOXc9PSIsInZhbHVlIjoiQlNwRXJUa1pOWmc4WHZHckZHeS8wSkVNTTVYQWVxQzJQSXNyaHIvOUc4YURuQTZMUHc5TzFzZWhYZzNMVjRIa0VvdkRkaVZVZ1BrbjREejhWOGszMFZPb1kyT01XQW52VXRtRDZKMWxEWWdseG5jYlcxbkR2UVA5b2dtVHBpOWEiLCJtYWMiOiI3YTExY2NhMmY5Y2FiMTk1NWM0YTFkZGI2NjA5ZjUwYzNlMTk2MGIxZDQ3MWM4MTAxZGFmNzEyOWYwNmY0ZjEyIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6Im1kd1l5eThWVVg3U1BIUnZEZVBaVUE9PSIsInZhbHVlIjoiMThnM3hrTktuVFo4WEJrdTNUNWgwMmNualBRU2pVUlJ5STloaHQyR0UzNHVsWVR4c3VjYjluZmNteDV2K2NJb0lxNTBLZDh6ZDBUR2t2dEVZVCtmTEdKbHIrTnJxNXAxSThFNlZ6UklpRWlyM2xmOXBnSUZqTGNpWlpQeW5IbysiLCJtYWMiOiJhNTc3NWU2ZDg4ZDU4YTYwNmIzODhkYTdkOTFjNjY2MzA4MjZiYmU1ZmU3MTBiNzc4MmZhZWJiNjc2MGExZmNiIiwidGFnIjoiIn0%3D'
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
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6IklxcnFUUzdkUlBPTVpkY3BVeDFXOXc9PSIsInZhbHVlIjoiQlNwRXJUa1pOWmc4WHZHckZHeS8wSkVNTTVYQWVxQzJQSXNyaHIvOUc4YURuQTZMUHc5TzFzZWhYZzNMVjRIa0VvdkRkaVZVZ1BrbjREejhWOGszMFZPb1kyT01XQW52VXRtRDZKMWxEWWdseG5jYlcxbkR2UVA5b2dtVHBpOWEiLCJtYWMiOiI3YTExY2NhMmY5Y2FiMTk1NWM0YTFkZGI2NjA5ZjUwYzNlMTk2MGIxZDQ3MWM4MTAxZGFmNzEyOWYwNmY0ZjEyIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6Im1kd1l5eThWVVg3U1BIUnZEZVBaVUE9PSIsInZhbHVlIjoiMThnM3hrTktuVFo4WEJrdTNUNWgwMmNualBRU2pVUlJ5STloaHQyR0UzNHVsWVR4c3VjYjluZmNteDV2K2NJb0lxNTBLZDh6ZDBUR2t2dEVZVCtmTEdKbHIrTnJxNXAxSThFNlZ6UklpRWlyM2xmOXBnSUZqTGNpWlpQeW5IbysiLCJtYWMiOiJhNTc3NWU2ZDg4ZDU4YTYwNmIzODhkYTdkOTFjNjY2MzA4MjZiYmU1ZmU3MTBiNzc4MmZhZWJiNjc2MGExZmNiIiwidGFnIjoiIn0%3D'
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
}
