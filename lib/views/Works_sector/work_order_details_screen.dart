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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
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
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Divider(
                color: AppColor.greyColor,
                height: 2.h,
                thickness: 2,
              ),
            ),
            ListTile(
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
              padding: EdgeInsets.only(left: 20.w),
              child: Text('Status',
                  style: CustomTextStyle.h3(
                      fontWeight: FontWeight.w500,
                      color: AppColor.deepOrange.withOpacity(.9))),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                  _workOrderController.workOrderModel.status == true
                      ? "Read"
                      : "Unread",
                  style: CustomTextStyle.h4(
                      color: AppColor.deepBlack, fontWeight: FontWeight.w400)),
            ),

            // _customText(title: 'Status', subtitle: 'Unread'),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'WO#', subtitle: data.workOrder),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'PPW#', subtitle: data.workTypeId),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'Work Type', subtitle: data.workType.name),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'Address', subtitle: data.property.address),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'City/State/Zip', subtitle: data.property.city),
            SizedBox(
              height: 10.h,
            ),

            _customText(
                title: 'Date Due',
                subtitle:
                    Jiffy.parse(data.property.createdAt.toString()).yMMMd),

            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 60.h,
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(color: AppColor.deepOrange),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Chat',
                      style: CustomTextStyle.h3(
                          color: AppColor.textColorWhite,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
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
                    onTap: () {},
                    child: Text(
                      'Invoice.',
                      style: CustomTextStyle.h3(
                          color: AppColor.textColorWhite,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )
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

  _customText({required String title, required String subtitle}) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyle.h3(
                fontWeight: FontWeight.w500,
                color: AppColor.deepOrange.withOpacity(.9)),
          ),
          Text(
            subtitle,
            style: CustomTextStyle.h4(
                color: AppColor.deepBlack, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5.h,
          ),
          Divider(
            color: AppColor.greyColor,
            height: 2.h,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
