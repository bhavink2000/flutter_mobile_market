// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
    SignupModel({
        this.status,
        this.message,
        this.otp,
    });

    bool? status;
    String? message;
    int? otp;

    factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        status: json["status"],
        message: json["message"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "otp": otp,
    };
}
