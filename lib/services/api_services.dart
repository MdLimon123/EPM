import 'dart:convert';
import 'dart:io';

import 'package:epm/local_storage/my_preference.dart';
import 'package:epm/model/login_model';
import 'package:epm/model/work_order_model.dart';

import 'package:epm/services/api_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  static uploadPhoto( 
      {required String imagePath,
     required String workOrderName,
      required int workOrderId}) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6Im94NUhJOG5iOG56UXZsZXdQcldTeGc9PSIsInZhbHVlIjoiZHcxRno2RGZBMlRNbEpZTWZVTFR2Tm9JczV1L0JCMEF0UitMUWNVU2FHQkhBVmE2V05GNWNvMS9tVzdSSXIwdnNWRXBUR2ExTzBHaXU0U3N2TVNSRExkTWpacnZYQUR2QytXVE5UanZjSHJ2WjQvS0tzdVo5ZVdpK0haNEs1a0oiLCJtYWMiOiI3MTYyYmI0NDNkNTk4ODY4ZWJkZTQzNTA4YTllY2E4YzRhN2QxNjk1MDg0NzlmYTIyMzI2YTg1NDY3MDgyNGYyIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6IllsSlZTaVhGL2dsNkl3TEV6aUMwZ0E9PSIsInZhbHVlIjoidkc4T2QweE1xZ0FMTFFoVkVVNW5GYnV5Q3VYbXFPNnBTazVXQlJHeWRXN3BDMEpFeGtuV1NOVmVpRFVac1VUZmgxdVJzeFZqNnlabklnZWZDUDczR0QxdE8yVkxCaExZbHpjYjlwYkhCRTlTeXlGTEVHTzkrOGFkMGI5TkhXVWYiLCJtYWMiOiJhZWNkZGFhYzBmODg2NjA1MWYyNDNiZmRkNmQxNTUwODhjYTk3Y2M2NzllNzQ1NmJjYmRlNWQ0YjFlNjc5Yjg4IiwidGFnIjoiIn0%3D'
      };

      var request = http.MultipartRequest('POST', Uri.parse('http://epm.essential-infotech.com/api/work-order-photos-store'));

     request.fields.addAll(
      {
        'work_order_name': workOrderName,
        'work_order_id': workOrderId.toString()
      }
     );
      // request.fields['work_order_name'] = workOrderName.toString();
      // request.fields['work_order_id'] = workOrderId.toString();
  
 request.files.add(await http.MultipartFile.fromPath('photo[]', imagePath));
      request.headers.addAll(headers);
      

     

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("success ${await response.stream.bytesToString()}");
        return true;
      } else {
        print("faild ${await response.stream.bytesToString()}");
        return false;
      }
    } on Exception catch (e) {
      debugPrint("Image Upload error $e");
      return false;
    }
  }
}
