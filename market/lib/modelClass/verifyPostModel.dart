import 'dart:convert';

VerifyPostModel verifyPostModelFromJson(String str) => VerifyPostModel.fromJson(json.decode(str));

String verifyPostModelModelToJson(VerifyPostModel data) => json.encode(data.toJson());

class VerifyPostModel {
  bool? status;
  String? message;
  int? TotalPendingHelp;

  VerifyPostModel({
    this.status,
    this.message,
    this.TotalPendingHelp,
  });

  factory VerifyPostModel.fromJson(Map<String, dynamic> json) => VerifyPostModel(
        status: json["status"],
        message: json["message"],
        TotalPendingHelp: json["TotalPendingHelp"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "TotalPendingHelp": TotalPendingHelp,
      };
}
