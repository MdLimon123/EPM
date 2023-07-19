import 'package:epm/Routes/routes.dart';
import 'package:epm/controller/add_image_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkOrderDetailsScreen extends StatelessWidget {
  const WorkOrderDetailsScreen({super.key});


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
                style: CustomTextStyle.h3(
                  color: AppColor.deepOrange
                ),
              ),
              subtitle: Text(
                'Never',
                style: CustomTextStyle.h4(
                    color: AppColor.deepOrange.withOpacity(.6), fontWeight: FontWeight.w400),
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
                style: CustomTextStyle.h3(
                  color: AppColor.deepOrange
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Never',
                    style: CustomTextStyle.h4(
                        color: AppColor.deepOrange.withOpacity(.6), fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '-You must be checked in',
                    style: CustomTextStyle.h4(
                         color: AppColor.deepOrange.withOpacity(.6), fontWeight: FontWeight.w400),
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
            _customText(
              title: 'Status',
              subtitle: 'Unread'
            ),
            SizedBox(height: 10.h,),
               _customText(
              title: 'WO#',
              subtitle: '12345'
            ),
               SizedBox(height: 10.h,),
               _customText(
              title: 'PPW#',
              subtitle: '5720'
            ),
                SizedBox(height: 10.h,),
               _customText(
              title: 'Work Type',
              subtitle: 'Inspection'
            ),
                SizedBox(height: 10.h,),
               _customText(
              title: 'Address',
              subtitle: '555 Main St'
            ),
                  SizedBox(height: 10.h,),
               _customText(
              title: 'City/State/Zip',
              subtitle: 'Small Town,CA 12345'
            ),
                  SizedBox(height: 10.h,),
               _customText(
              title: 'Loan Info',
              subtitle: '123456789-10'
            ),
              _customText(
              title: 'Client Company',
              subtitle: 'PPW Client'
            ),
               _customText(
              title: 'Customer',
              subtitle: 'Local Credit Union'
            ),
               _customText(
              title: 'Date Received',
              subtitle: '03/21/2018'
            ),
               _customText(
              title: 'Date Due',
              subtitle: '00/00/0000'
            ),
              _customText(
              title: 'Missing Info',
              subtitle: 'No'
            ),
            SizedBox(height: 15.h,),
            Container(
              height: 60.h,
              width: double.infinity,
              padding: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                color: AppColor.deepOrange
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addImageScreen);
                    },
                    child: Text('PHOTOS',
                    style: CustomTextStyle.h3(
                      color: AppColor.textColorWhite,
                      fontWeight: FontWeight.w500
                    ),),
                  ),
                  
                    Text('BD/COMP',
                  style: CustomTextStyle.h3(
                    color: AppColor.textColorWhite,
                    fontWeight: FontWeight.w500
                  ),),
                     
                    Text('FORMS',
                  style: CustomTextStyle.h3(
                    color: AppColor.textColorWhite,
                    fontWeight: FontWeight.w500
                  ),),
                     
                    Text('NOTES',
                  style: CustomTextStyle.h3(
                    color: AppColor.textColorWhite,
                    fontWeight: FontWeight.w500
                  ),),
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
                style: CustomTextStyle.h3(fontWeight: FontWeight.w500,
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
