// To parse this JSON data, do
//
//     final workOrderModel = workOrderModelFromJson(jsonString);

import 'dart:convert';

WorkOrderModel workOrderModelFromJson(String str) => WorkOrderModel.fromJson(json.decode(str));

String workOrderModelToJson(WorkOrderModel data) => json.encode(data.toJson());

class WorkOrderModel {
    bool status;
    String message;
    List<Data> data;

    WorkOrderModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory WorkOrderModel.fromJson(Map<String, dynamic> json) => WorkOrderModel(
        status: json["status"],
        message: json["message"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Data {
    int id;
    String propertyId;
    String workOrder;
    String workTypeId;
    String contractorId;
    dynamic contractorReceiveDate;
    DateTime contractorDueDate;
    dynamic contractorCompleteDate;
    String vendorId;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    WorkType workType;
    Property property;
    List<Photo> photos;
    List<Document> documents;
    List<dynamic> messages;

    Data({
        required this.id,
        required this.propertyId,
        required this.workOrder,
        required this.workTypeId,
        required this.contractorId,
        this.contractorReceiveDate,
        required this.contractorDueDate,
        this.contractorCompleteDate,
        required this.vendorId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.workType,
        required this.property,
        required this.photos,
        required this.documents,
        required this.messages,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        propertyId: json["property_id"],
        workOrder: json["work_order"],
        workTypeId: json["work_type_id"],
        contractorId: json["contractor_id"],
        contractorReceiveDate: json["contractor_receive_date"],
        contractorDueDate: DateTime.parse(json["contractor_due_date"]),
        contractorCompleteDate: json["contractor_complete_date"],
        vendorId: json["vendor_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        workType: WorkType.fromJson(json["work_type"]),
        property: Property.fromJson(json["property"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
        messages: List<dynamic>.from(json["messages"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "work_order": workOrder,
        "work_type_id": workTypeId,
        "contractor_id": contractorId,
        "contractor_receive_date": contractorReceiveDate,
        "contractor_due_date": contractorDueDate.toIso8601String(),
        "contractor_complete_date": contractorCompleteDate,
        "vendor_id": vendorId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "work_type": workType.toJson(),
        "property": property.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "messages": List<dynamic>.from(messages.map((x) => x)),
    };
}

class Document {
    int id;
    String file;
    String workOrderId;
    String vendorId;
    DateTime createdAt;
    DateTime updatedAt;

    Document({
        required this.id,
        required this.file,
        required this.workOrderId,
        required this.vendorId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        file: json["file"],
        workOrderId: json["work_order_id"],
        vendorId: json["vendor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "work_order_id": workOrderId,
        "vendor_id": vendorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Photo {
    int id;
    String photo;
    String? url;
    String workOrderId;
    String vendorId;
    DateTime createdAt;
    DateTime updatedAt;

    Photo({
        required this.id,
        required this.photo,
        this.url,
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

class Property {
    int id;
    String name;
    String city;
    String state;
    String zip;
    String address;
    String vendorId;
    DateTime createdAt;
    DateTime updatedAt;

    Property({
        required this.id,
        required this.name,
        required this.city,
        required this.state,
        required this.zip,
        required this.address,
        required this.vendorId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        address: json["address"],
        vendorId: json["vendor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "state": state,
        "zip": zip,
        "address": address,
        "vendor_id": vendorId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class WorkType {
    int id;
    String name;
    String vendorId;
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
