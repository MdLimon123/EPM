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
  int? id;
  String? uidno;
  String? name;
  String? email;
  String? password;
  dynamic company;
  String? photo;
  String? role;

  Data({
    this.id,
    this.uidno,
    this.name,
    this.email,
    this.password,
    this.company,
    this.photo,
    this.role,
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
      };
}
