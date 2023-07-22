import 'package:epm/controller/document_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/widgets/custom_button.dart';
import 'package:epm/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocumentScreen extends StatelessWidget {
   DocumentScreen({super.key});

  final _documentController = Get.put(DocumentController());

  @override
  Widget build(BuildContext context) {
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
                              Text(
                                'Document add',
                                style: CustomTextStyle.h4(),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              CustomTextField(
                                onTap: () {
                                  _documentController.selectFile();
                                },
                                controller: _documentController.fileByController,
                                readOnly: true,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Field is Empty';
                                  }
                                  return null;
                                },
                                // labelText: 'Choosen file',
                                // labelStyle: CustomTextStyle.h4(
                                //   color: AppColor.blackColor
                               // ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              PrimaryButton(title: 'Upload', onPressed: () {
                                _documentController.uploadFile();
                              }),
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
        padding:  EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Documents',
            style: CustomTextStyle.h2(
              color: AppColor.deepOrange,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(height: 15.h,),
            Expanded(
              child: Obx(()=>
                 ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _documentController.fileList.length,
                  itemBuilder: (context, index){
                    final file = _documentController.fileList[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(AppImage.pdf,
                          height: 60.h,
                          width: 60.w,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                            margin: EdgeInsets.all(15.w),
                            decoration: BoxDecoration(
                              color: AppColor.deepOrange,
                              borderRadius: BorderRadius.circular(8.r)
                            ),
                            child: Center(child: Text('Download',
                            style: CustomTextStyle.h4(
                              fontWeight: FontWeight.w500,
                              color: AppColor.textColorWhite
                            ),)),
                          )
                        
                        ],
                      ),
                        Text(file),
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
