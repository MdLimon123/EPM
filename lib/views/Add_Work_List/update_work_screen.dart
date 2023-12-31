import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/views/Add_Work_List/Controller/add_work_controller.dart';

import 'package:epm/views/Add_Work_List/Models/wor_estimation_model.dart';

import 'package:epm/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/input_decoration.dart';

class UpdateWorkScreen extends StatelessWidget {
  UpdateWorkScreen({super.key, required this.data, required this.index});

  final _addWorkController = Get.put(AddWorkController());
  int index;
  Estimation data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF000000),
            )),
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          'Update Work List',
          style: CustomTextStyle.h1(
              color: const Color(0xFFEB6526),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Construction Estimation',
                style: CustomTextStyle.h2(
                    color: const Color(0xFF000000),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Item Description'),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                controller: _addWorkController.upItemController,
                hintText: 'Item name',
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Qty'),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                controller: _addWorkController.upQntController,
                hintText: 'Quantity',
                onChanged: (_) => _addWorkController.updateTotalPrice(),
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Price'),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                controller: _addWorkController.upPriceController,
                hintText: 'Price',
                onChanged: (_) => _addWorkController.updateTotalPrice(),
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Comment'),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                controller: _addWorkController.upComController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    fillColor: AppColor.textColor.withOpacity(.1),
                    filled: true,
                    hintText: 'Comment',
                    hintStyle: CustomTextStyle.h4(fontSize: 12.sp),
                    border: border(false),
                    enabledBorder: border(false),
                    focusedBorder: border(true)),
              ),
              SizedBox(
                height: 15.h,
              ),
              _titleText('Total Price'),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                controller: _addWorkController.upTotalController,
                readOnly: true,
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () {
                  _addWorkController.updateEstimation(data.id, index);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFFEB6526),
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Update',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFFFFFF)),
                      ),
                      SizedBox(
                        width: _addWorkController.isLoading.value ? 15.w : 0,
                      ),
                      Obx(() {
                        if (_addWorkController.isLoading.value) {
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
            ],
          ),
        ),
      ),
    );
  }


  _titleText(String title) {
    return Text(
      title,
      style: CustomTextStyle.h3(
          color: const Color(0xFFAAAAAA),
          fontSize: 13.sp,
          fontWeight: FontWeight.w500),
    );
  }
}
