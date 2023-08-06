import 'package:epm/controller/document_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';

import 'package:epm/utils/text_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocumentScreen extends StatelessWidget {
  DocumentScreen({super.key});

  final _documentController = Get.put(DocumentController());

  final Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    _documentController.id = data['id'];
    _documentController.workOrder = data['workOrderId'];
    int id = _documentController.id;
    _documentController.getDocument(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blackColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColor.textColorWhite,
            )),
        title: Text(
          'Work Order Documents',
          style: CustomTextStyle.h1(color: AppColor.textColorWhite),
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            topRight: Radius.circular(8.r))),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    _documentController.selectFile();
                                  },
                                  child: Text(
                                    'Document',
                                    style: CustomTextStyle.h3(
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.deepOrange),
                                  )),
                              SizedBox(
                                height: 15.h,
                              ),
                              InkWell(
                                onTap: () {
                                  _documentController.uploadDocument();
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
                                        'Upload',
                                        style: CustomTextStyle.h3(
                                            color: AppColor.textColorWhite),
                                      ),
                                      SizedBox(
                                        width:
                                            _documentController.isLoading.value
                                                ? 15.w
                                                : 0,
                                      ),
                                      Obx(() {
                                        if (_documentController
                                            .isLoading.value) {
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
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.adaptive.more,
                color: AppColor.textColorWhite,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                      onTap: () {},
                      value: 'add',
                      child: Text(
                        'Add Document',
                        style: CustomTextStyle.h3(color: AppColor.blackColor),
                      ))
                ];
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                () => _documentController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColor.deepOrange,
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _documentController.data.length,
                        itemBuilder: (context, index) {
                          final pdfFile = _documentController.data[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    AppImage.pdf,
                                    height: 60.h,
                                    width: 60.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Delete Document',
                                                style: CustomTextStyle.h1(
                                                    color: AppColor.deepOrange,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              content: Text(
                                                'Are you sure you want to delete Docuemnt!',
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
                                                              FontWeight.w400),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      _documentController
                                                          .deleteDocument(
                                                              _documentController
                                                                  .data[index]
                                                                  .id,
                                                              index);
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      'Ok',
                                                      style: CustomTextStyle.h3(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                        height: 50.h,
                                        width: 60.w,
                                        margin: EdgeInsets.all(15.w),
                                        decoration: BoxDecoration(
                                            color: AppColor.deepOrange,
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColor.textColorWhite,
                                        )),
                                  )
                                ],
                              ),
                              Text(pdfFile.file),
                            ],
                          );
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
