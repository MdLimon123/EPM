import 'package:epm/Routes/routes.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/views/Add_Work_List/Controller/add_work_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../model/work_order_model.dart';
import '../../utils/app_color.dart';

final _addWorkController = Get.put(AddWorkController());
class WorkAddScreen extends StatelessWidget {
   WorkAddScreen({super.key});

  final Data data = Get.arguments;



  @override
  Widget build(BuildContext context) {


   // _addWorkController.fetchData(data.id);

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
      body: Obx(()=>_addWorkController.isLoading.value?Center(
        child: CircularProgressIndicator( color: AppColor.deepOrange,),
      ):
         SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                    itemCount: _addWorkController.data.length,
                    itemBuilder: (context, index) {
                      var result = _addWorkController.data[index];
                      var totalPrice = int.parse(result.qty) * int.parse(result.price);
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            padding: EdgeInsets.only(left: 5.w),
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Theme(
                                data: ThemeData()
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ListTileTheme(
                                    contentPadding: EdgeInsets.zero,
                                    minVerticalPadding: 0,
                                    dense: true,
                                    child: ExpansionTile(
                                      tilePadding: EdgeInsets.zero,
                                      title: HtmlWidget(
                                        result.additionalInstruction,
                                        textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFFEB6526)),
                                      ),
                                      children: [
                                        buildRowItem(
                                          title: 'Item Description',
                                          subTitle: result.description
                                        ),
                                        SizedBox(height: 10.h,),
                                        const Divider(
                                          height: 1,
                                          color: Color(0xFFDBDBDB),
                                        ),
                                        SizedBox(height: 10.h,),
                                        buildRowItem(
                                            title: 'Price',
                                            subTitle: result.price
                                        ),
                                        SizedBox(height: 10.h,),
                                        const Divider(
                                          height: 1,
                                          color: Color(0xFFDBDBDB),
                                        ),
                                        SizedBox(height: 10.h,),
                                        buildRowItem(
                                            title: 'Qty',
                                            subTitle: result.qty
                                        ),
                                        SizedBox(height: 10.h,),
                                        const Divider(
                                          height: 1,
                                          color: Color(0xFFDBDBDB),
                                        ),
                                        SizedBox(height: 10.h,),
                                        buildRowItem(
                                            title: 'Total Price',
                                            subTitle:  totalPrice.toString()
                                        ),
                                        SizedBox(height: 20.h,)

                                      ],
                                    ))),
                          )
                        ],
                      );
                    })
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: InkWell(
      //   onTap: (){
      //     Get.toNamed(Routes.addWorkOrder,arguments: data);
      //   },
      //   child: Container(
      //     alignment: Alignment.center,
      //     margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.w),
      //     height: 56.h,
      //     width: double.infinity,
      //     decoration: BoxDecoration(
      //       color: const Color(0xFFEB6526),
      //       borderRadius: BorderRadius.circular(12.r)
      //     ),
      //     child: Text('Add work Item',
      //     style: TextStyle(
      //       fontSize: 16.sp,
      //       fontWeight: FontWeight.w600,
      //       color: const Color(0xFFFFFFFF)
      //     ),),
      //
      //   ),
      // )

    );

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
