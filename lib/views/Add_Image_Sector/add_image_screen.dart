import 'dart:io';


import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../controller/add_image_controller.dart';


class AddImageScreen extends StatelessWidget {
  AddImageScreen({super.key});

  final _addImageController = Get.put(AddImageController());

  final _workOrderController = Get.put(WorksOrderController());

  List imageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.textColorWhite,
            )),
        title: Text(
          'All Image',
          style: CustomTextStyle.h1(color: AppColor.textColorWhite),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    isDismissible: true,
                    backgroundColor: const Color(0xFFFFFFFF),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r))),
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 17.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                                onPressed: () {
                                  _addImageController.pickImageGallery();
                                },
                                child: Text(
                                  'Gallery',
                                  style: CustomTextStyle.h3(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.deepOrange),
                                )),
                            SizedBox(
                              height: 15.h,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Camera',
                                  style: CustomTextStyle.h3(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.deepOrange),
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: () {
                                _addImageController.uploadImage();
                              },
                              child: Container(
                                height: 50.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColor.deepOrange,
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Save',
                                      style: CustomTextStyle.h3(
                                          color: AppColor.textColorWhite),
                                    ),
                                    SizedBox(
                                      width: _addImageController.isLoading.value
                                          ? 15.w
                                          : 0,
                                    ),
                                    Obx(() {
                                      if (_addImageController.isLoading.value) {
                                        return SizedBox(
                                          height: 15.sp,
                                          width: 15.sp,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    })
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.adaptive.more,
                color: AppColor.textColorWhite,
              ))
        ],
      ),
// https://epm.essential-infotech.com/uploads/work-order-photos/{work_order}/{photo}

      body:ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _workOrderController.workOrderModel.data!.length,
            itemBuilder: (context, index) {
              //var name = _workOrderController.workOrderModel.data.work_order;
              final image = _workOrderController.workOrderModel.data![index].photos;
            image!.forEach((element) {
               element.photo; 
               print(element.photo);
               print(element.id);
               imageList.add("https://epm.essential-infotech.com/uploads/work-order-photos/120/${element.photo}");
               
              },);
              return ListTile(
               title: Image(image: NetworkImage(imageList.toString(),
               scale:1.0 )),
                subtitle: Obx(
                  () => Text(
                    _addImageController.selectedDate.value,
                    style: CustomTextStyle.h4(color: AppColor.blackColor),
                  ),
                ),
              );
            }),
      
   
   
    );
  }
}
