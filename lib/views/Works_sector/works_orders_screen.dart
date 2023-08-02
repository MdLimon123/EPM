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

  final _workOrderController = Get.put(WorksOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Column(
        children: [
          Container(
              height: 80.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(color: AppColor.greyColor, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 1))
              ]),
              child: Row(
                children: [
                  Text(
                    'Filtered 6 of 23 results',
                    style: CustomTextStyle.h3(
                        fontWeight: FontWeight.w500,
                        color: AppColor.deepOrange),
                  ),
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    'DATE DUE',
                    style: CustomTextStyle.h2(
                        color: AppColor.deepOrange,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColor.deepOrange,
                  )
                ],
              )),
          Expanded(
            child: Obx(
              () => _workOrderController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColor.deepOrange,
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          _workOrderController.workOrderModel.data.length,
                      itemBuilder: (context, index) {
                        var item =
                            _workOrderController.workOrderModel.data[index];
                        var date =
                            Jiffy.parse('${item.contractorDueDate}').yMMMd;
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.workOrderDetailsScreen,
                                arguments: {"data": item});
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
                            margin: EdgeInsets.only(top: 10.h),
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3))
                            ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "WO#: ${item.workOrder}",
                                  style: CustomTextStyle.h2(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.deepOrange),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  item.workType.name.toString(),
                                  style: CustomTextStyle.h3(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color:
                                          AppColor.deepOrange.withOpacity(.6)),
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
                                      "Due: $date",
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
                                Text(
                                  "${item.property.address}, ${item.property.state}",
                                  style: CustomTextStyle.h2(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.deepBlack,
                                      fontSize: 16.sp),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColor.blackColor,
                                    ),
                                    Text(
                                      "${item.property.city}, ${item.property.zip}",
                                      style: CustomTextStyle.h2(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color: AppColor.deepBlack
                                              .withOpacity(.8)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          color: AppColor.deepOrange,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Icon(
                                        Icons.check,
                                        color: AppColor.checkColor,
                                      ),
                                    ),
                                    Image.asset(
                                      AppImage.refresh,
                                      height: 30.h,
                                      width: 30.h,
                                      color: AppColor.deepOrange,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: AppColor.deepOrange,
                                        ),
                                        Text(
                                          item.photos.length.toString(),
                                          style: CustomTextStyle.h3(
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.deepOrange),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }

  _appbar() {
    return AppBar(
      backgroundColor: AppColor.bgColor,
      title: Text(
        'Work Orders',
        style: CustomTextStyle.h1(color: AppColor.textColorWhite),
      ),
      centerTitle: true,
      leading:IconButton(onPressed: (){
        Get.back();
      },
       icon: Icon(Icons.arrow_back,
       color: AppColor.textColorWhite,)),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: AppColor.textColorWhite,
            ))
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: TextFormField(
              controller: _workOrderController.searchController,
              style: CustomTextStyle.h2(color: AppColor.textColorWhite),
              decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 60.h),
                  hintText: 'Search',
                  hintStyle: CustomTextStyle.h2(
                      color: AppColor.textColorWhite,
                      fontWeight: FontWeight.w500),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.textColorWhite,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _workOrderController.searchController.clear();
                    },
                    icon: Icon(Icons.clear, color: AppColor.textColorWhite),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.textColorWhite),
                      borderRadius: BorderRadius.circular(4.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.textColorWhite))),
            ),
          )),
    );
  }
}
