import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/widgets/custom_button.dart';
import 'package:epm/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddWorkOrderScreen extends StatelessWidget {
  const AddWorkOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
         icon: Icon(Icons.arrow_back,
         color: AppColor.textColorWhite,)),
        backgroundColor: AppColor.bgColor,
        title: Text('Add Work List',
        style: CustomTextStyle.h1(
          color: AppColor.textColorWhite
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Constractor Estimation',
              style: CustomTextStyle.h2(
                color: AppColor.deepOrange,
                fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 15.h,),
              _titleText(
                'Item Description'
              ),
              SizedBox(height: 5.h,),
              const CustomTextField(
                hintText: 'Item name',
              ),
                  SizedBox(height: 15.h,),
              _titleText(
                'Qty'
              ),
              SizedBox(height: 5.h,),
              const CustomTextField(
                hintText: 'Quantity',
              ),
                  SizedBox(height: 15.h,),
              _titleText(
                'Price'
              ),
              SizedBox(height: 5.h,),
              const CustomTextField(
                hintText: 'Price',
              ),
                  SizedBox(height: 15.h,),
              _titleText(
                'Comment'
              ),
              SizedBox(height: 5.h,),
              const CustomTextField(
                hintText: 'comment',
              ),
                   SizedBox(height: 15.h,),
              _titleText(
                'Total Price'
              ),
              SizedBox(height: 5.h,),
              const CustomTextField(
                hintText: 'Total Price',
              ),
              SizedBox(height: 15.h,),
              PrimaryButton(title: 'Save',
               onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }

 _titleText(String title) {
    return Text(title,
          style: CustomTextStyle.h3(
            color: AppColor.deepOrange.withOpacity(.6)
          ),);
  }
}