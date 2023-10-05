enum ChatMessageType {text, audio, image, video, setTime}
enum MessageStatus {not_sent, not_view, viewed}

class ChatMessage{
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final String setTime;

  final bool isSender;

  ChatMessage({required this.text, this.isSender = true, required this.messageType, required this.messageStatus, required this.setTime});

}