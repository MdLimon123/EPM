import 'package:epm/views/ChatScreen/Models/user_chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:jiffy/jiffy.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key, required this.message, required this.isSender});
  Chat message;
  bool isSender;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1.w))),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                constraints: BoxConstraints(maxWidth: 267.w),
                decoration: BoxDecoration(
                    color: isSender
                        ? const Color(0xFFCCF7FF)
                        : const Color.fromRGBO(241, 241, 241, 1),
                    borderRadius: BorderRadius.circular(6.r)),
                child: HtmlWidget(
                  message.message,
                  textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000000)),
                ),
              ),
            ),
            Padding(
              padding: isSender
                  ? EdgeInsets.only(right: 14.w)
                  : EdgeInsets.only(right: 14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Jiffy.parse(message.createdAt.toString()).Hm,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF969A9E),
                          fontWeight: FontWeight.w400)),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    Jiffy.parse(message.createdAt.toString()).yMMMd,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF969A9E),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: isSender
                  ? EdgeInsets.only(right: 14.w)
                  : EdgeInsets.only(right: 14.w),
              child: Text(
                message.member.name,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        )
      ],
    );
  }
}
