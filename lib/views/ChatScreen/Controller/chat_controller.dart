import 'dart:async';

import 'package:epm/services/api_services.dart';

import 'package:epm/views/ChatScreen/Models/user_chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

class ChatController extends GetxController {
  late UserChatModel userChatModel;
  final TextEditingController messageController = TextEditingController();

  var isLoading = false.obs;

  RxMap<DateTime, List<Chat>> timeGroup = <DateTime, List<Chat>>{}.obs;




  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  var isGet = false.obs;
  var isScroll = false.obs;
  late ScrollController scrollController;
  Stream<List<Chat>> getChatMessage(int id) async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      if (!isGet.value) {
        isGet(true);
        var result = await ApiServices.getUserChatMessage(id: id);
        userChatModel = result;
        List<Chat> demoList = [];
        for (var element in userChatModel.chats) {
          demoList.add(element);
        }
        if (!isScroll.value) {
          isScrollPixel();
          isScroll(true);
        }

        yield demoList;

        isGet(false);
      }
    }
  }

  isScrollPixel() {
    Timer(const Duration(milliseconds: 100), () {
      scrollController.position
          .jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  groupMessageByData(List<Chat> chatList, bool loadMore) {
    chatList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    for (var message in chatList) {
      print("message : ${message.createdAt.year}");
      final date = DateTime(message.createdAt.year, message.createdAt.month,
          message.createdAt.day);
      print("=====> date :$date");
      timeGroup.putIfAbsent(date, () => []);

      if (loadMore) {
        timeGroup[date]?.insert(0, message);
        timeGroup.refresh();
      } else {
        timeGroup[date]?.add(message);
        timeGroup.refresh();
      }
    }
  }

  sendMessage(
      {required String vendorId,
      required String message,
      required String memberId,
      required int workId}) async {
    try {
      messageController.clear();
      var result = await ApiServices.postMessageToUser(
          workOrderId: workId,
          memberId: memberId,
          vendorId: vendorId,
          message: message);

      if (result) {
        print('Message sent');
      } else {
        print('Message send failed');
        Fluttertoast.showToast(msg: 'Message send failed');
      }
    } on Exception catch (e) {
      print('Message send failed. Reason${e.toString()}');
      Fluttertoast.showToast(msg: 'Message send failed');
    }
  }
}
