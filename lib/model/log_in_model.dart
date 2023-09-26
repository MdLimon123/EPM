// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) => LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
    bool status;
    String message;
    String accessToken;

    LogInModel({
        required this.status,
        required this.message,
        required this.accessToken,
    });

    factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        status: json["status"],
        message: json["message"],
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "access_token": accessToken,
    };
}
