import 'package:epm/Routes/routes.dart';

import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkOrderDetailsScreen extends StatelessWidget {
  WorkOrderDetailsScreen({super.key});

  final Map data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    String workOrder = data["work_order"];
    String workTypeId = data["work_type_id"];
    String workType = data["work_type"];
    String address = data["property"];
    String city = data["property"];
  //  String receiceDate = data["contractor_receive_date"];
    String dueDate = data["contractor_due_date"];
    //String workTypeId = data[""];
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
        

            _customText(title: 'Status', subtitle: 'Unread'),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'WO#', subtitle: workOrder),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'PPW#', subtitle: workTypeId),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'Work Type', subtitle: workType),
            SizedBox(
              height: 10.h,
            ),
            _customText(title: 'Address', subtitle: address),
            SizedBox(
              height: 10.h,
            ),
            _customText(
                title: 'City/State/Zip', subtitle: city),
            SizedBox(
              height: 10.h,
            ),
            // _customText(title: 'Loan Info', subtitle: '123456789-10'),
            // _customText(title: 'Client Company', subtitle: 'PPW Client'),
            // _customText(title: 'Customer', subtitle: 'Local Credit Union'),
            //_customText(title: 'Date Received', subtitle:receiceDate.toString()),
            _customText(title: 'Date Due', subtitle: dueDate.toString()),
            // _customText(title: 'Missing Info', subtitle: 'No'),
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
                      Get.toNamed(Routes.addImageScreen);
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
                      Get.toNamed(Routes.documentScreen);
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
                      'Em.',
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
