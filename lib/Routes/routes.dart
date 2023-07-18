import 'package:epm/views/Auth_Sector/login_screen.dart';
import 'package:epm/views/Works_Sector/work_order_details_screen.dart';
import 'package:epm/views/Works_Sector/works_orders_screen.dart';
import 'package:get/get.dart';

class Routes{
  static String loginScreen = "/loginScreen";
  static String workOrderScreen = "/workOrderScreen";
  static String workOrderDetailsScreen = "/workOrderDetailsScreen";
}

List<GetPage> getPage = [
  GetPage(name: Routes.loginScreen, page:()=> const LoginScreen()),
  GetPage(name: Routes.workOrderScreen, page:()=> WorksOrdersScreen()),
  GetPage(name: Routes.workOrderDetailsScreen, page: ()=> const WorkOrderDetailsScreen())
  
];