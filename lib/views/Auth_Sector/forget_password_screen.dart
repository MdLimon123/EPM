import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/widgets/custom_button.dart';
import 'package:epm/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        title: Text('Reset Password',
        style: CustomTextStyle.h1(
          color: AppColor.textColorWhite
        ),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
         icon: Icon(Icons.arrow_back,
         color: AppColor.textColorWhite,)),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username/E-mail',
            style: CustomTextStyle.h3(
              color: AppColor.deepOrange
            ),),
            SizedBox(height: 15.h,),
            const CustomTextField(
              obsecure: true,
              hintText: 'Username/E-mail',
            ),
            SizedBox(height: 20.h,),
            PrimaryButton(title: "Reset",
             onPressed: (){})
          ],
        ),
      ),
    );
  }
}