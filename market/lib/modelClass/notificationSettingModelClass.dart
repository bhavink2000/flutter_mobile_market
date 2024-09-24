// To parse this JSON data, do
//
//     final notificationSettingModel = notificationSettingModelFromJson(jsonString);

import 'dart:convert';

NotificationSettingModel notificationSettingModelFromJson(String str) => NotificationSettingModel.fromJson(json.decode(str));

String notificationSettingModelToJson(NotificationSettingModel data) => json.encode(data.toJson());

class NotificationSettingModel {
  Meta? meta;
  NotificationSettingData? data;
  int? statusCode;

  NotificationSettingModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory NotificationSettingModel.fromJson(Map<String, dynamic> json) => NotificationSettingModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : NotificationSettingData.fromJson(json["data"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
        "statusCode": statusCode,
      };
}

class NotificationSettingData {
  String? userNotificationSettingId;
  bool? marketOrder;
  bool? pendingOrder;
  bool? executePendingOrder;
  bool? deletePendingOrder;
  bool? treadingSound;

  NotificationSettingData({
    this.userNotificationSettingId,
    this.marketOrder,
    this.pendingOrder,
    this.executePendingOrder,
    this.deletePendingOrder,
    this.treadingSound,
  });

  factory NotificationSettingData.fromJson(Map<String, dynamic> json) => NotificationSettingData(
        userNotificationSettingId: json["userNotificationSettingId"],
        marketOrder: json["marketOrder"],
        pendingOrder: json["pendingOrder"],
        executePendingOrder: json["executePendingOrder"],
        deletePendingOrder: json["deletePendingOrder"],
        treadingSound: json["treadingSound"],
      );

  Map<String, dynamic> toJson() => {
        "userNotificationSettingId": userNotificationSettingId,
        "marketOrder": marketOrder,
        "pendingOrder": pendingOrder,
        "executePendingOrder": executePendingOrder,
        "deletePendingOrder": deletePendingOrder,
        "treadingSound": treadingSound,
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
