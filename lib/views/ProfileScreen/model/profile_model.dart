// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool status;
  String message;
  Data data;

  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String uidno;
  String name;
  String email;
  String password;
  dynamic company;
  String photo;
  String role;
  String parentId;
  dynamic phone;
  dynamic address;
  dynamic city;
  dynamic zip;
  dynamic state;
  String token;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.uidno,
    required this.name,
    required this.email,
    required this.password,
    required this.company,
    required this.photo,
    required this.role,
    required this.parentId,
    required this.phone,
    required this.address,
    required this.city,
    required this.zip,
    required this.state,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uidno: json["uidno"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        company: json["company"],
        photo: json["photo"],
        role: json["role"],
        parentId: json["parent_id"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        zip: json["zip"],
        state: json["state"],
        token: json["token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uidno": uidno,
        "name": name,
        "email": email,
        "password": password,
        "company": company,
        "photo": photo,
        "role": role,
        "parent_id": parentId,
        "phone": phone,
        "address": address,
        "city": city,
        "zip": zip,
        "state": state,
        "token": token,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
