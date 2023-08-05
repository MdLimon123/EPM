


import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';


import '../../controller/add_image_controller.dart';
import '../../controller/photo_controller.dart';

class AddImageScreen extends StatelessWidget {
  AddImageScreen({super.key});

  final _addImageController = Get.put(AddImageController());

  final _photoController = Get.put(PhotoController());

  final Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    _addImageController.id = data["id"];

    int id = _addImageController.id;
    _photoController.getPhoto(id);

    return Scaffold(
      appBar: _appBar(context),
      body: Obx(
        () => _photoController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.deepOrange,
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _photoController.data.length,
                itemBuilder: (context, index) {
                  var image = _photoController.data[index].url;
                  var imageUrl =
                      "https://${_photoController.photoModel.hostName}/$image";
            
                    return Padding(
                      padding:  EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                             height: 250.h,
                            width: 300.w,
                            margin: EdgeInsets.only(top: 20.h),
                          
                            child: 
                            CachedNetworkImage(imageUrl: imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(image: imageProvider,
                                fit: BoxFit.cover)
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            placeholder: (context, url) =>  Center(child: CircularProgressIndicator(
                              color: AppColor.deepOrange,
                            )),),
                          
                          ),
                          InkWell(
                            onTap: () {
                              _photoController.deleteImage(_photoController.data[index].id,index);
                            },
                            child: Container(
                                height: 50.h,
                                width: 60.w,
                                margin: EdgeInsets.only(left: 15.w, top: 15.w),
                                decoration: BoxDecoration(
                                  color: AppColor.deepOrange,
                                  borderRadius: BorderRadius.circular(8.r)
                                ),
                              child: Icon(Icons.delete,
                              color: AppColor.textColorWhite,)
                              
                         
                            ),
                          )
                        ],
                      ),
                    );
                  
                }),
      ),
    );
  }

_appBar(BuildContext context) {
    return AppBar(
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
                        
                          TextButton(
                              onPressed: () {
                                _addImageController.pickImageCamera();
                              },
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
    );
  }
}
