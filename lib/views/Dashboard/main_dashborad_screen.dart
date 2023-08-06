import 'package:epm/Routes/routes.dart';
import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainDashboardScreen extends StatelessWidget {
  MainDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workOrderController = Get.put(WorksOrderController());
    workOrderController.getDataForWork();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        title: Text(
          'Dashboard',
          style: CustomTextStyle.h1(color: AppColor.textColorWhite),
        ),
        centerTitle: true,
      ),
      body: Obx(()=>workOrderController.isLoading.value?Center(child: CircularProgressIndicator(
        color: AppColor.deepOrange,
      ),)
         : InkWell(
          onTap: () {
            Get.toNamed(Routes.workOrderScreen);
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20.w),
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r), //border corner radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 150.h,
                    margin: EdgeInsets.only(left: 15.w),
                    width: 150.h,
                    decoration: BoxDecoration(
                        color: AppColor.deepOrange,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Image.asset(
                      AppImage.mike,
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Work Order',
                        style: CustomTextStyle.h3(
                            color: const Color(0xFF98A6AD),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${workOrderController.data.length}",
                        style: CustomTextStyle.h3(
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
