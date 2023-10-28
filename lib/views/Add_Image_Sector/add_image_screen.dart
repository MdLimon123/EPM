import 'package:cached_network_image/cached_network_image.dart';
import 'package:epm/model/photo_model.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/views/Add_Image_Sector/image_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import '../../controller/add_image_controller.dart';
import '../../controller/photo_controller.dart';

class AddImageScreen extends StatefulWidget {
  AddImageScreen({super.key});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
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
                Row(
                  children: [
                    Checkbox(
                      focusColor: AppColor.deepOrange,
                      checkColor: Colors.white,
                      activeColor: AppColor.deepOrange,
                      value: _photoController.isAllSelectedData.value,
                      onChanged: (value) {
                        if (_photoController.isAllSelectedData.value) {
                          _photoController.isAllUnSelected();
                        } else {
                          _photoController.isAllSelected();
                        }
                      },
                    ),
                    //SizedBox(width: 5.w,),
                    Text(
                      'Select All',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000)),
                    ),
                    SizedBox(width: 70.w),

                    _photoController.isVisible.value.isNotEmpty
                        ? InkWell(
                            onTap: () async {
                              for (var i = 0;
                                  i < _photoController.data.value.length;
                                  i++) {
                                var image = _photoController.data.value[i].url;
                                var imageUrl =
                                    "https://${_photoController.photoModel.hostName}/$image";
                                if (_photoController.data.value[i].isSelected ==
                                    true) {
                                  await imageDownload(imageUrl, context);
                                }
                              }
                            },
                            child: Container(
                              height: 28.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.r)),
                                  border: Border.all(
                                      color: const Color(0xFF000000))),
                              child: Center(
                                child: Text(
                                  'Download',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: const Color(0xFF000000)),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 28.h,
                            width: 100.w,
                          ),

                    SizedBox(
                      width: 10.h,
                    ),
                    InkWell(
                      onTap: () async {
                        for (var url in _photoController.data) {
                          var image = url.url;
                          var imageUrl =
                              "https://${_photoController.photoModel.hostName}/$image";

                          await imageDownload(imageUrl, context);
                        }
                      },
                      child: Container(
                        height: 28.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r)),
                            border: Border.all(color: const Color(0xFF000000))),
                        child: Center(
                          child: Text(
                            'Download All',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: const Color(0xFF000000)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 23,
                        mainAxisExtent: 300.h),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                        focusColor: AppColor.deepOrange,
                                        checkColor: Colors.white,
                                        activeColor: AppColor.deepOrange,
                                        value: _photoController
                                            .data.value[index].isSelected,
                                        onChanged: (value) {
                                          if (_photoController
                                                  .isAllSelectedData.value !=
                                              true) {
                                            _photoController.isSelected(
                                                index,
                                                _photoController.data
                                                    .value[index].isSelected!,
                                                _photoController
                                                    .data.value[index].url!);
                                          }
                                        }),
                                    IconButton(
                                        onPressed: () {
                                          imageDownload(imageUrl, context);
                                        },
                                        icon: const Icon(Icons.download))
                                  ],
                                ),
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                      color: AppColor.deepOrange,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
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
                                                              FontWeight.w600),
                                                    ),
                                                    content: Text(
                                                      'Are you sure you want to delete Image!',
                                                      style: CustomTextStyle.h3(
                                                          fontWeight:
                                                              FontWeight.w400),
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
                                                                        .data[
                                                                            index]
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
                                                  color: AppColor.deepOrange,
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.delete,
                                                color: AppColor.textColorWhite,
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
            )),
    );
  }

  //  imageDownloadOneByOne(String imageUrl, BuildContext context, ) async {
  //   try {
  //     String path = imageUrl;
  //     await GallerySaver.saveImage(path, albumName: 'Downloads Photos')
  //         .then((success) {
  //       if (success != null && success) {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: const Text('Download Complete'),
  //           duration: const Duration(seconds: 2),
  //           action: SnackBarAction(
  //             label: '',
  //             onPressed: () async {},
  //           ),
  //         ));
  //       }
  //     });
  //   } on Exception catch (e) {
  //     debugPrint('Error while saving image : $e');
  //   }
  // }

  imageDownload(String imageUrl, BuildContext context) async {
    try {
      String path = imageUrl;
      await GallerySaver.saveImage(path, albumName: 'Downloads Photos')
          .then((success) {
        if (success != null && success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Download Complete'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: '',
              onPressed: () async {},
            ),
          ));
        }
      });
    } on Exception catch (e) {
      debugPrint('Error while saving image : $e');
    }
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF000000),
          )),
      title: Text(
        'Photos',
        style: CustomTextStyle.h1(
            color: const Color(0xFFEB6526),
            fontSize: 20.sp,
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
              color: const Color(0xFF000000),
            ))
      ],
    );
  }
}
