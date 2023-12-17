import 'package:epm/controller/document_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/views/Document_Sector/pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

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
        backgroundColor: const Color(0xFFF7F8F9),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF000000),
            )),
        title: Text(
          'Work Order Documents',
          style: CustomTextStyle.h1(
              color: const Color(0xFFEB6526),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          // PopupMenuButton(
          //     onSelected: (value) {
          //       // showModalBottomSheet(
          //       //     isScrollControlled: true,
          //       //     context: context,
          //       //     shape: RoundedRectangleBorder(
          //       //         borderRadius: BorderRadius.only(
          //       //             topLeft: Radius.circular(8.r),
          //       //             topRight: Radius.circular(8.r))),
          //       //     builder: (context) {
          //       //       return Padding(
          //       //         padding: MediaQuery.of(context).viewInsets,
          //       //         child: Padding(
          //       //           padding: EdgeInsets.all(12.w),
          //       //           child: Column(
          //       //             mainAxisSize: MainAxisSize.min,
          //       //             crossAxisAlignment: CrossAxisAlignment.start,
          //       //             children: [
          //       //               TextButton(
          //       //                   onPressed: () {
          //       //                     _documentController.selectFile();
          //       //                   },
          //       //                   child: Text(
          //       //                     'Pick Document',
          //       //                     style: CustomTextStyle.h3(
          //       //                         fontWeight: FontWeight.w600,
          //       //                         color: AppColor.deepOrange),
          //       //                   )),
          //       //               SizedBox(
          //       //                 height: 15.h,
          //       //               ),
          //       //               InkWell(
          //       //                 onTap: () {
          //       //                   _documentController.uploadDocument();
          //       //                 },
          //       //                 child: Container(
          //       //                   height: 50.h,
          //       //                   width: double.infinity,
          //       //                   decoration: BoxDecoration(
          //       //                       color: AppColor.deepOrange,
          //       //                       borderRadius: BorderRadius.circular(8.r)),
          //       //                   child: Row(
          //       //                     mainAxisAlignment: MainAxisAlignment.center,
          //       //                     children: [
          //       //                       Text(
          //       //                         'Upload',
          //       //                         style: CustomTextStyle.h3(
          //       //                             color: AppColor.textColorWhite),
          //       //                       ),
          //       //                       SizedBox(
          //       //                         width:
          //       //                             _documentController.isLoading.value
          //       //                                 ? 15.w
          //       //                                 : 0,
          //       //                       ),
          //       //                       Obx(() {
          //       //                         if (_documentController
          //       //                             .isLoading.value) {
          //       //                           return SizedBox(
          //       //                             height: 15.sp,
          //       //                             width: 15.sp,
          //       //                             child:
          //       //                                 const CircularProgressIndicator(
          //       //                               color: Colors.white,
          //       //                               strokeWidth: 3,
          //       //                             ),
          //       //                           );
          //       //                         } else {
          //       //                           return const SizedBox();
          //       //                         }
          //       //                       })
          //       //                     ],
          //       //                   ),
          //       //                 ),
          //       //               ),
          //       //               SizedBox(
          //       //                 height: 15.h,
          //       //               ),
          //       //             ],
          //       //           ),
          //       //         ),
          //       //       );
          //       //     });
          //     },
          //     icon: Icon(
          //       Icons.adaptive.more,
          //       color: const Color(0xFF000000),
          //     ),
          //     itemBuilder: (BuildContext context) {
          //       return [
          //         PopupMenuItem(
          //             onTap: () {},
          //             value: 'add',
          //             child: Text(
          //               'Add Document',
          //               style: CustomTextStyle.h3(color: AppColor.blackColor),
          //             ))
          //       ];
          //     })
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
                          final url = pdfFile.url;

                          final pdfUrl =
                              "https://${_documentController.documentModel.hostName}/$url";
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewScreen(pdfUrl: pdfUrl)));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 36.h,
                                      width: 36.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xFFFFF4F0),
                                          image: DecorationImage(
                                              image:
                                                  AssetImage(AppImage.pdf1))),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        pdfFile.file,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    PopupMenuButton(
                                        onSelected: (value) {},
                                        icon: Icon(
                                          Icons.adaptive.more,
                                          color: const Color(0xFF000000),
                                        ),
                                        itemBuilder: (BuildContext context) {
                                          return [
                                            PopupMenuItem(
                                                onTap: () {
                                                  pdfDownload(pdfUrl, context);
                                                },
                                                value: 'download',
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Download',
                                                      style: CustomTextStyle.h3(
                                                          color: AppColor
                                                              .blackColor),
                                                    ),
                                                    const Icon(
                                                      Icons.download,
                                                      color: Color(0xFFEB6526),
                                                    )
                                                  ],
                                                )),
                                            PopupMenuItem(
                                                onTap: () {
                                                  showDialog(
                                                      barrierDismissible: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            'Delete Document',
                                                            style: CustomTextStyle.h1(
                                                                color: AppColor
                                                                    .deepOrange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          content: Text(
                                                            'Are you sure you want to delete Document!',
                                                            style: CustomTextStyle.h3(
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
                                                                  _documentController.deleteDocument(
                                                                      _documentController
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
                                                value: 'delete',
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Delete',
                                                      style: CustomTextStyle.h3(
                                                          color: AppColor
                                                              .blackColor),
                                                    ),
                                                    const Icon(
                                                      Icons.delete,
                                                      color: Color(0xFFEB6526),
                                                    )
                                                  ],
                                                )),
                                          ];
                                        })
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.deepOrange,
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
                            _documentController.selectFile();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                color: AppColor.deepOrange,
                                size: 30.sp,
                              )
                            ],
                          )),
                      SizedBox(
                        height: 20.h,
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
                                width: _documentController.isLoading.value
                                    ? 15.w
                                    : 0,
                              ),
                              Obx(() {
                                if (_documentController.isLoading.value) {
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
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> pdfDownload(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        print('Access Denied');
        showAlertDialog(context);
      } else {
        print('Exception occurred!');
      }

      throw Exception('Could not launch $uri');
    }
  }

  showAlertDialog(context) {
    return showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Permission Denied'),
            content:
                const Text('Allow access to download pdf for your storage'),
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => openAppSettings(),
                  child: const Text('Settings'))
            ],
          );
        });
  }
}
