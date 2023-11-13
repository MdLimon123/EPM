// To parse this JSON data, do
//
//     final workEstimationModel = workEstimationModelFromJson(jsonString);

import 'dart:convert';

WorkEstimationModel workEstimationModelFromJson(String str) => WorkEstimationModel.fromJson(json.decode(str));

String workEstimationModelToJson(WorkEstimationModel data) => json.encode(data.toJson());

class WorkEstimationModel {
  bool status;
  String message;
  List<Estimation> estimations;

  WorkEstimationModel({
    required this.status,
    required this.message,
    required this.estimations,
  });

  factory WorkEstimationModel.fromJson(Map<String, dynamic> json) => WorkEstimationModel(
    status: json["status"],
    message: json["message"],
    estimations: List<Estimation>.from(json["estimations"].map((x) => Estimation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "estimations": List<dynamic>.from(estimations.map((x) => x.toJson())),
  };
}

class Estimation {
  int id;
  String item;
  int qty;
  int contractorPrice;
  int contractorTotal;
  dynamic clientPrice;
  dynamic clientTotal;
  String comment;
  int workOrderId;
  dynamic vendorId;
  DateTime createdAt;
  DateTime updatedAt;

  Estimation({
    required this.id,
    required this.item,
    required this.qty,
    required this.contractorPrice,
    required this.contractorTotal,
    required this.clientPrice,
    required this.clientTotal,
    required this.comment,
    required this.workOrderId,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Estimation.fromJson(Map<String, dynamic> json) => Estimation(
    id: json["id"],
    item: json["item"],
    qty: json["qty"],
    contractorPrice: json["contractor_price"],
    contractorTotal: json["contractor_total"],
    clientPrice: json["client_price"],
    clientTotal: json["client_total"],
    comment: json["comment"],
    workOrderId: json["work_order_id"],
    vendorId: json["vendor_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item": item,
    "qty": qty,
    "contractor_price": contractorPrice,
    "contractor_total": contractorTotal,
    "client_price": clientPrice,
    "client_total": clientTotal,
    "comment": comment,
    "work_order_id": workOrderId,
    "vendor_id": vendorId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
