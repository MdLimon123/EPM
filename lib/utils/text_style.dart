import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyle{
  static TextStyle h1(
      {Color? color, FontWeight? fontWeight, double? letterSpacing, double? fontSize}) {
    return TextStyle(
        color: color,
        fontSize:fontSize?? 24.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w600);
  }

    static TextStyle h2(
      {Color? color, FontWeight? fontWeight, double? letterSpacing,double? fontSize}) {
    return TextStyle(
        color: color,
        fontSize:fontSize?? 20.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w600);

        
  }

    static TextStyle h3(
      {Color? color, FontWeight? fontWeight, double? letterSpacing,double? fontSize}) {
    return TextStyle(
        color: color,
        fontSize:fontSize?? 18.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w600);

        
  }
     static TextStyle h4(
      {Color? color, FontWeight? fontWeight, double? letterSpacing,double? fontSize}) {
    return TextStyle(
        color: color,
        fontSize: fontSize ??16.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w600);

        
  }

}