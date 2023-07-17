import 'package:epm/controller/works_orders_controller.dart';
import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/views/Works_sector/work_order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorksOrdersScreen extends StatelessWidget {
  WorksOrdersScreen({super.key});

  final _workOrderController = Get.put(WorksOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Column(
       
        children: [
          Container(
            height: 80.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
             color: AppColor.greyColor,
             boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1)
              )
             ]
            ),
            child: Row(
              children: [
                Text('Filtered 6 of 23 results',
              style: CustomTextStyle.h3(
                fontWeight: FontWeight.w500,
                color: AppColor.textColor
              ),),
              SizedBox(width: 80.w,),
              Text('DATE DUE',
              style: CustomTextStyle.h2(
                color: AppColor.bgColor,
                fontWeight: FontWeight.w600
              ),),
              const Icon(Icons.arrow_drop_down)
              ],
            )
          ),

          Expanded(
            child: ListView.builder(
                   
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return    InkWell(
                  onTap: () {
                    Get.to(WorkOrderDetailsScreen());
                  },
                  child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: const BoxDecoration(
                     boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3)
                    )
                   ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('WO#: 12345',
                      style: CustomTextStyle.h2(
                        fontWeight: FontWeight.w700,
                        color: AppColor.blackColor
                      ),),
                         SizedBox(height: 5.h,),
                      Text('Inspection',
                      style: CustomTextStyle.h3(
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor
                      ),),
                      SizedBox(height: 5.h,),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                          color: AppColor.textColor,),
                          SizedBox(width: 5.w,),
                          Text('DUE 00/00/0000',
                          style: CustomTextStyle.h2(
                            fontWeight: FontWeight.w600,
                            color: AppColor.textColor
                          ),)
                        ],
                      ),
                      SizedBox(height: 15.h,),
                      Text('555 Main St',
                      style: CustomTextStyle.h2(
                         fontWeight: FontWeight.w600,
                            color: AppColor.textColor
                      ),),
                          Text('Small Town, CA',
                      style: CustomTextStyle.h2(
                         fontWeight: FontWeight.w600,
                            color: AppColor.textColor
                      ),),
                      SizedBox(height: 15.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: AppColor.textColor,
                              borderRadius: BorderRadius.circular(10.r)
                            ),
                            child: Icon(Icons.check,
                            color: AppColor.checkColor,),
                          ),
                            
                          Image.asset(AppImage.refresh,
                          height: 30.h,
                          width: 30.h,
                          color: AppColor.textColor,),
                            
                          Row(
                            children: [
                              Icon(Icons.image,
                               color: AppColor.textColor,),
                              Text('0',
                              style: CustomTextStyle.h3(
                                fontWeight: FontWeight.w500,
                                color: AppColor.textColor
                              ),)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                              ),
                );
                   
              },
             
                   
                   
            ),
          )

        ],
      ),
    );
  }

 _appbar() {
    return AppBar(
      backgroundColor: AppColor.bgColor,
      title: Text(
        'Work Orders',
        style: CustomTextStyle.h1(color: AppColor.textColorWhite),
      ),
      leading: Icon(
        Icons.refresh,
        color: AppColor.textColorWhite,
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: AppColor.textColorWhite,
            ))
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: TextFormField(
              controller: _workOrderController.searchController,
              style: CustomTextStyle.h2(color: AppColor.textColorWhite),
              decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 60.h),
                  hintText: 'Search',
                  hintStyle: CustomTextStyle.h2(
                      color: AppColor.textColorWhite,
                      fontWeight: FontWeight.w500),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.textColorWhite,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _workOrderController.searchController.clear();
                    },
                    icon: Icon(Icons.clear, color: AppColor.textColorWhite),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.textColorWhite),
                      borderRadius: BorderRadius.circular(4.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.textColorWhite))),
            ),
          )),
    );
  }
}
