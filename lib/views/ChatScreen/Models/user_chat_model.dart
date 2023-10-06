// To parse this JSON data, do
//
//     final userChatModel = userChatModelFromJson(jsonString);

import 'dart:convert';

UserChatModel userChatModelFromJson(String str) =>
    UserChatModel.fromJson(json.decode(str));

String userChatModelToJson(UserChatModel data) => json.encode(data.toJson());

class UserChatModel {
  bool status;
  String message;
  List<Chat> chats;

  UserChatModel({
    required this.status,
    required this.message,
    required this.chats,
  });

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
        status: json["status"],
        message: json["message"],
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
      };
}

class Chat {
  int id;
  String workOrderId;
  String memberId;
  String vendorId;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  Chat({
    required this.id,
    required this.workOrderId,
    required this.memberId,
    required this.vendorId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        workOrderId: json["work_order_id"],
        memberId: json["member_id"],
        vendorId: json["vendor_id"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "work_order_id": workOrderId,
        "member_id": memberId,
        "vendor_id": vendorId,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
