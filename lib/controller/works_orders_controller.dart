import 'package:epm/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/work_order_model.dart';

class WorksOrderController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  var isLoading = false.obs;

  late WorkOrderModel workOrderModel  ;

  RxList<Data> data = <Data>[].obs;



  @override
  void onInit() {
    getDataForWork();
    super.onInit();
  }

// user work order data
  getDataForWork() async {
    isLoading(true);
    try {
      var result = await ApiServices.fetchWorkOrders();
      if (result.runtimeType == int) {
        if (kDebugMode) {
          print('Error $result');
          print('Error Data');
        }
      } else {
        workOrderModel = result;
        data.value = workOrderModel.data;
        if (kDebugMode) {
          print(workOrderModel);
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Fetch Error $e');
      }
    } finally {
      isLoading(false);
    }
  }
}
