import 'package:epm/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkAddScreen extends StatelessWidget {
  const WorkAddScreen({super.key});

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
      body: SingleChildScrollView(
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
                  itemCount: 4,
                  itemBuilder: (context, index) {
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
                                    title: Text(
                                      'Debris cleaning',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFEB6526)),
                                    ),
                                    children: [
                                      buildRowItem(
                                        title: 'Item Description',
                                        subTitle: 'Floor'
                                      ),
                                      SizedBox(height: 10.h,),
                                      const Divider(
                                        height: 1,
                                        color: Color(0xFFDBDBDB),
                                      ),
                                      SizedBox(height: 10.h,),
                                      buildRowItem(
                                          title: 'Price',
                                          subTitle: '\$100'
                                      ),
                                      SizedBox(height: 10.h,),
                                      const Divider(
                                        height: 1,
                                        color: Color(0xFFDBDBDB),
                                      ),
                                      SizedBox(height: 10.h,),
                                      buildRowItem(
                                          title: 'Qty',
                                          subTitle: '1'
                                      ),
                                      SizedBox(height: 10.h,),
                                      const Divider(
                                        height: 1,
                                        color: Color(0xFFDBDBDB),
                                      ),
                                      SizedBox(height: 10.h,),
                                      buildRowItem(
                                          title: 'Total Price',
                                          subTitle: '\$100'
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
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.w),
        height: 56.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFEB6526),
          borderRadius: BorderRadius.circular(12.r)
        ),
        child: Text('Add work Item',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFFFFFF)
        ),),

      ));
  }

  buildRowItem({required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: const Color(0xFF6A6868)),
        ),
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
