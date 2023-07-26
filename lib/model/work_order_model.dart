import 'dart:convert';

WorkOrderModel workOrderModelFromJson(String str)=> WorkOrderModel.fromJson(json.decode(str));

class WorkOrderModel {
  bool? status;
  String? message;
  List<Data>? data;

  WorkOrderModel({this.status, this.message, this.data});

  WorkOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? propertyId;
  String? workOrder;
  String? workTypeId;
  String? contractorId;
  Null contractorReceiveDate;
  String? contractorDueDate;
  Null contractorCompleteDate;
  String? vendorId;
  String? status;
  String? createdAt;
  String? updatedAt;
  WorkType? workType;
  Property? property;
  List<Photos>? photos;
  List<dynamic>? documents;
  List<dynamic>? messages;

  Data(
      {this.id,
      this.propertyId,
      this.workOrder,
      this.workTypeId,
      this.contractorId,
      this.contractorReceiveDate,
      this.contractorDueDate,
      this.contractorCompleteDate,
      this.vendorId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.workType,
      this.property,
      this.photos,
      this.documents,
      this.messages
      }
      );

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    workOrder = json['work_order'];
    workTypeId = json['work_type_id'];
    contractorId = json['contractor_id'];
    contractorReceiveDate = json['contractor_receive_date'];
    contractorDueDate = json['contractor_due_date'];
    contractorCompleteDate = json['contractor_complete_date'];
    vendorId = json['vendor_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    workType = json['work_type'] != null
        ? WorkType.fromJson(json['work_type'])
        : null;
    property = json['property'] != null
        ? Property.fromJson(json['property'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = [];
      json['documents'].forEach((v) {
        // documents!.add(fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        // messages!.add(fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['property_id'] =propertyId;
    data['work_order'] = workOrder;
    data['work_type_id'] = workTypeId;
    data['contractor_id'] = contractorId;
    data['contractor_receive_date'] = contractorReceiveDate;
    data['contractor_due_date'] = contractorDueDate;
    data['contractor_complete_date'] = contractorCompleteDate;
    data['vendor_id'] = vendorId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (workType != null) {
      data['work_type'] = workType!.toJson();
    }
    if (property != null) {
      data['property'] = property!.toJson();
    }
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkType {
  int? id;
  String? name;
  String? vendorId;
  String? createdAt;
  String? updatedAt;

  WorkType({this.id, this.name, this.vendorId, this.createdAt, this.updatedAt});

  WorkType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['vendor_id'] = vendorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Property {
  int? id;
  String? name;
  String? city;
  String? state;
  String? zip;
  String? address;
  String? vendorId;
  String? createdAt;
  String? updatedAt;

  Property(
      {this.id,
      this.name,
      this.city,
      this.state,
      this.zip,
      this.address,
      this.vendorId,
      this.createdAt,
      this.updatedAt});

  Property.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    address = json['address'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['address'] = address;
    data['vendor_id'] = vendorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Photos {
  int? id;
  String? photo;
  String? workOrderId;
  String? vendorId;
  String? createdAt;
  String? updatedAt;

  Photos(
      {this.id,
      this.photo,
      this.workOrderId,
      this.vendorId,
      this.createdAt,
      this.updatedAt});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    workOrderId = json['work_order_id'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['work_order_id'] = workOrderId;
    data['vendor_id'] = vendorId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
