import 'dart:convert';

import 'package:epm/local_storage/my_preference.dart';
import 'package:epm/model/login_model';
import 'package:epm/model/work_order_model.dart';

import 'package:epm/services/api_component.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

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
}
