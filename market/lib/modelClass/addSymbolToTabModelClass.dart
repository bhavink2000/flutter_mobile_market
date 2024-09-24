// To parse this JSON data, do
//
//     final addSymbolListModel = addSymbolListModelFromJson(jsonString);

import 'dart:convert';

AddSymbolListModel addSymbolListModelFromJson(String str) => AddSymbolListModel.fromJson(json.decode(str));

String addSymbolListModelToJson(AddSymbolListModel data) => json.encode(data.toJson());

class AddSymbolListModel {
  Meta? meta;
  AddedSymbolData? data;
  int? statusCode;

  AddSymbolListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory AddSymbolListModel.fromJson(Map<String, dynamic> json) => AddSymbolListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : AddedSymbolData.fromJson(json["data"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
        "statusCode": statusCode,
      };
}

class AddedSymbolData {
  String? userTabSymbolId;
  String? userTabId;
  String? userId;
  String? symbolId;
  String? symbolName;
  int? status;

  AddedSymbolData({
    this.userTabSymbolId,
    this.userTabId,
    this.userId,
    this.symbolId,
    this.symbolName,
    this.status,
  });

  factory AddedSymbolData.fromJson(Map<String, dynamic> json) => AddedSymbolData(
        userTabSymbolId: json["userTabSymbolId"],
        userTabId: json["userTabId"],
        userId: json["userId"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userTabSymbolId": userTabSymbolId,
        "userTabId": userTabId,
        "userId": userId,
        "symbolId": symbolId,
        "symbolName": symbolName,
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
