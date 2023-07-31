import 'package:epm/Routes/routes.dart';
import 'package:epm/controller/auth/login_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';

import 'package:epm/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        title: Text(
          'User Login',
          style: CustomTextStyle.h1(color: AppColor.textColorWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: CustomTextStyle.h3(color: AppColor.deepOrange),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextField(
                  controller: _loginController.emailController,
                  hintText: 'email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is Empty";
                    } else if (value.contains('@') && !value.contains('.')) {
                      return 'Invalid Your Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Password',
                  style: CustomTextStyle.h3(color: AppColor.deepOrange),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextField(
                  controller: _loginController.passwordController,
                  hintText: 'password',
                  obsecure: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is Empty';
                    } else if (value.length < 6) {
                      return 'Password must be 6 character';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
            
                SizedBox(
                  height: 25.h,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _loginController.userLogin(
                          email: _loginController.emailController.text,
                          password: _loginController.passwordController.text);
                    }
                  },
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.deepOrange,
                        borderRadius: BorderRadius.circular(7.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textColorWhite),
                        ),
                        SizedBox(
                          width: _loginController.isLoading.value ? 15.w : 0,
                        ),
                        Obx(() {
                          if (_loginController.isLoading.value) {
                            return SizedBox(
                              height: 15.sp,
                              width: 15.sp,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        })
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.forgetPasswordScreen);
                    },
                    child: Text(
                      'Forget Password?',
                      style: CustomTextStyle.h3(
                          color: AppColor.deepOrange,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
