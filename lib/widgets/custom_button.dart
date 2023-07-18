import 'package:epm/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.icon,
      this.fontSize,
      this.fontWeight});

  final String title;
  final VoidCallback onPressed;
  final Widget? icon;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.r)),
              backgroundColor: AppColor.deepOrange),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [icon ?? const SizedBox(), Text(title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.textColorWhite
            ),)],
          )),
    );
  }
}
