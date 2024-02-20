// To parse this JSON data, do
//
//     final workOrderModel = workOrderModelFromJson(jsonString);

import 'dart:convert';

WorkOrderModel workOrderModelFromJson(String str) => WorkOrderModel.fromJson(json.decode(str));

String workOrderModelToJson(WorkOrderModel data) => json.encode(data.toJson());

class WorkOrderModel {
    bool status;
    String message;
    List<Datum> data;

    WorkOrderModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory WorkOrderModel.fromJson(Map<String, dynamic> json) => WorkOrderModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    dynamic propertyId;
    String workOrder;
    String address;
    int workTypeId;
    int categoryId;
    int contractorId;
    dynamic contractorReceiveDate;
    DateTime contractorDueDate;
    String specialInstruction;
    dynamic contractorCompleteDate;
    int vendorId;
    int status;
    dynamic readyForOffice;
    DateTime createdAt;
    DateTime updatedAt;
    WorkType workType;
    dynamic property;
    List<Photo> photos;
    List<dynamic> documents;
    List<dynamic> messages;

    Datum({
        required this.id,
        required this.propertyId,
        required this.workOrder,
        required this.address,
        required this.workTypeId,
        required this.categoryId,
        required this.contractorId,
        required this.contractorReceiveDate,
        required this.contractorDueDate,
        required this.specialInstruction,
        required this.contractorCompleteDate,
        required this.vendorId,
        required this.status,
        required this.readyForOffice,
        required this.createdAt,
        required this.updatedAt,
        required this.workType,
        required this.property,
        required this.photos,
        required this.documents,
        required this.messages,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        propertyId: json["property_id"],
        workOrder: json["work_order"],
        address: json["address"],
        workTypeId: json["work_type_id"],
        categoryId: json["category_id"],
        contractorId: json["contractor_id"],
        contractorReceiveDate: json["contractor_receive_date"],
        contractorDueDate: DateTime.parse(json["contractor_due_date"]),
        specialInstruction: json["special_instruction"],
        contractorCompleteDate: json["contractor_complete_date"],
        vendorId: json["vendor_id"],
        status: json["status"],
        readyForOffice: json["ready_for_office"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        workType: WorkType.fromJson(json["work_type"]),
        property: json["property"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        messages: List<dynamic>.from(json["messages"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "work_order": workOrder,
        "address": address,
        "work_type_id": workTypeId,
        "category_id": categoryId,
        "contractor_id": contractorId,
        "contractor_receive_date": contractorReceiveDate,
        "contractor_due_date": contractorDueDate.toIso8601String(),
        "special_instruction": specialInstruction,
        "contractor_complete_date": contractorCompleteDate,
        "vendor_id": vendorId,
        "status": status,
        "ready_for_office": readyForOffice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "work_type": workType.toJson(),
        "property": property,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "messages": List<dynamic>.from(messages.map((x) => x)),
    };
}

class Photo {
    int id;
    String photo;
    String url;
    int workOrderId;
    int vendorId;
    DateTime createdAt;
    DateTime updatedAt;

    Photo({
        required this.id,
        required this.photo,
        required this.url,
        required this.workOrderId,
        required this.vendorId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
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

class WorkType {
    int id;
    String name;
    int vendorId;
    DateTime createdAt;
    DateTime updatedAt;

    WorkType({
        required this.id,
        required this.name,
        required this.vendorId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory WorkType.fromJson(Map<String, dynamic> json) => WorkType(
        id: json["id"],
        name: json["name"],
        vendorId: json["vendor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "vendor_id": vendorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
