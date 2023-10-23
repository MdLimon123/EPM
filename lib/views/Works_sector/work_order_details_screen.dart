import 'package:epm/Routes/routes.dart';
import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
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
                      'Chat',
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
                leading: Icon(
                  Icons.check,
                  color: AppColor.deepOrange,
                ),
                title: Text(
                  'Checking',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: const Color(0xFF000000)
                  ),
                ),
                subtitle: Text(
                  'Never',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6A6868)
                  ),
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
                    style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF000000)
                ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Never',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6A6868)
                        ),
                    ),
                    Text(
                      '-You must be checked in',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6A6868)
                      ),
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
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF000000)
                ),
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
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset(AppImage.status),
                    title: Text('Status',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF000000)
                        )),
                    subtitle: Text(
                        _workOrderController.workOrderModel.status == true
                            ? "Read"
                            : "Unread",
                        style: CustomTextStyle.h4(
                            fontSize: 14.sp,
                            color: const Color(0xFF6A6868),
                            fontWeight: FontWeight.w400)),
                  ),
                  Divider(
                    color: Colors.grey.shade100,
                    thickness: 2,

                  )
                ],
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
            
            Padding(
              padding:  EdgeInsets.only(left: 16.w, top: 16.h),
              child: Text('WO Instruction',
              style: TextStyle(fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000)),),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 16.sp,top: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12.sp)
              ),
              child: Text('In antiquity, a paragraph often was a single thought—and often a single sentence, usually a very long one.',
              style: TextStyle(fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF2B2B2B))),
            ),
            SizedBox(height: 30.h,)
          ],
        ),
      ),

    );
  }

  _appbar() {
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      title: Text(
        'Work Order Details',
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
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
              color: Color(0xFF000000),
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
        child: Column(
          children: [
            ListTile(
              dense: true,
              title: Text(
                title,
                style: CustomTextStyle.h3(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: const Color(0xFF000000)),
              ),
              subtitle: Text(
                subtitle,
                style: CustomTextStyle.h4(
                    color: const Color(0xFF6A6868),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
              leading: Image.asset(image),
            ),
            Divider(
              color: Colors.grey.shade100,
              thickness: 2,

            )
          ],
        ));
  }
}
