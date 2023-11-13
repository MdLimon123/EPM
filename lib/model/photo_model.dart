// To parse this JSON data, do
//
//     final photoModel = photoModelFromJson(jsonString);

import 'dart:convert';

PhotoModel photoModelFromJson(String str) => PhotoModel.fromJson(json.decode(str));

String photoModelToJson(PhotoModel data) => json.encode(data.toJson());

class PhotoModel {
    bool status;
    String hostName;
    List<Datum> data;

    PhotoModel({
        required this.status,
        required this.hostName,
        required this.data,
    });

    factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        status: json["status"],
        hostName: json["host_name"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "host_name": hostName,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String photo;
    String? url;
    bool isSelected;
    int workOrderId;
    int vendorId;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.photo,
        this.url,
        this.isSelected= false,
        required this.workOrderId,
        required this.vendorId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        photo: json["photo"],
        url: json["url"],
        workOrderId: json["work_order_id"],
        vendorId: json["vendor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "url": url,
        "work_order_id": workOrderId,
        "vendor_id": vendorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
