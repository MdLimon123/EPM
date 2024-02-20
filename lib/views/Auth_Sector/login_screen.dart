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
        backgroundColor:const Color(0xFFFFFFFF),
        automaticallyImplyLeading: false,
        title: Text(
          'User Login',
          style: CustomTextStyle.h1(color: const Color(0xFFEB6526),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
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
                  style: CustomTextStyle.h3(color: const Color(0xFFAAAAAA),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextField(
                  controller: _loginController.userNameController,
                  hintText: 'username',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is Empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Password',
                  style: CustomTextStyle.h3(color: const Color(0xFFAAAAAA),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Obx(
                  () => CustomTextField(
                    controller: _loginController.passwordController,
                    hintText: 'password',
                    obsecure: !_loginController.isVisibility.value,
                    suffixIcon: Obx(
                      () => InkWell(
                          onTap: () {
                            _loginController.isVisibility.value =
                                !_loginController.isVisibility.value;
                          },
                          child: Icon(!_loginController.isVisibility.value
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is Empty';
                      }
                      return null;
                    },
                  ),
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
                          userName: _loginController.userNameController.text,
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
                // TextButton(
                //     onPressed: () async {

                //     },
                //     child: Text(
                //       'Mail',
                //       style: CustomTextStyle.h3(
                //           color: AppColor.deepOrange,
                //           fontWeight: FontWeight.w500),
                //     ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
