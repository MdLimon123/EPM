import 'dart:async';

import 'package:epm/controller/add_image_controller.dart';
import 'package:epm/utils/app_image.dart';
import 'package:epm/views/ChatScreen/Controller/chat_controller.dart';
import 'package:epm/views/ChatScreen/Models/chat_message.dart';
import 'package:epm/views/ChatScreen/Models/user_chat_model.dart';
import 'package:epm/views/ChatScreen/component/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../model/work_order_model.dart';
import '../../utils/app_color.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatController = Get.put(ChatController());

  final _addImageController = Get.put(AddImageController());

  final Data orderData = Get.arguments;

  @override
  void initState() {
    _chatController.scrollController =
        ScrollController(initialScrollOffset: 0.0);
    _chatController.isScroll(false);

    super.initState();
  }

  @override
  void dispose() {
    _chatController.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _addImageController.id = orderData.id;

    int id = _addImageController.id;
    //_chatController.fetchMessage(id);

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
                      //           itemCount: _chatController.message.length,
                      //           itemBuilder: (context, index) {
                      //             var result = _chatController.message[index];
                      //             return MessageScreen(
                      //                 message: ChatMessage(
                      //                     text: result.message,
                      //                     isSender:
                      //                         result.memberId == result.vendorId ? false : true,
                      //                     messageType: ChatMessageType.text,
                      //                     messageStatus: MessageStatus.not_view,
                      //                     setTime: result.createdAt.toString(),
                      //                     time: result.createdAt.toString()));
                      //           }),
                      // ),

                      StreamBuilder<List<Chat>>(
                          stream: _chatController.getChatMessage(id),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Chat>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: _chatController.scrollController,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var result = snapshot.data![index];

                                    if (index == snapshot.data!.length - 1) {
                                      print(
                                          "=======> scroll index $index = ${snapshot.data!.length}");
                                      // SchedulerBinding.instance
                                      //     .addPersistentFrameCallback((_) {
                                      //   if (_controller.position.pixels ==
                                      //       _controller
                                      //           .position.maxScrollExtent) {
                                      //     _controller.animateTo(
                                      //         _controller
                                      //             .position.maxScrollExtent,
                                      //         duration: const Duration(
                                      //             milliseconds: 500),
                                      //         curve: Curves.easeOut);
                                      //   }
                                      // });

                                      Timer(const Duration(milliseconds: 500),
                                          () {
                                        _chatController.scrollController.jumpTo(
                                            _chatController.scrollController
                                                .position.maxScrollExtent);
                                      });
                                    }

                                    return MessageScreen(
                                        message: ChatMessage(
                                            text: result.message,
                                            isSender: result.memberId ==
                                                    result.vendorId
                                                ? false
                                                : true,
                                            messageType: ChatMessageType.text,
                                            messageStatus:
                                                MessageStatus.not_sent,
                                            setTime:
                                                result.createdAt.toString(),
                                            time: result.createdAt.toString()));
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
                          }))),
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
                    controller: _chatController.messageController,
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
              InkWell(
                onTap: () {
                  if (_chatController.messageController.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please input some message');
                  } else {
                    _chatController.sendMessage(
                        vendorId: orderData.vendorId,
                        message: _chatController.messageController.text,
                        memberId: orderData.contractorId,
                        workId: orderData.id);
                  }
                },
                child: Container(
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
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
