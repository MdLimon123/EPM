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
      this.readOnly,
      this.validator});

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final bool? obsecure;
  final String? hintText;
  final String? labelText;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      validator: validator,
      obscureText: obsecure ?? false,
      decoration: InputDecoration(
          fillColor: AppColor.textColor.withOpacity(.1),
          filled: true,
          hintText: hintText,
          labelText: labelText,
          labelStyle: labelStyle,
          constraints: BoxConstraints(maxHeight: 50.h),
          hintStyle:
              CustomTextStyle.h4(color: AppColor.deepOrange.withOpacity(.5)),
              border: border(false),
              enabledBorder: border(false),
              focusedBorder: border(true)
              ),
    );
  }
}
