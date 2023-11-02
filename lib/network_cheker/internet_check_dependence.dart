import 'package:epm/network_cheker/network_controller.dart';
import 'package:get/get.dart';

class InternetCheckDependencyInjection {
  static void init() async {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
