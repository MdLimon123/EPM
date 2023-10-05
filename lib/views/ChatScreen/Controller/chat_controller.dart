import 'package:epm/views/ChatScreen/Models/chat_message.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{

  List<ChatMessage> messageList = [
    ChatMessage(
        text: 'Hey Megalodon, last week me and my friend have watch your tips video',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
        setTime: '2:00 PM'),
    ChatMessage(
        text: 'Hey Megalodon, last week me ',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true,
        setTime: '2:00 PM'),
    ChatMessage(
        text: ' watch your tips video',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
        setTime: '2:00 PM'),
    ChatMessage(
        text: ', last week me and my friend have ',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true,
        setTime: '2:00 PM'),
    ChatMessage(
        text: 'Hey Megalodon, last week me and my friend have watch your tips video',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
        setTime: '2:00 PM'),
    ChatMessage(
        text: 'Hey Megalodon,  have watch your tips video',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true,
        setTime: '2:00 PM'),
    ChatMessage(
        text: 'friend have watch your tips video',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: false,
        setTime: '2:00 PM'),
    ChatMessage(
        text: 'Hey Megalodon, last week me and my friend have watch your tips video',
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.viewed,
        isSender: true,
        setTime: '2:00 PM'),

  ];
}