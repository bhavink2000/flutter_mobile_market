// To parse this JSON data, do
//
//     final tradeMarginListModel = tradeMarginListModelFromJson(jsonString);

import 'dart:convert';

TradeMarginListModel tradeMarginListModelFromJson(String str) => TradeMarginListModel.fromJson(json.decode(str));

String tradeMarginListModelToJson(TradeMarginListModel data) => json.encode(data.toJson());

class TradeMarginListModel {
  Meta? meta;
  List<TradeMarginData>? data;
  int? statusCode;

  TradeMarginListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory TradeMarginListModel.fromJson(Map<String, dynamic> json) => TradeMarginListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<TradeMarginData>.from(json["data"]!.map((x) => TradeMarginData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class TradeMarginData {
  String? symbolId;
  String? symbolName;
  String? symbolTitle;
  String? exchangeId;
  String? exchangeName;
  DateTime? expiryDate;
  String? description;
  int? lotSize;
  int? tradeMargin;
  int? tradeTimingBy;
  num? tradeMarginAmount;
  String? tradeTimingByValue;
  String? tradeAttribute;
  int? allowTrade;
  String? allowTradeValue;
  bool? modifyStatus;
  int? status;

  TradeMarginData({
    this.symbolId,
    this.symbolName,
    this.symbolTitle,
    this.exchangeId,
    this.exchangeName,
    this.expiryDate,
    this.description,
    this.lotSize,
    this.tradeMargin,
    this.tradeTimingBy,
    this.tradeMarginAmount,
    this.tradeTimingByValue,
    this.tradeAttribute,
    this.allowTrade,
    this.allowTradeValue,
    this.modifyStatus,
    this.status,
  });

  factory TradeMarginData.fromJson(Map<String, dynamic> json) => TradeMarginData(
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        symbolTitle: json["symbolTitle"],
        exchangeId: json["exchangeId"],
        exchangeName: json["exchangeName"],
        expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
        description: json["description"],
        lotSize: json["lotSize"],
        tradeMargin: json["tradeMargin"],
        tradeMarginAmount: json["tradeMarginAmount"],
        tradeTimingBy: json["tradeTimingBy"],
        tradeTimingByValue: json["tradeTimingByValue"],
        tradeAttribute: json["tradeAttribute"],
        allowTrade: json["allowTrade"],
        allowTradeValue: json["allowTradeValue"],
        modifyStatus: json["modifyStatus"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "symbolId": symbolId,
        "symbolName": symbolName,
        "symbolTitle": symbolTitle,
        "exchangeId": exchangeId,
        "exchangeName": exchangeName,
        "expiryDate": expiryDate?.toIso8601String(),
        "description": description,
        "lotSize": lotSize,
        "tradeMargin": tradeMargin,
        "tradeMarginAmount": tradeMarginAmount,
        "tradeTimingBy": tradeTimingBy,
        "tradeTimingByValue": tradeTimingByValue,
        "tradeAttribute": tradeAttribute,
        "allowTrade": allowTrade,
        "allowTradeValue": allowTradeValue,
        "modifyStatus": modifyStatus,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
