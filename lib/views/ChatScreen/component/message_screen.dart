import 'package:epm/views/ChatScreen/Models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jiffy/jiffy.dart';


class MessageScreen extends StatelessWidget {
   MessageScreen({super.key, required this.message});

  final ChatMessage message;




  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          message.isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: message.isSender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [

            Padding(
              padding: message.isSender
                  ? EdgeInsets.only(right: 14.w)
                  : EdgeInsets.only(right: 14.w),
              child: Center(
                child: Text(
                    Jiffy.parse(message.setTime).yMMMd
                ),
              ),
            ),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1.w))),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                constraints: BoxConstraints(maxWidth: 267.w),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFECE5),
                    borderRadius: BorderRadius.circular(6.r)),
                child: HtmlWidget(
                  message.text,
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF000000)
                  ),
                ),
              ),
            ),
            Padding(
              padding: message.isSender
                  ? EdgeInsets.only(right: 14.w)
                  : EdgeInsets.only(right: 14.w),
              child: Text(
                  Jiffy.parse(message.setTime).Hm,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
