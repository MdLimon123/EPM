import 'dart:convert';
import 'dart:io';

import 'package:epm/local_storage/my_preference.dart';
import 'package:epm/model/document_model.dart';
import 'package:epm/model/log_in_model.dart';
import 'package:epm/model/photo_model.dart';
import 'package:epm/model/work_order_model.dart';

import 'package:epm/services/api_component.dart';
import 'package:epm/views/Add_Work_List/Models/add_work_model.dart';
import 'package:epm/views/Add_Work_List/Models/wor_estimation_model.dart';
import 'package:epm/views/ChatScreen/Models/user_chat_model.dart';
import 'package:epm/views/ProfileScreen/model/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ApiServices {
  static var client = http.Client();

  // handle login api
  static Future<dynamic> handleLogin(
      {required String username, required String password}) async {
    try {
      http.Response response = await client.post(
        Uri.parse('http://e-promanagement.com/api/login'),
        body: {'username': username, 'password': password},
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
        'Cookie': 'XSRF-TOKEN=eyJpdiI6IjBNRHU1N0xBWEEzMXBNK3E0aEJJMHc9PSIsInZhbHVlIjoiWGdxVnJpdWVSTEdsUC9aSlBIL2h2RDcwY3Y4UXJKNHV0Qm9vSnV4Nm1OYmJTVmk5bzM4R1dYM3c0Z2ovbXhWbmJobjF0UzRLQ1hUa1dHL1dTYTdyWGJ0QllqVlVCYWV5TU5CenBuMVU0QlBEOTA3dHNXd05aVVB0eTJRVzBLZWIiLCJtYWMiOiI4MzI2MThjOWY5YjlhMmViYTc3NDYxYzFiNzNjNTVhZTdmMjEzOWY1ZTRlNjFmZTEwMjM4Yjk0YTQwNTU2OTk4IiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6ImVmWTBMOEJkTlBMQkRzdFA2U1dIOEE9PSIsInZhbHVlIjoiam9NRkxwUEVnSUpDcEdpR1IzSHh1dXpnek55RXBRdXVkOUlVRk1OeEpYM0lkMG1QWnRnekMrdXlYZFhvRUFxQ25SSlNIcmZ5OGhGN0srL3hpeEh5dGhyaXdrNzdsVFFYVHpvdFVaMWp0QnloM3Jlek5nTVgvOGJZN3JWNGRCTngiLCJtYWMiOiJlMmZjNzhjYzBjNzRhYTU1MjVmNmFlZGVmNWQ4OWI1ZTdjMDNkMDNlMTI2MDMzNDI4NjQ4OTM3NDgzOTgwMWMwIiwidGFnIjoiIn0%3D'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              postWorkPhoto));
      request.fields.addAll({
        'work_order_name': workOrderName,
        'work_order_id': workOrderId.toString()
      });
      // imagePath.forEach((element) async {
      //   print(element.path);
      //   request.files
      //       .add(await http.MultipartFile.fromPath('photo[]', element.path));
      // });
      for(var imagePaths in imagePath){
        var file = File(imagePaths.path);
        if(!file.existsSync()){
          debugPrint('Image file dose not exist :${imagePaths.path}');
          continue;
        }

        var image = img.decodeImage(file.readAsBytesSync())!;
        var compressedImage = img.copyResize(image, width: 800);

        var tempDir = await getTemporaryDirectory();
        var tempFilePath = '${tempDir.path}/${basename(imagePaths.path)}';
        File(tempFilePath).writeAsBytesSync(img.encodeJpg(compressedImage, quality: 85));


        request.files.add(await http.MultipartFile.fromPath('photo[]', tempFilePath));
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        debugPrint("success ${await response.stream.bytesToString()}");
        return true;
      } else {
        debugPrint("failed ${await response.stream.bytesToString()}");
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
        debugPrint("failed ${await response.stream.bytesToString()}");

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

  // details

  static dynamic getEstimation(int id) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken'};

      var response =
          await client.get(Uri.parse("$addWorkApi$id"), headers: headers);

      if (response.statusCode == 200) {
        return addWorkModelFromJson(response.body);
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Data Fetch Error $e');
      }
    }
  }

  // get work estimation

  static dynamic getWorkEstimation(int id) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken',
        'Cookie': 'XSRF-TOKEN=eyJpdiI6Ilo3Y0pPd3VSbDM2ZHRrQlFoczdRM3c9PSIsInZhbHVlIjoiRHRidEtEOUxRK0h2N0xQYmpHZ095bmFwTlNqQ0FsYXh3ckc4WDlqdTVnZTNvZlBRL2dxOUFac0VzWGZxRjIxN2NMTThPdnFHT2h6SU1iaUQ1SldNR0xNaGdOWi9BRG1DdnRBaGVTV2RvY0JHRk1kd01mZXMwcG81Q096WDAyOFgiLCJtYWMiOiIxMDM4ODlkODYyODk0YzEwNGE5YmIwNDA4Y2MwMDc0MTFjMjJmMWMyNmE0ZWJkN2U4ZTg5MjZhNWYwNTA3NzIyIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6InE0V3FHS0ZFN2VYM3UvZGFpa1VQMGc9PSIsInZhbHVlIjoiaW03NzREUlRNVlEyUnNDSC84cVVpYUpNRTlCTFY3OWNpemJ3bGFDKzVnOWVrbHF3Rzh2eG1mWTRKcEZwenVOTU4vSDVuTW5PdDdsYytHZTBPTkF0aGlPM2xTcUNhODFMa01FUFFYdUVNRzZwZXdUMG9uYk0zUmJrOEhZY3FiYkciLCJtYWMiOiI1MGNmNzk5YzU2ODcxOWM5NjZhZmM1YmYyNjAwMTNlZjdiODI2ZTEzMTYwYmNiMjlhYTc2YzdjZjM5MmRlNWVjIiwidGFnIjoiIn0%3D'};

      var response =
          await client.get(Uri.parse("$getEstimationApi$id"), headers: headers);

      if (response.statusCode == 200) {
        print(response.body);

        return workEstimationModelFromJson(response.body);
      } else {
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Data Fetch Error $e');
      }
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

  // delete estimation

  static dynamic deleteEstimation(int id) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      var response = await client.get(Uri.parse("$deleteEstimationApi$id"),
          headers: headers);

      if (response.statusCode == 200) {
        print('success delete');
        return jsonEncode(response.body);
      } else {
        print("error ===========");
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Estimation Delete Error : $e');
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

// user logout
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

    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6Ilo3Y0pPd3VSbDM2ZHRrQlFoczdRM3c9PSIsInZhbHVlIjoiRHRidEtEOUxRK0h2N0xQYmpHZ095bmFwTlNqQ0FsYXh3ckc4WDlqdTVnZTNvZlBRL2dxOUFac0VzWGZxRjIxN2NMTThPdnFHT2h6SU1iaUQ1SldNR0xNaGdOWi9BRG1DdnRBaGVTV2RvY0JHRk1kd01mZXMwcG81Q096WDAyOFgiLCJtYWMiOiIxMDM4ODlkODYyODk0YzEwNGE5YmIwNDA4Y2MwMDc0MTFjMjJmMWMyNmE0ZWJkN2U4ZTg5MjZhNWYwNTA3NzIyIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6InE0V3FHS0ZFN2VYM3UvZGFpa1VQMGc9PSIsInZhbHVlIjoiaW03NzREUlRNVlEyUnNDSC84cVVpYUpNRTlCTFY3OWNpemJ3bGFDKzVnOWVrbHF3Rzh2eG1mWTRKcEZwenVOTU4vSDVuTW5PdDdsYytHZTBPTkF0aGlPM2xTcUNhODFMa01FUFFYdUVNRzZwZXdUMG9uYk0zUmJrOEhZY3FiYkciLCJtYWMiOiI1MGNmNzk5YzU2ODcxOWM5NjZhZmM1YmYyNjAwMTNlZjdiODI2ZTEzMTYwYmNiMjlhYTc2YzdjZjM5MmRlNWVjIiwidGFnIjoiIn0%3D'
    };

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

  // update Estimation
  static updateEstimation(
      {required int id,
      required String item,
      required String qty,
      required String contractor_price,
      required String contractor_total,
      required String comment}) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6Ilo3Y0pPd3VSbDM2ZHRrQlFoczdRM3c9PSIsInZhbHVlIjoiRHRidEtEOUxRK0h2N0xQYmpHZ095bmFwTlNqQ0FsYXh3ckc4WDlqdTVnZTNvZlBRL2dxOUFac0VzWGZxRjIxN2NMTThPdnFHT2h6SU1iaUQ1SldNR0xNaGdOWi9BRG1DdnRBaGVTV2RvY0JHRk1kd01mZXMwcG81Q096WDAyOFgiLCJtYWMiOiIxMDM4ODlkODYyODk0YzEwNGE5YmIwNDA4Y2MwMDc0MTFjMjJmMWMyNmE0ZWJkN2U4ZTg5MjZhNWYwNTA3NzIyIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6InE0V3FHS0ZFN2VYM3UvZGFpa1VQMGc9PSIsInZhbHVlIjoiaW03NzREUlRNVlEyUnNDSC84cVVpYUpNRTlCTFY3OWNpemJ3bGFDKzVnOWVrbHF3Rzh2eG1mWTRKcEZwenVOTU4vSDVuTW5PdDdsYytHZTBPTkF0aGlPM2xTcUNhODFMa01FUFFYdUVNRzZwZXdUMG9uYk0zUmJrOEhZY3FiYkciLCJtYWMiOiI1MGNmNzk5YzU2ODcxOWM5NjZhZmM1YmYyNjAwMTNlZjdiODI2ZTEzMTYwYmNiMjlhYTc2YzdjZjM5MmRlNWVjIiwidGFnIjoiIn0%3D'};

      var request =
          http.MultipartRequest('POST', Uri.parse("$updateEstimationApi$id"));

      request.fields.addAll({
        'item': item,
        'qty': qty,
        'contractor_price': contractor_price,
        'contractor_total': contractor_total,
        'comment': comment
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(response);
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      debugPrint("Data Upload error $e");
      return false;
    }
  }

  /// estimation post

  static uploadEstimation(
      {required int work_order_id,
      required String item,
      required String qty,
      required String contractor_price,
      required String contractor_total,
      required String comment,
      required String vendor_id}) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken',
        'Cookie': 'XSRF-TOKEN=eyJpdiI6Ilo3Y0pPd3VSbDM2ZHRrQlFoczdRM3c9PSIsInZhbHVlIjoiRHRidEtEOUxRK0h2N0xQYmpHZ095bmFwTlNqQ0FsYXh3ckc4WDlqdTVnZTNvZlBRL2dxOUFac0VzWGZxRjIxN2NMTThPdnFHT2h6SU1iaUQ1SldNR0xNaGdOWi9BRG1DdnRBaGVTV2RvY0JHRk1kd01mZXMwcG81Q096WDAyOFgiLCJtYWMiOiIxMDM4ODlkODYyODk0YzEwNGE5YmIwNDA4Y2MwMDc0MTFjMjJmMWMyNmE0ZWJkN2U4ZTg5MjZhNWYwNTA3NzIyIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6InE0V3FHS0ZFN2VYM3UvZGFpa1VQMGc9PSIsInZhbHVlIjoiaW03NzREUlRNVlEyUnNDSC84cVVpYUpNRTlCTFY3OWNpemJ3bGFDKzVnOWVrbHF3Rzh2eG1mWTRKcEZwenVOTU4vSDVuTW5PdDdsYytHZTBPTkF0aGlPM2xTcUNhODFMa01FUFFYdUVNRzZwZXdUMG9uYk0zUmJrOEhZY3FiYkciLCJtYWMiOiI1MGNmNzk5YzU2ODcxOWM5NjZhZmM1YmYyNjAwMTNlZjdiODI2ZTEzMTYwYmNiMjlhYTc2YzdjZjM5MmRlNWVjIiwidGFnIjoiIn0%3D'};

      var request = http.MultipartRequest('POST', Uri.parse(postEstimationApi));

      request.fields.addAll({
        'work_order_id': work_order_id.toString(),
        'item[]': item,
        'qty[]': qty,
        'contractor_price[]': contractor_price,
        'contractor_total[]': contractor_total,
        'comment[]': comment,
        'vendor_id': vendor_id
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(response);
        return true;
      } else {
        print(response);
        return false;
      }
    } on Exception catch (e) {
      debugPrint("Data Upload error $e");
      return false;
    }
  }

  /// send message to user

  static uploadWork(
      {required int id,
      required String description,
      required String qty,
      required String price,
      required String additional_instruction}) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Cookie':
            'XSRF-TOKEN=eyJpdiI6ImxpL292c3BHam44eThBVWpITHU0Qmc9PSIsInZhbHVlIjoiMGZDYlhWYVFsSjFVWS8yc3k5Y1pDVXdHdUdkLzZXOUJyNm5WMzdrTzFtWHlONjJGcFgvUkplRkpveFhEQVhUenl2M2F6Y0l3WjU5K0QyejJ5TUd4Q0V6NTZNb2trMzBKbm5MTVZHUG9UU2RESkhGOWtMb3BYbHlRM21mQjNvYkkiLCJtYWMiOiI0MDUyNDgyYTc2NzU1ODY4NjA4MTdmNzNhNTgyM2I4MzRkMTdkMjYxOTNjZjZjNjQ2ZjcwMDljZjMzNzRmMGMwIiwidGFnIjoiIn0%3D; epm_session=eyJpdiI6IlhXdXR0MTdhNzJ1cmVFa0NnTU9MR3c9PSIsInZhbHVlIjoiYk1qN1Y1NmFLYmFhNWRwM0doWjBIaUFHYVhSMmJRNjR0YSs3YjZGT3hDTFQzRFVITjZVTkp6VG5kSVdySlFlOHBGaGJMUmxWMWNpRFVjUFhQUitSK05DRTVhMWtlRWE1bnVKUzFHV2VINUl3RGtpc0FiQ1BUbU52NzZZVjlobEkiLCJtYWMiOiIyNjk0MjdiYjg5OWM1NmM4NGMwODljMTgwYjY5MDk4MDg4MmE2NzAyZDQ2MWE2OTM0MzRlYjY3NjE0ZTYyMGM0IiwidGFnIjoiIn0%3D'
      };

      var request = http.MultipartRequest('POST', Uri.parse(addWorkOrderPost));

      request.fields.addAll({
        'work_order_id': id.toString(),
        'description': description,
        'qty': qty.toString(),
        'price': price.toString(),
        'additional_instruction': additional_instruction
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      debugPrint("Data Upload error $e");
      return false;
    }
  }

  // message send

  static Future<bool> postMessageToUser(
      {required int workOrderId,
      required String memberId,
      required String vendorId,
      required String message}) async {
    var accessToken = await MyPreference.getToken();

    try {
      var headers = {'Authorization': 'Bearer $accessToken'};

      var request = http.MultipartRequest('POST', Uri.parse(postChatMessage));
      request.fields.addAll({
        "work_order_id": workOrderId.toString(),
        "message": message,
        "member_id": memberId,
        "vendor_id": vendorId
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return false;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("User Message send Error. Reason ${e.toString()}");
      }
      return false;
    }
  }
}
