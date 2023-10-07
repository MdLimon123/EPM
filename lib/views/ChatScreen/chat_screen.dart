import 'package:epm/controller/add_image_controller.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/views/ChatScreen/Controller/chat_controller.dart';
import 'package:epm/views/ChatScreen/Models/chat_message.dart';
import 'package:epm/views/ChatScreen/Models/user_chat_model.dart';
import 'package:epm/views/ChatScreen/component/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_color.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final _chatController = Get.put(ChatController());

  final _addImageController = Get.put(AddImageController());

  final Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    _addImageController.id = data["id"];
    int id = _addImageController.id;
    //_chatController.getMessage(id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Row(
          children: [
            CircleAvatar(
                radius: 20.r, backgroundImage: AssetImage(AppImage.person)),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'Md Limon',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF000000)),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child:
            // Obx(
            //   () => _chatController.isLoading.value
            //       ? const Center(
            //           child: CircularProgressIndicator(),
            //         )
            //       : ListView.builder(
            //           itemCount: _chatController.messageList.length,
            //           itemBuilder: (context, index) {
            //             var result = _chatController.messageList[index];
            //             return MessageScreen(
            //                 message: ChatMessage(
            //                     text: result.message,
            //                     isSender:
            //                         result.memberId == result.vendorId ? false : true,
            //                     messageType: ChatMessageType.text,
            //                     messageStatus: MessageStatus.not_view,
            //                     setTime: result.createdAt.toString()));
            //           }),
            // ),

            StreamBuilder<List<Chat>>(
                stream: _chatController.getChatMessage(id),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Chat>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var result = snapshot.data![index];
                          return MessageScreen(
                              message: ChatMessage(
                                  text: result.message,
                                  isSender: result.memberId == result.vendorId? false:true,
                                  messageType: ChatMessageType.text,
                                  messageStatus:
                                      MessageStatus.not_sent,
                                  setTime:
                                      result.createdAt.toString(),
                                  time:result.createdAt.toString()));
                        });
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        'Loading....',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColor.deepOrange,
                      ),
                    );
                  }
                })


          )),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      left: 10.w, top: 10.h, bottom: 20.w, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFD8D8D8),
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                        hintText: 'Write a message.....',
                        contentPadding: EdgeInsets.all(10.w),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                height: 60.h,
                width: 100.w,
                margin: EdgeInsets.only(
                    left: 10.w, top: 10.h, bottom: 20.w, right: 10),
                decoration: BoxDecoration(
                    color: AppColor.deepOrange,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Center(
                  child: Text(
                    'Send',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
