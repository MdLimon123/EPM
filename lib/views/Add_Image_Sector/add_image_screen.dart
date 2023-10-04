import 'package:cached_network_image/cached_network_image.dart';

import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/views/Add_Image_Sector/image_details_screen.dart';

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
    _addImageController.workOrder = data["workOrderId"];

    int id = _addImageController.id;
    _photoController.getPhoto(id);

    return Scaffold(
      appBar: _appBar(context),
      body: Obx(() => _photoController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColor.deepOrange,
                  ),
                )
              : Column(
        mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        onTap: () {
                          _photoController.isAllChecked.value =
                              !_photoController.isAllChecked.value;
                        },
                        dense: true,
                        title: Text(
                          'Select All',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF000000)),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Delete Image',
                                      style: CustomTextStyle.h1(
                                          color: AppColor.deepOrange,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    content: Text(
                                      'Are you sure you want to delete All Image!',
                                      style: CustomTextStyle.h3(
                                          fontWeight: FontWeight.w400),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: CustomTextStyle.h3(
                                                fontWeight: FontWeight.w400),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            // _photoController.deleteImage(
                                            //     _photoController.data[index].id,
                                            //     index);
                                            // Get.back();

                                            for(var i=0; i<_photoController.data.length; i++){
                                              _photoController.deleteImage(data[i], data[i]);

                                            }
                                          },
                                          child: Text(
                                            'Ok',
                                            style: CustomTextStyle.h3(
                                                fontWeight: FontWeight.w400),
                                          )),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            height: 28.h,
                            width: 81.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.r)),
                                border:
                                    Border.all(color: const Color(0xFFEB6526))),
                            child: Center(
                              child: Text(
                                'Delete All',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: const Color(0xFFEB6526)),
                              ),
                            ),
                          ),
                        ),
                        leading: Checkbox(
                          value: _photoController.isAllChecked.value,
                          onChanged: (value) {
                            _photoController.isAllChecked.value = value!;
                            for (int i = 0;
                                i < _photoController.data.length;
                                i++) {
                              _photoController.data[i].url = "$value";
                            }
                          },
                        )),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15.w,
                            mainAxisSpacing: 23,
                            mainAxisExtent: 250.h),
                        itemCount: _photoController.data.length,
                        itemBuilder: (context, index) {
                          var image = _photoController.data[index].url;
                          var imageUrl =
                              "https://${_photoController.photoModel.hostName}/$image";
                          return GridTile(
                            child: InkWell(
                              onTap: () {
                                Get.to(ImageDetailsScreen(image: imageUrl));
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(1.0, 1.0))
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        value:
                                            _photoController.isAllChecked.value,
                                        onChanged: (value) {
                                          _photoController.isAllChecked.value =
                                              value!;
                                          imageUrl = "$value";
                                        }),
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: imageUrl,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                          color: AppColor.deepOrange,
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Remove photo",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF000000)),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                // _photoController.deleteImage(
                                                //     _photoController.data[index].id, index);
                                                showDialog(
                                                    barrierDismissible: true,
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Delete Image',
                                                          style: CustomTextStyle.h1(
                                                              color: AppColor
                                                                  .deepOrange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        content: Text(
                                                          'Are you sure you want to delete Image!',
                                                          style: CustomTextStyle
                                                              .h3(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: Text(
                                                                'Cancel',
                                                                style: CustomTextStyle.h3(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              )),
                                                          TextButton(
                                                              onPressed: () {
                                                                _photoController
                                                                    .deleteImage(
                                                                        _photoController
                                                                            .data[index]
                                                                            .id,
                                                                        index);
                                                                Get.back();
                                                              },
                                                              child: Text(
                                                                'Ok',
                                                                style: CustomTextStyle.h3(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              )),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                  height: 35.h,
                                                  width: 35.w,
                                                  margin: EdgeInsets.only(
                                                      left: 15.w,
                                                      top: 15.w,
                                                      bottom: 5.w),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColor.deepOrange,
                                                      shape: BoxShape.circle),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color:
                                                        AppColor.textColorWhite,
                                                  ))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )

          // : ListView.builder(
          //     physics: const BouncingScrollPhysics(),
          //     itemCount: _photoController.data.length,
          //     itemBuilder: (context, index) {
          //       var image = _photoController.data[index].url;
          //       var imageUrl =
          //           "https://${_photoController.photoModel.hostName}/$image";
          //
          //       return Padding(
          //         padding: EdgeInsets.only(left: 10.w, right: 10.w),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Container(
          //               height: 250.h,
          //               width: 300.w,
          //               margin: EdgeInsets.only(top: 20.h),
          //               child: CachedNetworkImage(
          //                 imageUrl: imageUrl,
          //                 imageBuilder: (context, imageProvider) => Container(
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(8.r),
          //                       image: DecorationImage(
          //                           image: imageProvider, fit: BoxFit.cover)),
          //                 ),
          //                 errorWidget: (context, url, error) =>
          //                     const Icon(Icons.error),
          //                 placeholder: (context, url) => Center(
          //                     child: CircularProgressIndicator(
          //                   color: AppColor.deepOrange,
          //                 )),
          //               ),
          //             ),
          //             InkWell(
          //               onTap: () {
          //                 // _photoController.deleteImage(
          //                 //     _photoController.data[index].id, index);
          //                 showDialog(
          //                     barrierDismissible: true,
          //                     context: context,
          //                     builder: (context) {
          //                       return AlertDialog(
          //                         title: Text(
          //                           'Delete Image',
          //                           style: CustomTextStyle.h1(
          //                               color: AppColor.deepOrange,
          //                               fontWeight: FontWeight.w600),
          //                         ),
          //                         content: Text(
          //                           'Are you sure you want to delete Image!',
          //                           style: CustomTextStyle.h3(
          //                               fontWeight: FontWeight.w400),
          //                         ),
          //                         actions: [
          //                           TextButton(
          //                               onPressed: () {
          //                                 Get.back();
          //                               },
          //                               child: Text(
          //                                 'Cancel',
          //                                 style: CustomTextStyle.h3(
          //                                     fontWeight: FontWeight.w400),
          //                               )),
          //                           TextButton(
          //                               onPressed: () {
          //                                 _photoController.deleteImage(
          //                                     _photoController.data[index].id,
          //                                     index);
          //                                 Get.back();
          //                               },
          //                               child: Text(
          //                                 'Ok',
          //                                 style: CustomTextStyle.h3(
          //                                     fontWeight: FontWeight.w400),
          //                               )),
          //                         ],
          //                       );
          //                     });
          //               },
          //               child: Container(
          //                   height: 50.h,
          //                   width: 60.w,
          //                   margin: EdgeInsets.only(left: 15.w, top: 15.w),
          //                   decoration: BoxDecoration(
          //                       color: AppColor.deepOrange,
          //                       borderRadius: BorderRadius.circular(8.r)),
          //                   child: Icon(
          //                     Icons.delete,
          //                     color: AppColor.textColorWhite,
          //                   )),
          //             )
          //           ],
          //         ),
          //       );
          //     }),
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
        'Photos',
        style: CustomTextStyle.h1(
            color: AppColor.textColorWhite,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600),
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
                                        child: const CircularProgressIndicator(
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
