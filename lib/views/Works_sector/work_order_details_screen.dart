import 'package:epm/Routes/routes.dart';
import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import '../../model/work_order_model.dart';

final _workOrderController = Get.put(WorksOrderController());

class WorkOrderDetailsScreen extends StatefulWidget {
  const WorkOrderDetailsScreen({super.key});

  @override
  State<WorkOrderDetailsScreen> createState() => _WorkOrderDetailsScreenState();
}

class _WorkOrderDetailsScreenState extends State<WorkOrderDetailsScreen> {
  final Datum data = Get.arguments['data'];

  @override
  void initState() {
    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      _workOrderController.fetchData(data.id.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Obx(
        () => _workOrderController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                color: AppColor.deepOrange,
              ))
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        color: AppColor.deepOrange
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.addImageScreen, arguments: {
                                "id": data.id,
                                "workOrderId": data.workOrder
                              });
                            },
                            child: Text(
                              'Photos',
                              style: CustomTextStyle.h3(
                                  color: AppColor.textColorWhite,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.documentScreen, arguments: {
                                "id": data.id,
                                "workOrderId": data.workOrder
                              });
                            },
                            child: Text(
                              'Documents',
                              style: CustomTextStyle.h3(
                                  color: AppColor.textColorWhite,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.workAddScreen,
                                  arguments: data);
                            },
                            child: Text(
                              'EST.',
                              style: CustomTextStyle.h3(
                                  color: AppColor.textColorWhite,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.chatScreen, arguments: data);
                            },
                            child: Text(
                              'Chat',
                              style: CustomTextStyle.h3(
                                  color: AppColor.textColorWhite,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.check,
                          color: AppColor.deepOrange,
                        ),
                        title: Text(
                          'Checking',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: const Color(0xFF000000)),
                        ),
                        subtitle: Text(
                          'Never',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6A6868)),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.navigate_next,
                              color: AppColor.textColor,
                            )),
                      ),



                ),



              SizedBox(
                height: 5.h,
              ),
              Divider(
                color: AppColor.greyColor,
                height: 2.h,
                thickness: 2,
              ),
          SizedBox(
            height: 6.h,
          ),

                    Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: ListTile(
                        dense: true,
                        leading: Image.asset(
                          AppImage.refresh,
                          height: 30.h,
                          width: 30.w,
                          color: AppColor.deepOrange,
                        ),
                        title: Text(
                          'Sync',

                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF000000)),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Never',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6A6868)),
                            ),
                            Text(
                              '-You must be checked in',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF6A6868)),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.navigate_next,
                              color: AppColor.textColor,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        'Work Order Info',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF000000)),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Divider(
                      color: AppColor.greyColor,
                      height: 2.h,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.asset(AppImage.status),
                            title: Text('Status',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF000000))),
                            subtitle: Text(
                                _workOrderController.workOrderModel.status ==
                                        true
                                    ? "Read"
                                    : "Unread",
                                style: CustomTextStyle.h4(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF6A6868),
                                    fontWeight: FontWeight.w400)),
                          ),
                          Divider(
                            color: Colors.grey.shade100,
                            thickness: 2,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _customText(
                        title: 'WO#',
                        subtitle: data.workOrder,
                        image: AppImage.work),
                    SizedBox(
                      height: 10.h,
                    ),
                    _customText(
                        title: 'PPW#',
                        subtitle: data.workTypeId.toString(),
                        image: AppImage.city),
                    SizedBox(
                      height: 10.h,
                    ),
                    _customText(
                        title: 'Work Type',
                        subtitle: data.workType.name,
                        image: AppImage.work),
                    SizedBox(
                      height: 10.h,
                    ),
                    _customText(
                        title: 'Address',
                        subtitle: data.address,
                        image: AppImage.address),
                    SizedBox(
                      height: 10.h,
                    ),
                    // _customText(
                    //     title: 'City/State/Zip',
                    //     subtitle: data.property.city,
                    //     image: AppImage.city),
                    SizedBox(
                      height: 10.h,
                    ),
                    _customText(
                        title: 'Date Due',
                        subtitle:
                            Jiffy.parse(data.createdAt.toString())
                                .yMMMd,
                        image: AppImage.date),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, top: 16.h),
                      child: Text(
                        'WO Instruction',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000)),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),


                    SizedBox(
                      height: 30.h,
                    ),


              _customText(
                  title: 'WO#', subtitle: data.workOrder, image: AppImage.work),
              SizedBox(
                height: 6.h,
              ),
              _customText(
                  title: 'PPW#', subtitle: data.workTypeId.toString(), image: AppImage.city),
              SizedBox(
                height: 6.h,
              ),
              _customText(
                  title: 'Work Type',
                  subtitle: data.workType.name,
                  image: AppImage.work),
              SizedBox(
                height: 6.h,
              ),
              _customText(
                  title: 'Address',
                  subtitle: data.address,
                  image: AppImage.address),
              SizedBox(
                height: 6.h,
              ),
              // _customText(
              //     title: 'City/State/Zip',
              //     subtitle: data.property.city,
              //     image: AppImage.city),
              SizedBox(
                height: 6.h,
              ),
              _customText(
                  title: 'Date Due',
                  subtitle: Jiffy.parse(data.createdAt.toString()).yMMMd,
                  image: AppImage.date),
              SizedBox(
                height: 15.h,
              ),

              Padding(
                padding:  EdgeInsets.only(left: 16.w, top: 16.h),
                child: Text('WO Instruction',
                style: TextStyle(fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000)),),
              ),
              SizedBox(
                height: 10.h,
              ),


              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: const Color(0xFFF5F5F5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                    ),
                    Text(
                      'Qty',
                      style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                    ),
                    Text(
                      'Price',
                      style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                    ),
                    Text(
                      'Total',
                      style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                    ),
                    Text(
                      'Additional Instructions',
                      style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                    ),
                  ],
                ),
              ),

          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var result = _workOrderController.workData[index];
                var totalPrice = int.parse(result.qty) * int.parse(result.price);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: const BoxDecoration(
                      border: Border(
                          top:
                          BorderSide(color: Color(0xFFE7E3E7), width: 1),
                          )),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          result.description,
                          style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          result.qty,
                          style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          result.price,
                          style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          totalPrice.toString(),
                          style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.w400, color: const Color(0xFF000000)),
                        ),
                      ),

                      Expanded(
                        child: HtmlWidget(
                          result.additionalInstruction,
                          textStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF000000)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 15.h,
              ),
              itemCount: _workOrderController.workData.length),


              SizedBox(height: 30.h,)

          ]),
        ),


      ));
  }

  _appbar() {
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      title: Text(
        'Work Order Details',
        style: CustomTextStyle.h1(
            color: const Color(0xFFEB6526),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Color(0xFF000000),
        ),
      ),

    );
  }

  _customText(
      {required String title,
      required String subtitle,
      required String image}) {
    return Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
          children: [
            ListTile(
              dense: true,
              title: Text(
                title,
                style: CustomTextStyle.h3(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: const Color(0xFF000000)),
              ),
              subtitle: Text(
                subtitle,
                style: CustomTextStyle.h4(
                    color: const Color(0xFF6A6868),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
              leading: Image.asset(image),
            ),
            Divider(
              color: Colors.grey.shade100,
              thickness: 2,
            )
          ],
        ));
  }
}
