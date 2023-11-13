import 'package:epm/services/api_services.dart';

import 'package:epm/views/Add_Work_List/Models/wor_estimation_model.dart';

import 'package:flutter/foundation.dart';
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

// update data text field
  final TextEditingController upItemController = TextEditingController();

  final TextEditingController upQntController = TextEditingController();

  final TextEditingController upPriceController = TextEditingController();

  final TextEditingController upComController = TextEditingController();

  final TextEditingController upTotalController = TextEditingController();

  void updateTotal() {
    int quantity = int.tryParse(qntController.text) ?? 0;
    double price = double.tryParse(priceController.text) ?? 0;

    double totalPrice = quantity * price;

    totalController.text = totalPrice.toStringAsFixed(2);
  }

  void updateTotalPrice() {
    int quantity = int.tryParse(upQntController.text) ?? 0;
    double price = double.tryParse(upPriceController.text) ?? 0;

    double totalPrice = quantity * price;

    upTotalController.text = totalPrice.toStringAsFixed(2);
  }


  textClear(){
    itemController.clear();
    qntController.clear();
    priceController.clear();
    comController.clear();
    totalController.clear();
  }




  fetchData(int id) async {
    isLoading(true);
    try {
      var result = await ApiServices.getWorkEstimation(id);

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

  Future<void> deleteEstimation(int index) async {
    isLoading(true);
    try {
      var result = await ApiServices.deleteEstimation(estimationList[index].id);

      if (result.runtimeType == int) {
        if (kDebugMode) {
          print('Delete Failed : $result');
          Get.snackbar('Delete Estimation', 'Failed',
              backgroundColor: Colors.white);
        } else {
          if(index >= 0 && index < estimationList.length){
            print("Delete >>>>>>>>");
            estimationList.removeAt(index);

            Fluttertoast.showToast(msg: 'Data Deleted success',
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.black);
          }

        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Not Delete Estimation ${e.toString()}");
      }
    }finally{
      isLoading(false);
    }
  }

  updateEstimation(int id, int index) async {
    isLoading(true);
    try {
      var result = await ApiServices.updateEstimation(
          id: id,
          item: upItemController.text,
          qty: upQntController.text,
          contractor_price: upPriceController.text,
          contractor_total: upTotalController.text,
          comment: upComController.text);

      if (result) {
        estimationList.value[index].item = upItemController.text;
        estimationList.value[index].qty = int.parse(upQntController.text);
        estimationList.value[index].contractorPrice = int.parse(upPriceController.text);
        estimationList.value[index].contractorTotal = int.parse(upTotalController.text);
        estimationList.refresh();
        print('Update Data success $result');
        Fluttertoast.showToast(msg: 'Estimation Update success');
        Get.back();
      } else {
        print('Data update Failed $result');
        Fluttertoast.showToast(msg: 'Update send failed');
      }
    } on Exception catch (e) {
      print('Data Update failed. Reason${e.toString()}');
      Fluttertoast.showToast(msg: 'Data Update failed');
    } finally {
      isLoading(false);
    }
  }

  uploadEstimation(int id, int vendorId) async {
    isLoading(true);
    try {
      var result = await ApiServices.uploadEstimation(
          work_order_id: id,
          item: itemController.text,
          qty: qntController.text,
          contractor_price: priceController.text,
          contractor_total: totalController.text,
          comment: comController.text,
          vendor_id: vendorId.toString());

      if (result) {
        print('data upload success $result');
        Fluttertoast.showToast(msg: 'Estimation upload success');

        Get.toNamed(Routes.workAddScreen, arguments: orderData);
        textClear();
      } else {
        print('Data upload Failed $result');
        Fluttertoast.showToast(msg: 'Upload send failed');
      }
    } on Exception catch (e) {
      print('Data Upload failed. Reason${e.toString()}');
      Fluttertoast.showToast(msg: 'Data Upload failed');
    } finally {
      isLoading(false);
    }
  }
}
