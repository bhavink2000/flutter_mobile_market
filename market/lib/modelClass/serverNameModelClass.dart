// To parse this JSON data, do
//
//     final serverNameModel = serverNameModelFromJson(jsonString);

import 'dart:convert';

ServerNameModel serverNameModelFromJson(String str) => ServerNameModel.fromJson(json.decode(str));

String serverNameModelToJson(ServerNameModel data) => json.encode(data.toJson());

class ServerNameModel {
  Meta? meta;
  ServerData? data;
  int? statusCode;

  ServerNameModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory ServerNameModel.fromJson(Map<String, dynamic> json) => ServerNameModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : ServerData.fromJson(json["data"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
        "statusCode": statusCode,
      };
}

class ServerData {
  String? serverName;

  ServerData({
    this.serverName,
  });

  factory ServerData.fromJson(Map<String, dynamic> json) => ServerData(
        serverName: json["serverName"],
      );

  Map<String, dynamic> toJson() => {
        "serverName": serverName,
      };
}

class Meta {
  String? message;

  Meta({
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
