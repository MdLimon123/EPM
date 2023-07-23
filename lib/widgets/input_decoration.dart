import 'package:epm/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration decoration({required String hintText, bool? isFilled}) {
  return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
     // constraints: BoxConstraints(maxHeight: 50.h),
      isDense: true,
      hintStyle:
          TextStyle(fontSize: 16.sp, color: AppColor.textColor.withOpacity(1)),
      filled: isFilled ?? false,
      fillColor: AppColor.textColor.withOpacity(.1),
      border: border(false),
      enabledBorder: border(false),
      focusedBorder: border(false));
}

OutlineInputBorder border(bool isFocus) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(
          color: isFocus
              ? AppColor.blackColor
              : AppColor.btnColor.withOpacity(.1)));
}
