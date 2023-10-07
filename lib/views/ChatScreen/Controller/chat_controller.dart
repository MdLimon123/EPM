import 'package:epm/services/api_services.dart';

import 'package:epm/views/ChatScreen/Models/user_chat_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late UserChatModel userChatModel;

  RxList<Chat> messageList = <Chat>[].obs;

  var isLoading = false.obs;

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

  Stream<List<Chat>> getChatMessage(int id) async* {

      await Future.delayed(const Duration(seconds: 1));
      var result = await ApiServices.getUserChatMessage(id: id);

      userChatModel = result;
      List<Chat> demoList = [];
      //demoList = userChatModel.chats;

      for (var element in userChatModel.chats) {

       // messageList.clear();
        demoList.add(element);


        print(messageList.length);


      yield demoList;
    }
  }

  // List<ChatMessage> messageList = [
  //   ChatMessage(
  //       text:
  //           'Hey Megalodon, last week me and my friend have watch your tips video',
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: false,
  //       setTime: '2:00 PM'),
  //   ChatMessage(
  //       text: 'Hey Megalodon, last week me ',
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: true,
  //       setTime: '2:00 PM'),
  //   ChatMessage(
  //       text: ' watch your tips video',
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: false,
  //       setTime: '2:00 PM'),
  //   ChatMessage(
  //       text: ', last week me and my friend have ',
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: true,
  //       setTime: '2:00 PM'),
  //   ChatMessage(
  //       text:
  //           'Hey Megalodon, last week me and my friend have watch your tips video',
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: false,
  //       setTime: '2:00 PM'),
  //   ChatMessage(
  //       text: 'Hey Megalodon,  have watch your tips video',
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: true,
  //       setTime: '2:00 PM'),
  //   ChatMessage(
  //       text: 'friend have watch your tips video',
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: false,
  //       setTime: '2:00 PM'),
  //   ChatMessage(
  //       text:
  //           'Hey Megalodon, last week me and my friend have watch your tips video',
  //       messageType: ChatMessageType.text,
  //       messageStatus: MessageStatus.viewed,
  //       isSender: true,
  //       setTime: '2:00 PM'),
  // ];
}
