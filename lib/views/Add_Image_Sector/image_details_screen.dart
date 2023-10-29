import 'package:epm/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/text_style.dart';

class ImageDetailsScreen extends StatelessWidget {

   ImageDetailsScreen({super.key, required this.image});

final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: const Color(0xFFF7F8F9),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF000000),
            )),
        title: Text(
          'Image',
          style: CustomTextStyle.h1(color: const Color(0xFFEB6526),
              fontSize: 20.sp,
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
              children: [
               Container(
                 height: 45.h,
                 width: 45.h,
                 decoration:  BoxDecoration(
                   shape: BoxShape.circle,
                   color: const Color(0xFFEB6526),
                   image: DecorationImage(image: AssetImage(AppImage.calender))
                 ),
               ),
                SizedBox(width: 5.w,),
                Text('03-10-2023',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000000)
                  ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
