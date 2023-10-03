import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../utils/app_color.dart';
import '../../utils/text_style.dart';

class ImageDetailsScreen extends StatelessWidget {

   ImageDetailsScreen({super.key, required this.image});

final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.textColorWhite,
            )),
        title: Text(
          'Image',
          style: CustomTextStyle.h1(color: AppColor.textColorWhite,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 490.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image,
                  ),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r)
                )
              ),
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date Due:',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF000000)
                ),),

                Text('03-10-2023',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6A6868)
                  ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
