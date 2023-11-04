// To parse this JSON data, do
//
//     final addWorkModel = addWorkModelFromJson(jsonString);

import 'dart:convert';

AddWorkModel addWorkModelFromJson(String str) => AddWorkModel.fromJson(json.decode(str));

String addWorkModelToJson(AddWorkModel data) => json.encode(data.toJson());

class AddWorkModel {
  bool status;
  String message;
  List<Chat>? chats;

  AddWorkModel({
    required this.status,
    required this.message,
     this.chats,
  });

  factory AddWorkModel.fromJson(Map<String, dynamic> json) => AddWorkModel(
    status: json["status"],
    message: json["message"],
    chats:(json['chats'] != null)? List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))):null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "chats":chats != null ? List<dynamic>.from(chats!.map((x) => x.toJson())):null,
  };
}

class Chat {
  int id;
  String workOrderId;
  String description;
  String additionalInstruction;
  String qty;
  String price;
  DateTime createdAt;
  DateTime updatedAt;

  Chat({
    required this.id,
    required this.workOrderId,
    required this.description,
    required this.additionalInstruction,
    required this.qty,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    workOrderId: json["work_order_id"],
    description: json["description"],
    additionalInstruction: json["additional_instruction"],
    qty: json["qty"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "work_order_id": workOrderId,
    "description": description,
    "additional_instruction": additionalInstruction,
    "qty": qty,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
