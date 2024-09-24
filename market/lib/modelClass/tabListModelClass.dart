// To parse this JSON data, do
//
//     final tabListModel = tabListModelFromJson(jsonString);

import 'dart:convert';

TabListModel tabListModelFromJson(String str) => TabListModel.fromJson(json.decode(str));

String tabListModelToJson(TabListModel data) => json.encode(data.toJson());

class TabListModel {
  Meta? meta;
  List<TabData>? data;
  int? statusCode;

  TabListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory TabListModel.fromJson(Map<String, dynamic> json) => TabListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<TabData>.from(json["data"]!.map((x) => TabData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class TabData {
  String? userTabId;
  String? title;
  String? exchangeId;
  int? status;

  TabData({
    this.userTabId,
    this.title,
    this.exchangeId,
    this.status,
  });

  factory TabData.fromJson(Map<String, dynamic> json) => TabData(
        userTabId: json["userTabId"],
        title: json["title"],
        exchangeId: json["exchangeId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userTabId": userTabId,
        "title": title,
        "exchangeId": exchangeId,
        "status": status,
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
