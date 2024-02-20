import 'package:epm/services/api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/work_order_model.dart';
import '../views/Add_Work_List/Models/add_work_model.dart';

class WorksOrderController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  var isLoading = false.obs;

  late WorkOrderModel workOrderModel;

  RxList<Datum> data = <Datum>[].obs;
  RxList<Datum> afterDayList = <Datum>[].obs;

  RxList<Datum> searchData = <Datum>[].obs;


  late AddWorkModel addWorkModel;

  RxList<Chat> workData = <Chat>[].obs;



  var selectedValue = 'selected'.obs;
  var dropdownList = [
    'Expired',
    '3 days',
    '7 days',
    '15 days',
    'more then 15 days'
  ];

  sortAfterDay(int day, bool isExpired) {
    searchController.clear();
    DateTime dayAgo = DateTime.now().subtract(Duration(days: day));
    List<Datum> result = data.value.where((element) {
      return isExpired
          ? element.createdAt.isAfter(dayAgo)
          : element.createdAt.isBefore(dayAgo);
    }).toList();
    afterDayList.value = result;
    print("========> after list = ${result.length}");
    afterDayList.refresh();
  }

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }

  @override
  void onInit() {
    getDataForWork();
    searchData.value = data;

    super.onInit();
  }


  fetchData(String id)async{
    isLoading(true);
    try {
      var result = await ApiServices.getEstimation(int.parse(id));

      if(result.runtimeType == int){
        debugPrint('Data Error $result');
      }else{
        addWorkModel = result;
        if(addWorkModel.chats !=null){
          workData.value = addWorkModel.chats!;

          debugPrint(addWorkModel.toString());

        }

      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    }finally{
      isLoading(false);
    }



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
        afterDayList.value = workOrderModel.data;

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

  void refreshScreen() async {
    isLoading(true);
    await Future.delayed(const Duration(milliseconds: 2000));
    getDataForWork();

    isLoading(false);
  }

  void searchWork(String workOrder) {
    List<Datum> result = <Datum>[].obs;
    if (workOrder.isEmpty) {
      result = afterDayList;
      afterDayList.refresh();
    } else {
      result = afterDayList
          .where((element) => element.workType.name
              .toString()
              .toLowerCase()
              .contains(workOrder.toLowerCase()))
          .toList();
    }
    searchData.value = result;
    searchData.refresh();
  }
}
