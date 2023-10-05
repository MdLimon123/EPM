import 'package:epm/views/ChatScreen/Models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends StatelessWidget {
   MessageScreen({super.key, required this.message});

   final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isSender ? MainAxisAlignment.end: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: message.isSender? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1.w))
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                constraints: BoxConstraints(maxWidth: 267.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECE5),
                  borderRadius: BorderRadius.circular(6.r)
                ),
                child: Text(message.text,),
              ),
            ),
            
            Padding(
              padding: message.isSender? EdgeInsets.only(right: 14.w): EdgeInsets.only(left: 14.w),
              child: Text(message.setTime,),
            )
          ],
        )
      ],
    );
  }
}
