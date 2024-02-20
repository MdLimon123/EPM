import 'package:epm/controller/auth/login_controller.dart';
import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import '../../Routes/routes.dart';

class WorksOrdersScreen extends StatelessWidget {
  WorksOrdersScreen({super.key});

  final workOrderController = Get.put(WorksOrderController());
  final _authController = Get.put(LoginController());

  void _logout(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Icon(Icons.logout, color: Colors.white, size: 36.sp),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white, fontSize: 28.sp),
                  ),
                )
              ],
            ),
            content: Text(
              'Do you want to Log Out?',
              style: TextStyle(fontSize: 20.sp, color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.green, fontSize: 18.sp),
                  )),
              TextButton(
                  onPressed: () {
                    _authController.handleUserLogout();
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.green, fontSize: 18.sp),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          'Work Orders',
          style: CustomTextStyle.h1(color: const Color(0xFFEB6526),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();

            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF000000),
            )),
        actions: [
          IconButton(
              onPressed: () {
                _logout(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Color(0xFF000000),
              ))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: TextFormField(
              onChanged: (value) => workOrderController.searchWork(value),
              controller: workOrderController.searchController,
              style: CustomTextStyle.h2(color: AppColor.textColorWhite),
              decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 60.h),
                  hintText: 'Search',
                  hintStyle: CustomTextStyle.h2(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500),
                  prefixIcon: Icon(
                    Icons.search,
                      color: Colors.grey.shade700,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400,),
                      borderRadius: BorderRadius.circular(4.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400,))),
            ),
          ),
        ),
      ),
      body: Obx(
        () => workOrderController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.deepOrange,
                ),
              )
            : Column(
                children: [
                  Container(
                      height: 80.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 1))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DATE DUE :',
                            style: CustomTextStyle.h3(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF000000)),
                          ),

                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                                hint: Text(
                                  workOrderController.selectedValue.value,
                                  style: CustomTextStyle.h4(
                                      color: AppColor.deepOrange),
                                ),
                                items: workOrderController.dropdownList
                                    .map((selectedType) {
                                  return DropdownMenuItem(
                                    value: selectedType,
                                    child: Text(selectedType,
                                        style: CustomTextStyle.h3()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  workOrderController
                                      .setSelectedValue('$value');
                                  switch (value) {
                                    case "Expired":
                                      {
                                        print("expired");
                                        workOrderController.sortAfterDay(
                                            3, true);
                                      }
                                      break;
                                    case "3 days":
                                      workOrderController.sortAfterDay(
                                          3, false);
                                      break;
                                    case "7 days":
                                      workOrderController.sortAfterDay(
                                          7, false);
                                      break;
                                    case "15 days":
                                      workOrderController.sortAfterDay(
                                          15, false);
                                    case "more then 15 days":
                                      workOrderController.sortAfterDay(
                                          15, true);
                                      break;
                                  }
                                }),
                          ),
                          //  )
                        ],
                      )),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          workOrderController.searchController.text.isNotEmpty
                              ? workOrderController.searchData.length
                              : workOrderController.afterDayList.length,
                      itemBuilder: (context, index) {
                        var item =
                            workOrderController.searchController.text.isNotEmpty
                                ? workOrderController.searchData[index]
                                : workOrderController.afterDayList[index];
                        var date =
                            Jiffy.parse('${item.contractorDueDate}').yMMMd;
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.workOrderDetailsScreen,
                                      arguments: {"data": item});
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "WO#: ${item.workOrder}",
                                            style: CustomTextStyle.h2(
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF000000)),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            item.workType.name.toString(),
                                            style: CustomTextStyle.h3(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.sp,
                                                color: const Color(0xFF6A6868)),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                    Routes.addImageScreen,
                                                    arguments: {
                                                      "id": item.id,
                                                      "workOrderId":
                                                          item.workOrder
                                                    });
                                              },
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: const Color(0xFFF57F17),
                                                size: 30.w,
                                              )),
                                          Positioned(
                                              right: 2.w,
                                              top: 1.w,
                                              child: CircleAvatar(
                                                radius: 10.r,
                                                backgroundColor:
                                                    const Color(0xFFEB6526),
                                                child: Center(
                                                  child: Text(
                                                    item.photos.length
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp,
                                                        color: const Color(
                                                            0xFFFFFFFF)),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: AppColor.deepBlack,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "Due Date: $date",
                                    style: CustomTextStyle.h2(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp,
                                        color: AppColor.deepBlack),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.address}",
                                          style: CustomTextStyle.h2(
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF969A9E),
                                              fontSize: 16.sp),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Color(0xFF969A9E),
                                            ),
                                            // Text(
                                            //   "${item.property.city}, ${item.property.zip}",
                                            //   style: CustomTextStyle.h2(
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 16.sp,
                                            //       color:
                                            //           const Color(0xFF969A9E)),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        workOrderController.refreshScreen();
                                      },
                                      child: Image.asset(
                                        AppImage.refresh,
                                        height: 30.h,
                                        width: 30.h,
                                        color: const Color(0xFF969A9E),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // )
                ],
              ),
      ),
    );
  }

  // _appbar() {
  //   return AppBar(
  //       backgroundColor: AppColor.bgColor,
  //       title: Text(
  //         'Work Orders',
  //         style: CustomTextStyle.h1(color: AppColor.textColorWhite),
  //       ),
  //       centerTitle: true,
  //       leading: IconButton(
  //           onPressed: () {
  //             Get.back();
  //           },
  //           icon: Icon(
  //             Icons.arrow_back,
  //             color: AppColor.textColorWhite,
  //           )),
  //       actions: [
  //         IconButton(
  //             onPressed: () {},
  //             icon: Icon(
  //               Icons.menu,
  //               color: AppColor.textColorWhite,
  //             ))
  //       ],
  //       bottom: PreferredSize(
  //         preferredSize: Size.fromHeight(100.h),
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
  //           child: TextFormField(
  //             onChanged: (value) => _workOrderController.searchWork(value),
  //             controller: _workOrderController.searchController,
  //             style: CustomTextStyle.h2(color: AppColor.textColorWhite),
  //             decoration: InputDecoration(
  //                 constraints: BoxConstraints(maxHeight: 60.h),
  //                 hintText: 'Search',
  //                 hintStyle: CustomTextStyle.h2(
  //                     color: AppColor.textColorWhite,
  //                     fontWeight: FontWeight.w500),
  //                 suffixIcon: Icon(
  //                   Icons.search,
  //                   color: AppColor.textColorWhite,
  //                 ),
  //                 enabledBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: AppColor.textColorWhite),
  //                     borderRadius: BorderRadius.circular(4.r)),
  //                 focusedBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: AppColor.textColorWhite))),
  //           ),
  //         ),
  //       ));
  // }
}
