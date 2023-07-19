import 'package:epm/Routes/routes.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/widgets/custom_button.dart';
import 'package:epm/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        title: Text('User Login',
        style: CustomTextStyle.h1(
          color: AppColor.textColorWhite
        ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username',
              style: CustomTextStyle.h3(
                color: AppColor.deepOrange
              ),),
              SizedBox(height: 15.h,),
               CustomTextField(
                hintText: 'username',
                validator: (value) {
                  
                },
              ),
              SizedBox(height: 15.h,),
               Text('Password',
              style: CustomTextStyle.h3(
                color: AppColor.deepOrange
              ),),
              SizedBox(height: 15.h,),
               CustomTextField(
                hintText: 'password',
                obsecure: true,
                validator: (value) {
                  
                },
              ),
                SizedBox(height: 15.h,),
               Text('System ID (Optional)',
              style: CustomTextStyle.h3(
                color: AppColor.deepOrange
              ),),
              SizedBox(height: 15.h,),
               CustomTextField(
                hintText: 'id',
                obsecure: true,
                validator: (value) {
                  
                },
              ),
      
              SizedBox(height: 25.h,),
      
              PrimaryButton(title: 'LOGIN',
               onPressed:(){
                Get.toNamed(Routes.workOrderScreen);
               }),
      
               TextButton(
                onPressed: (){
                  Get.toNamed(Routes.forgetPasswordScreen);
                },
                child: Text('Forget Password?',
                style: CustomTextStyle.h3(
                  color: AppColor.deepOrange,
                  fontWeight: FontWeight.w500
                ),)
                )
      
            ],
          ),
        ),
      ),
    );
  }
}