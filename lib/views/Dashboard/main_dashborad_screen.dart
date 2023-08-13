import 'package:epm/Routes/routes.dart';
import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainDashboardScreen extends StatelessWidget {
  const MainDashboardScreen({super.key});

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
      body: Obx(
        () => workOrderController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.deepOrange,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
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
                                borderRadius: BorderRadius.circular(
                                    10.r), //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 5, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25.w, vertical: 15.h),
                                    child: Image.asset(
                                      AppImage.total,
                                      color: Colors.black,
                                      height: 80.h,
                                      width: 80.w,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    'Total Work Order',
                                    style: CustomTextStyle.h3(
                                        color: AppColor.deepOrange,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${workOrderController.data.length}",
                                    style: CustomTextStyle.h3(
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      )
                      // Expanded(
                      //   child: Container(
                      //       alignment: Alignment.center,
                      //       margin: EdgeInsets.all(20.w),
                      //       height: 200.h,
                      //       width: double.infinity,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(
                      //             10.r), //border corner radius
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.grey
                      //                 .withOpacity(0.5), //color of shadow
                      //             spreadRadius: 5, //spread radius
                      //             blurRadius: 7, // blur radius
                      //             offset: const Offset(
                      //                 0, 2), // changes position of shadow
                      //           ),
                      //         ],
                      //       ),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Container(
                      //             height: 100.h,
                      //             margin:
                      //                 EdgeInsets.only(left: 15.w, top: 15.w),
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: 15.w, vertical: 15.h),
                      //             width: 100.h,
                      //             decoration: BoxDecoration(
                      //                 color: AppColor.deepOrange,
                      //                 borderRadius: BorderRadius.circular(8.r)),
                      //             child: Image.asset(
                      //               AppImage.active,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: 10.h,
                      //           ),
                      //           Text(
                      //             'Active Work Order',
                      //             style: CustomTextStyle.h3(
                      //                 color: const Color(0xFF98A6AD),
                      //                 fontWeight: FontWeight.w600),
                      //           ),
                      //           Text(
                      //             "5",
                      //             style: CustomTextStyle.h3(
                      //                 color: AppColor.blackColor,
                      //                 fontWeight: FontWeight.w700),
                      //           )
                      //         ],
                      //       )),
                      // ),
                    ],
                  ),

                  // Container(
                  //     alignment: Alignment.center,
                  //     margin: EdgeInsets.all(20.w),
                  //     height: 200.h,
                  //     width: 180.w,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius:
                  //           BorderRadius.circular(10.r), //border corner radius
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color:
                  //               Colors.grey.withOpacity(0.5), //color of shadow
                  //           spreadRadius: 5, //spread radius
                  //           blurRadius: 7, // blur radius
                  //           offset: const Offset(
                  //               0, 2), // changes position of shadow
                  //         ),
                  //       ],
                  //     ),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           height: 100.h,
                  //           margin: EdgeInsets.only(left: 15.w, top: 15.w),
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 15.w, vertical: 15.h),
                  //           width: 100.h,
                  //           decoration: BoxDecoration(
                  //               color: AppColor.deepOrange,
                  //               borderRadius: BorderRadius.circular(8.r)),
                  //           child: Image.asset(
                  //             AppImage.ready,
                  //             height: 50.h,
                  //             width: 50.w,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: 10.h,
                  //         ),
                  //         Text(
                  //           'Ready For Argent',
                  //           style: CustomTextStyle.h3(
                  //               color: const Color(0xFF98A6AD),
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //         Text(
                  //           "5",
                  //           style: CustomTextStyle.h3(
                  //               color: AppColor.blackColor,
                  //               fontWeight: FontWeight.w700),
                  //         )
                  //       ],
                  //     )),

                  // Container(
                  //     alignment: Alignment.center,
                  //     margin: EdgeInsets.all(20.w),
                  //     height: 200.h,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius:
                  //           BorderRadius.circular(10.r), //border corner radius
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color:
                  //               Colors.grey.withOpacity(0.5), //color of shadow
                  //           spreadRadius: 5, //spread radius
                  //           blurRadius: 7, // blur radius
                  //           offset: const Offset(
                  //               0, 2), // changes position of shadow
                  //         ),
                  //       ],
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           height: 150.h,
                  //           margin: EdgeInsets.only(left: 15.w),
                  //           width: 150.h,
                  //           decoration: BoxDecoration(
                  //               color: AppColor.deepOrange,
                  //               borderRadius: BorderRadius.circular(8.r)),
                  //           child: Image.asset(
                  //             AppImage.mike,
                  //             width: 60.w,
                  //             height: 60.h,
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 20.w,
                  //         ),
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               ' Active Work Order',
                  //               style: CustomTextStyle.h3(
                  //                   color: const Color(0xFF98A6AD),
                  //                   fontWeight: FontWeight.w600),
                  //             ),
                  //             Text(
                  //               "5",
                  //               style: CustomTextStyle.h3(
                  //                   color: AppColor.blackColor,
                  //                   fontWeight: FontWeight.w700),
                  //             ),
                  //           ],
                  //         )
                  //       ],
                  //     )),
                  // Container(
                  //     alignment: Alignment.center,
                  //     margin: EdgeInsets.all(20.w),
                  //     height: 200.h,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius:
                  //           BorderRadius.circular(10.r), //border corner radius
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color:
                  //               Colors.grey.withOpacity(0.5), //color of shadow
                  //           spreadRadius: 5, //spread radius
                  //           blurRadius: 7, // blur radius
                  //           offset: const Offset(
                  //               0, 2), // changes position of shadow
                  //         ),
                  //       ],
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           height: 150.h,
                  //           margin: EdgeInsets.only(left: 15.w),
                  //           width: 150.h,
                  //           decoration: BoxDecoration(
                  //               color: AppColor.deepOrange,
                  //               borderRadius: BorderRadius.circular(8.r)),
                  //           child: Image.asset(
                  //             AppImage.mike,
                  //             width: 60.w,
                  //             height: 60.h,
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 20.w,
                  //         ),
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               'Pending Work Order',
                  //               style: CustomTextStyle.h3(
                  //                   color: const Color(0xFF98A6AD),
                  //                   fontWeight: FontWeight.w600),
                  //             ),
                  //             Text(
                  //               "3",
                  //               style: CustomTextStyle.h3(
                  //                   color: AppColor.blackColor,
                  //                   fontWeight: FontWeight.w700),
                  //             ),
                  //           ],
                  //         )
                  //       ],
                  //     )),
                ],
              ),
      ),
    );
  }
}
