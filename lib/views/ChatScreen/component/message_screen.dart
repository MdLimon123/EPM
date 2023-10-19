import 'package:epm/views/ChatScreen/Models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../model/work_order_model.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key, required this.message});

  final ChatMessage message;



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: message.isSender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
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
                    color: message.isSender
                        ? const Color(0xFFCCF7FF)
                        : const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(6.r)),
                child: HtmlWidget(
                  message.text,
                  textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000000)),
                ),
              ),
            ),
            Padding(
              padding: message.isSender
                  ? EdgeInsets.only(right: 14.w)
                  : EdgeInsets.only(right: 14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Jiffy.parse(message.setTime).Hm,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 20.w,),
                  Text(Jiffy.parse(message.setTime).yMMMd),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: message.isSender
                  ? EdgeInsets.only(right: 14.w)
                  : EdgeInsets.only(right: 14.w),
              child: Text(
                message.name,
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
