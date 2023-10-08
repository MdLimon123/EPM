import 'package:epm/Routes/routes.dart';
import 'package:epm/controller/works_orders_controller.dart';

import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/views/ChatScreen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../model/work_order_model.dart';

final _workOrderController = Get.put(WorksOrderController());

class WorkOrderDetailsScreen extends StatelessWidget {
  WorkOrderDetailsScreen({super.key});

  final Data data = Get.arguments["data"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60.h,
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(color: AppColor.deepOrange),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // InkWell(
                  //   onTap: () {},
                  //   child: Text(
                  //     'Chat',
                  //     style: CustomTextStyle.h3(
                  //         color: AppColor.textColorWhite,
                  //         fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addImageScreen, arguments: {
                        "id": data.id,
                        "workOrderId": data.workOrder
                      });
                    },
                    child: Text(
                      'Photos',
                      style: CustomTextStyle.h3(
                          color: AppColor.textColorWhite,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.documentScreen, arguments: {
                        "id": data.id,
                        "workOrderId": data.workOrder
                      });
                    },
                    child: Text(
                      'Documents',
                      style: CustomTextStyle.h3(
                          color: AppColor.textColorWhite,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addWorkOrderScreen);
                    },
                    child: Text(
                      'EST.',
                      style: CustomTextStyle.h3(
                          color: AppColor.textColorWhite,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.chatScreen, arguments: data);
                    },
                    child: Text(
                      'Chat.',
                      style: CustomTextStyle.h3(
                          color: AppColor.textColorWhite,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: ListTile(
                dense: true,
                leading: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: AppColor.deepOrange,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(
                    Icons.check,
                    color: AppColor.checkColor,
                  ),
                ),
                title: Text(
                  'Checking',
                  style: CustomTextStyle.h3(color: AppColor.deepOrange),
                ),
                subtitle: Text(
                  'Never',
                  style: CustomTextStyle.h4(
                      color: AppColor.deepOrange.withOpacity(.6),
                      fontWeight: FontWeight.w400),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.navigate_next,
                      color: AppColor.textColor,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Divider(
                color: AppColor.greyColor,
                height: 2.h,
                thickness: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: ListTile(
                dense: true,
                leading: Image.asset(
                  AppImage.refresh,
                  height: 30.h,
                  width: 30.w,
                  color: AppColor.deepOrange,
                ),
                title: Text(
                  'Sync',
                  style: CustomTextStyle.h3(color: AppColor.deepOrange),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Never',
                      style: CustomTextStyle.h4(
                          color: AppColor.deepOrange.withOpacity(.6),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '-You must be checked in',
                      style: CustomTextStyle.h4(
                          color: AppColor.deepOrange.withOpacity(.6),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.navigate_next,
                      color: AppColor.textColor,
                    )),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                'Work Order Info',
                style: CustomTextStyle.h3(
                    color: AppColor.deepOrange, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Divider(
              color: AppColor.greyColor,
              height: 2.h,
              thickness: 2,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: ListTile(
                leading: Image.asset(AppImage.status),
                title: Text('Status',
                    style: CustomTextStyle.h3(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: AppColor.deepOrange.withOpacity(.9))),
                subtitle: Text(
                    _workOrderController.workOrderModel.status == true
                        ? "Read"
                        : "Unread",
                    style: CustomTextStyle.h4(
                        fontSize: 14.sp,
                        color: const Color(0xFF6A6868),
                        fontWeight: FontWeight.w400)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            _customText(
                title: 'WO#', subtitle: data.workOrder, image: AppImage.work),
            SizedBox(
              height: 10.h,
            ),
            _customText(
                title: 'PPW#', subtitle: data.workTypeId, image: AppImage.city),
            SizedBox(
              height: 10.h,
            ),
            _customText(
                title: 'Work Type',
                subtitle: data.workType.name,
                image: AppImage.work),
            SizedBox(
              height: 10.h,
            ),
            _customText(
                title: 'Address',
                subtitle: data.property.address,
                image: AppImage.address),
            SizedBox(
              height: 10.h,
            ),
            _customText(
                title: 'City/State/Zip',
                subtitle: data.property.city,
                image: AppImage.city),
            SizedBox(
              height: 10.h,
            ),
            _customText(
                title: 'Date Due',
                subtitle: Jiffy.parse(data.property.createdAt.toString()).yMMMd,
                image: AppImage.date),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }

  _appbar() {
    return AppBar(
      backgroundColor: AppColor.bgColor,
      title: Text(
        'Work Order Detail',
        style: CustomTextStyle.h1(color: AppColor.textColorWhite),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: AppColor.textColorWhite,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: AppColor.textColorWhite,
          ),
        )
      ],
    );
  }

  _customText(
      {required String title,
      required String subtitle,
      required String image}) {
    return Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: ListTile(
          dense: true,
          title: Text(
            title,
            style: CustomTextStyle.h3(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: AppColor.deepOrange.withOpacity(.9)),
          ),
          subtitle: Text(
            subtitle,
            style: CustomTextStyle.h4(
                color: const Color(0xFF6A6868),
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
          ),
          leading: Image.asset(image),
        ));
  }
}
