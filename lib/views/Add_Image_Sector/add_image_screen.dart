


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
                itemCount: _photoController.photoModel.data.length,
                itemBuilder: (context, index) {
                  var image = _photoController.photoModel.data[index].url;
                  var imageUrl =
                      "https://${_photoController.photoModel.hostName}/$image";
            
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          height: 250.h,
                          width: 350.w,
                          margin: EdgeInsets.only(top: 10.h),
                        
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(image: NetworkImage(imageUrl,
                            ),
                            fit: BoxFit.contain)
                          ),
                        //  child: Image.network(imageUrl)
                        ),
                        IconButton(onPressed: (){
                          _addImageController.deleteImage(_photoController.photoModel.data[index].id);
                        },
                         icon: Icon(Icons.delete,
                         color: AppColor.deepOrange,))
                      ],
                    );
                  

                  // final image =
                  //     _workOrderController.workOrderModel.data[index].photos;
                  // var baseUrl = "https://epm.essential-infotech.com/";

                  // for (var element in image) {

                  //   if (element.url != null) {
                  //     return Container(
                  //       height: 400.h,
                  //       width: double.infinity,
                  //       child: Image.network(baseUrl+element.url.toString(),

                  //       fit: BoxFit.cover,),
                  //     );
                  //   }
                  // }
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
                          SizedBox(
                            height: 15.h,
                          ),
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
