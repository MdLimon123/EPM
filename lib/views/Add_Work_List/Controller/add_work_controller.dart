
import 'package:epm/services/api_services.dart';

import 'package:epm/views/Add_Work_List/Models/wor_estimation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Routes/routes.dart';
import '../../../model/work_order_model.dart';

class AddWorkController extends GetxController {
  var isLoading = false.obs;

  late WorkEstimationModel workEstimationModel;

  RxList<Estimation> estimationList = <Estimation>[].obs;

  final Data orderData = Get.arguments;

  final TextEditingController itemController = TextEditingController();

  final TextEditingController qntController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController comController = TextEditingController();

  final TextEditingController totalController = TextEditingController();

  @override
  void onInit() {
    //fetchData(orderData.id.toString());
    super.onInit();
  }


  void updateTotal() {
    int quantity = int.tryParse(qntController.text) ?? 0;
    double price = double.tryParse(priceController.text) ?? 0;


    double totalPrice = quantity * price;

    totalController.text = totalPrice.toStringAsFixed(2);
  }

  textFiledClear() {
    itemController.clear();
    qntController.clear();
    priceController.clear();
    totalController.clear();
    comController.clear();
  }

  fetchData(String id) async {
    isLoading(true);
    try {
      var result = await ApiServices.getWorkEstimation(int.parse(id));

      if (result.runtimeType == int) {
        debugPrint('Data error $result');
      } else {
        workEstimationModel = result;
        estimationList.value = workEstimationModel.estimations;
        debugPrint(workEstimationModel.toString());
      }
    } on Exception catch (e) {
      debugPrint("Fetch error : $e");
    } finally {
      isLoading(false);
    }
  }

  // fetchData(String id)async{
  //   isLoading(true);
  //   try {
  //     var result = await ApiServices.getEstimation(int.parse(id));
  //
  //     if(result.runtimeType == int){
  //       debugPrint('Data Error $result');
  //     }else{
  //       addWorkModel = result;
  //       data.value = addWorkModel.chats;
  //
  //       debugPrint(addWorkModel.toString());
  //     }
  //   } on Exception catch (e) {
  //     debugPrint("Fetch error : $e");
  //   }finally{
  //     isLoading(false);
  //   }
  //
  //
  //
  // }

  uploadEstimation(int id) async {
    isLoading(true);
    try {
      var result = await ApiServices.uploadEstimation(
          work_order_id: id,
          item: itemController.text,
          qty: qntController.text,
          contractor_price: priceController.text,
          contractor_total: totalController.text,
          comment: comController.text);

      if (result) {
        print('data upload success $result');
        Fluttertoast.showToast(msg: 'Estimation upload success');

        Get.toNamed(Routes.workAddScreen, arguments: orderData);

        textFiledClear();
      } else {
        print('Data upload Failed');
        Fluttertoast.showToast(msg: 'Upload send failed');
      }
    } on Exception catch (e) {
      print('Data Upload failed. Reason${e.toString()}');
      Fluttertoast.showToast(msg: 'Data Upload failed');
    } finally {
      isLoading(false);
    }
  }

  uploadData(int id) async {
    isLoading(true);

    try {
      var result = await ApiServices.uploadWork(
          id: id,
          description: itemController.text,
          qty: qntController.text,
          price: priceController.text,
          additional_instruction: comController.text);


      if (result) {
        print('data upload success $result');


        Get.toNamed(Routes.workAddScreen, arguments: orderData);

        textFiledClear();


      }else{
        debugPrint('Data upload Failed');

      }

        Fluttertoast.showToast(msg: 'Upload send failed');

    } on Exception catch (e) {
      debugPrint('Data Upload failed. Reason${e.toString()}');
      Fluttertoast.showToast(msg: 'Data Upload failed');
    } finally {
      isLoading(false);
    }
  }
}
