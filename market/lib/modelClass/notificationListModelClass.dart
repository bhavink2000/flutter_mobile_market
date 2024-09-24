// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
  Meta? meta;
  List<NotificationData>? data;
  int? statusCode;

  NotificationListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class NotificationData {
  String? notificationId;
  String? tradeId;
  String? userId;
  String? from;
  String? title;
  String? message;
  DateTime? createdAt;

  NotificationData({
    this.notificationId,
    this.tradeId,
    this.userId,
    this.from,
    this.title,
    this.message,
    this.createdAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        notificationId: json["notificationId"],
        tradeId: json["tradeId"],
        userId: json["userId"],
        from: json["from"],
        title: json["title"],
        message: json["message"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "notificationId": notificationId,
        "tradeId": tradeId,
        "userId": userId,
        "from": from,
        "title": title,
        "message": message,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class Meta {
  String? message;
  int? totalCount;
  int? currentPage;

  int? totalPage;

  Meta({
    this.message,
    this.totalCount,
    this.currentPage,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        totalCount: json["totalCount"],
        currentPage: json["currentPage"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "totalCount": totalCount,
        "currentPage": currentPage,
        "totalPage": totalPage,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
