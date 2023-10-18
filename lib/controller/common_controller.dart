import 'package:epm/local_storage/my_preference.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  var role = "".obs;
  var userId = (-1).obs;

  setData({required int id, required String roleD}) async {
    role.value = roleD;
    userId.value = id;
    print("user id ${userId.value}");
    MyPreference.setInt(key: Constance.userId, value: id);
    MyPreference.setString(key: Constance.role, value: roleD);
  }
}
