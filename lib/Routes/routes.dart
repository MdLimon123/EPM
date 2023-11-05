import 'package:epm/views/Add_Image_Sector/add_image_screen.dart';
import 'package:epm/views/Add_Work_List/update_work_screen.dart';


import 'package:epm/views/Auth_Sector/login_screen.dart';
import 'package:epm/views/ChatScreen/chat_screen.dart';
import 'package:epm/views/Dashboard/main_dashborad_screen.dart';
import 'package:epm/views/Document_Sector/document_screen.dart';


import 'package:epm/views/Works_Sector/work_order_details_screen.dart';
import 'package:epm/views/Works_Sector/works_orders_screen.dart';
import 'package:get/get.dart';

import '../views/Add_Work_List/add_work_orders_screen.dart';
import '../views/Add_Work_List/work_add_screen.dart';

class Routes {
  static String loginScreen = "/loginScreen";
  static String workOrderScreen = "/workOrderScreen";
  static String workOrderDetailsScreen = "/workOrderDetailsScreen";

  static String addImageScreen = "/addImageScreen";
  static String addWorkOrderScreen = "/addWorkOrderScreen";
  static String documentScreen = "/documentScreen";
  static String mainDashboardScreen = "/mainDashboardScreen";
  static String imageDetailsScreen = "/imageDetailsScreen";
  static String chatScreen = "/chatScreen";
  static String workAddScreen = "/workAddScreen";
  static String addWorkOrder = "/addWorkOrder";
  static String updateWorkOrder = "/updateWorkOrder";
}

List<GetPage> getPage = [
  GetPage(name: Routes.loginScreen, page: () => LoginScreen()),
  GetPage(name: Routes.workOrderScreen, page: () => WorksOrdersScreen()),
  GetPage(
      name: Routes.workOrderDetailsScreen,
      page: () => const WorkOrderDetailsScreen()),
  GetPage(name: Routes.addImageScreen, page: () => AddImageScreen()),
  GetPage(name: Routes.addWorkOrderScreen, page: () => AddWorkOrderScreen()),
  GetPage(name: Routes.documentScreen, page: () => DocumentScreen()),
  GetPage(name: Routes.mainDashboardScreen, page: () => const MainDashboardScreen()),
  GetPage(name: Routes.chatScreen, page: () => ChatScreen()),
  GetPage(name: Routes.workAddScreen, page: ()=> WorkAddScreen()),
  GetPage(name: Routes.addWorkOrder, page: ()=> AddWorkOrderScreen()),
  // GetPage(name: Routes.updateWorkOrder, page:()=> UpdateWorkScreen())
];
