import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
   
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // handle login method
  
}