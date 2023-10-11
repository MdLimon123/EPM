enum ChatMessageType { text, audio, image, video, setTime }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final String setTime;
  final String time;
  final String name;
  final bool isSender;
  final bool isReceiver;

  ChatMessage({
    required this.text,
    this.isSender = true,
    this.isReceiver = true,
    required this.name,
    required this.messageType,
    required this.messageStatus,
    required this.setTime,
    required this.time
  });
}
