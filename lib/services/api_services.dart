import 'dart:convert';

import 'package:epm/model/login_model';

import 'package:epm/services/api_component.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class ApiServices {
  static var client = http.Client();

  // handle login api

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
      if(kDebugMode){
        debugPrint('Login Error ${e.toString()}');
      }
      return 1;
    }
  }
}
