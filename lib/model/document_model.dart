// To parse this JSON data, do
//
//     final documentModel = documentModelFromJson(jsonString);


import 'dart:convert';

DocumentModel documentModelFromJson(String str) => DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
    bool status;
    String hostName;
    List<Datum> data;

    DocumentModel({
        required this.status,
        required this.hostName,
        required this.data,
    });

    factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
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
    String file;
    dynamic url;
    String workOrderId;
    String vendorId;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.file,
        required this.url,
        required this.workOrderId,
        required this.vendorId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        file: json["file"],
        url: json["url"],
        workOrderId: json["work_order_id"],
        vendorId: json["vendor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "url": url,
        "work_order_id": workOrderId,
        "vendor_id": vendorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
