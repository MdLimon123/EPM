import 'dart:async';

import 'package:epm/services/api_services.dart';

import 'package:epm/views/ChatScreen/Models/user_chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

class ChatController extends GetxController {
  late UserChatModel userChatModel;
  RxList<Chat> message = <Chat>[].obs;

  final TextEditingController messageController = TextEditingController();

  var isLoading = false.obs;
  Timer? _pollingTimer;

  RxMap<DateTime, List<Chat>> timeGroup = <DateTime, List<Chat>>{}.obs;

  late ScrollController scrollController;

  // getMessage(int id) async {
  //   var result = await ApiServices.getUserChatMessage(id: id);
  //
  //   isLoading(true);
  //   try {
  //     if (result.runtimeType == int) {
  //       print("$result");
  //     } else {
  //       userChatModel = result;
  //       for (var element in userChatModel.chats) {
  //        // messageList.clear();
  //         messageList.add(element);
  //         print(messageList.length);
  //       }
  //       // messageList.value = userChatModel.chats;
  //     }
  //   } on Exception catch (e) {
  //     if (kDebugMode) {
  //       print('Message Fetch Error : $e');
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
  }

  // Future<void> fetchMessage(int id)async{
  //  try{
  //    var fetchMessages = await ApiServices.getUserChatMessage(id: id);
  //    userChatModel = fetchMessages;
  //    message= userChatModel.chats;
  //    message = fetchMessages;
  //    _messageStreamController.add(message);
  //    print(message);
  //  }catch(e){
  //    print('Error Fetching message : $e');
  //  }
  // }

  @override
  void onClose() {
    _pollingTimer?.cancel();

    super.onClose();
  }

  @override
  void dispose() {
    scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  Stream<List<Chat>> getChatMessage(int id) async* {
    await Future.delayed(const Duration(seconds: 1));
    var result = await ApiServices.getUserChatMessage(id: id);

    userChatModel = result;
    List<Chat> demoList = [];
    message.value = userChatModel.chats;
    for (var element in message) {
      demoList.add(element);

      yield demoList;
    }
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
      var result = await ApiServices.postMessageToUser(
          workOrderId: workId,
          memberId: memberId,
          vendorId: vendorId,
          message: messageController.text);

      if (result) {
        print('Message sent');
        messageController.clear();
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
