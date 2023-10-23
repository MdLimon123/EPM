import 'package:epm/utils/app_color.dart';
import 'package:epm/utils/text_style.dart';
import 'package:epm/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.obsecure,
      this.onTap,
      this.labelText,
      this.labelStyle,
      //this.maxLines,
      this.suffixIcon,
      this.readOnly ,
        this.onChanged,
      this.keyboardType,
      this.validator});

  final VoidCallback? onTap;
 final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final bool? obsecure;
  final String? hintText;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  //final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
     // maxLines: maxLines,
      controller: controller,
      readOnly: readOnly ?? false,
      validator: validator,
      obscureText: obsecure ?? false,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(

          fillColor: AppColor.textColor.withOpacity(.1),
          filled: true,
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelStyle,
          suffixIcon: suffixIcon,
        //  constraints: BoxConstraints(maxHeight: 70.h),
          hintStyle:
              CustomTextStyle.h4(color: const Color(0xFF000000),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400),
              border: border(false),
              enabledBorder: border(false),
              focusedBorder: border(true)
              ),
    );
  }
}
