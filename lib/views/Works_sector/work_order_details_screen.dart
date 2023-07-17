import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkOrderDetailsScreen extends StatelessWidget {
  const WorkOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
    );
  }
}
