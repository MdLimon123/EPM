import 'dart:io';

import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/add_image_controller.dart';

class AddImageScreen extends StatelessWidget {
  AddImageScreen({super.key});

  final _addImageController = Get.put(AddImageController());

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
          'Add Image',
          style: CustomTextStyle.h1(color: AppColor.textColorWhite),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Add Image',
                          style: CustomTextStyle.h3(
                            color: AppColor.blackColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            TextButton(
                                onPressed: () async {
                                  _addImageController.pickImageGallery();
                                  await _addImageController.selectDate();
                                },
                                child: Text(
                                  'Gallery',
                                  style: CustomTextStyle.h4(),
                                )),
                            SizedBox(
                              height: 15.h,
                            ),
                           TextButton(
                                onPressed: () async {
                                  _addImageController.pickImageCamera();
                                  await _addImageController.selectDate();
                                },
                                child: Text(
                                  'Camera',
                                  style: CustomTextStyle.h4(),
                                )),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Cancel',
                                style: CustomTextStyle.h4(),
                              )),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Ok',
                                style: CustomTextStyle.h4(),
                              ))
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.adaptive.more,
                color: AppColor.textColorWhite,
              ))
        ],
      ),
      body: Obx(
        () => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _addImageController.selectedImage.length,
            itemBuilder: (context, index) {
              final image = _addImageController.selectedImage[index];
              return ListTile(
                title: Image.file(
                  File(image.path),
                  fit: BoxFit.cover,
                ),
                subtitle: Obx(
                  () => Text(
                    _addImageController.selectedDate.value,
                    style: CustomTextStyle.h4(color: AppColor.blackColor),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
