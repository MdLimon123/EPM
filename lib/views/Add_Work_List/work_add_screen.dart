import 'package:epm/utils/text_style.dart';
import 'package:epm/views/Add_Work_List/Controller/add_work_controller.dart';
import 'package:epm/views/Add_Work_List/update_work_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../Routes/routes.dart';
import '../../model/work_order_model.dart';
import '../../utils/app_color.dart';

final _addWorkController = Get.put(AddWorkController());

class WorkAddScreen extends StatefulWidget {
  const WorkAddScreen({super.key});

  @override
  State<WorkAddScreen> createState() => _WorkAddScreenState();
}

class _WorkAddScreenState extends State<WorkAddScreen> {
  final Data data = Get.arguments;

  @override
  void initState() {
    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      _addWorkController.fetchData(data.id.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xFFF7F8F9),
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
            'Add Work List',
            style: CustomTextStyle.h1(
                color: const Color(0xFFEB6526),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => _addWorkController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColor.deepOrange,
                  ),
                )
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Work order Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: const Color(0xFF000000)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _addWorkController.estimationList.length,
                            itemBuilder: (context, index) {
                              var result =
                                  _addWorkController.estimationList[index];

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10.h),
                                          padding: EdgeInsets.only(left: 5.w),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFFFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(12.r)),
                                          child: Theme(
                                              data: ThemeData().copyWith(
                                                  dividerColor:
                                                      Colors.transparent),
                                              child: InkWell(
                                                onTap: () {
                                                  _addWorkController
                                                      .upItemController
                                                      .text = result.item;
                                                  _addWorkController
                                                          .upPriceController
                                                          .text =
                                                      result.contractorPrice;
                                                  _addWorkController
                                                      .upQntController
                                                      .text = result.qty;
                                                  _addWorkController
                                                      .upComController
                                                      .text = result.comment;
                                                  _addWorkController
                                                          .upTotalController
                                                          .text =
                                                      result.contractorTotal;

                                                  Get.to(UpdateWorkScreen(index: index,));
                                                },
                                                child: ListTileTheme(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    minVerticalPadding: 0,
                                                    dense: true,
                                                    child: ExpansionTile(
                                                      tilePadding:
                                                          EdgeInsets.zero,
                                                      title: Text(
                                                        result.comment,
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: const Color(
                                                                0xFFEB6526)),
                                                      ),
                                                      children: [
                                                        buildRowItem(
                                                            title:
                                                                'Item Description',
                                                            subTitle:
                                                                result.item),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        const Divider(
                                                          height: 1,
                                                          color:
                                                              Color(0xFFDBDBDB),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        buildRowItem(
                                                            title: 'Price',
                                                            subTitle: result
                                                                .contractorPrice),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        const Divider(
                                                          height: 1,
                                                          color:
                                                              Color(0xFFDBDBDB),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        buildRowItem(
                                                            title: 'Qty',
                                                            subTitle:
                                                                result.qty),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        const Divider(
                                                          height: 1,
                                                          color:
                                                              Color(0xFFDBDBDB),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        buildRowItem(
                                                            title:
                                                                'Total Price',
                                                            subTitle: result
                                                                .contractorTotal),
                                                        SizedBox(
                                                          height: 20.h,
                                                        )
                                                      ],
                                                    )),
                                              )),
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
                                                    showDialog(
                                                        barrierDismissible:
                                                            true,
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              'Delete Estimation',
                                                              style: CustomTextStyle.h1(
                                                                  color: AppColor
                                                                      .deepOrange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            content: Text(
                                                              'Are you sure you want to delete Estimation!',
                                                              style: CustomTextStyle.h3(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  child: Text(
                                                                    'Cancel',
                                                                    style: CustomTextStyle.h3(
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  )),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    _addWorkController.deleteEstimation(index);
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
                                                  value: 'delete',
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Delete',
                                                        style:
                                                            CustomTextStyle.h3(
                                                                color: AppColor
                                                                    .blackColor),
                                                      ),
                                                      const Icon(
                                                        Icons.delete,
                                                        color:
                                                            Color(0xFFEB6526),
                                                      )
                                                    ],
                                                  )),
                                            ];
                                          })
                                    ],
                                  )
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () {
            Get.toNamed(Routes.addWorkOrder, arguments: data);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.w),
            height: 56.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xFFEB6526),
                borderRadius: BorderRadius.circular(12.r)),
            child: Text(
              'Add work Item',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFFFFF)),
            ),
          ),
        ));
  }

  buildRowItem({required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: const Color(0xFF6A6868))),
        Text(
          subTitle,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000000)),
        )
      ],
    );
  }
}
