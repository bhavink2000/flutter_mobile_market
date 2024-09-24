// To parse this JSON data, do
//
//     final bulkTradeModel = bulkTradeModelFromJson(jsonString);

import 'dart:convert';

BulkTradeModel bulkTradeModelFromJson(String str) => BulkTradeModel.fromJson(json.decode(str));

String bulkTradeModelToJson(BulkTradeModel data) => json.encode(data.toJson());

class BulkTradeModel {
  Meta? meta;
  List<BulkTradeData>? data;
  int? statusCode;

  BulkTradeModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory BulkTradeModel.fromJson(Map<String, dynamic> json) => BulkTradeModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<BulkTradeData>.from(json["data"]!.map((x) => BulkTradeData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class BulkTradeData {
  String? bulkTradeAlertId;
  String? symbolName;
  String? symbolId;
  String? symbolTitle;
  String? exchangeId;
  String? exchangeName;
  int? buyTotalQuantity;
  int? sellTotalQuantity;
  int? totalQuantity;
  DateTime? startDate;
  DateTime? endDate;
  int? status;

  BulkTradeData({
    this.bulkTradeAlertId,
    this.symbolName,
    this.symbolId,
    this.symbolTitle,
    this.exchangeId,
    this.exchangeName,
    this.buyTotalQuantity,
    this.sellTotalQuantity,
    this.totalQuantity,
    this.startDate,
    this.endDate,
    this.status,
  });

  factory BulkTradeData.fromJson(Map<String, dynamic> json) => BulkTradeData(
        bulkTradeAlertId: json["bulkTradeAlertId"],
        symbolName: json["symbolName"],
        symbolId: json["symbolId"],
        symbolTitle: json["symbolTitle"],
        exchangeId: json["exchangeId"],
        exchangeName: json["exchangeName"],
        buyTotalQuantity: json["buyTotalQuantity"],
        sellTotalQuantity: json["sellTotalQuantity"],
        totalQuantity: json["totalQuantity"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "bulkTradeAlertId": bulkTradeAlertId,
        "symbolName": symbolName,
        "symbolId": symbolId,
        "symbolTitle": symbolTitle,
        "exchangeId": exchangeId,
        "exchangeName": exchangeName,
        "buyTotalQuantity": buyTotalQuantity,
        "sellTotalQuantity": sellTotalQuantity,
        "totalQuantity": totalQuantity,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "status": status,
      };
}

class Meta {
  String? message;
  int? totalCount;
  int? currentPage;
  int? limit;
  int? totalPage;

  Meta({
    this.message,
    this.totalCount,
    this.currentPage,
    this.limit,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        totalCount: json["totalCount"],
        currentPage: json["currentPage"],
        limit: json["limit"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "totalCount": totalCount,
        "currentPage": currentPage,
        "limit": limit,
        "totalPage": totalPage,
      };
}
