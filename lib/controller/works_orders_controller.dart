import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorksOrderController extends GetxController{

  final TextEditingController searchController = TextEditingController();

  var showCloseIcon = false.obs;

  var isHovering = false.obs;

  void onEnter(){
    isHovering.value = true;
  }
  void onExit(){
    isHovering.value = false;
  }

}