// To parse this JSON data, do
//
//     final allSymbolListModel = allSymbolListModelFromJson(jsonString);

import 'dart:convert';

AllSymbolListModel allSymbolListModelFromJson(String str) => AllSymbolListModel.fromJson(json.decode(str));

String allSymbolListModelToJson(AllSymbolListModel data) => json.encode(data.toJson());

class AllSymbolListModel {
  Meta? meta;
  List<GlobalSymbolData>? data;
  int? statusCode;

  AllSymbolListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory AllSymbolListModel.fromJson(Map<String, dynamic> json) => AllSymbolListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<GlobalSymbolData>.from(json["data"]!.map((x) => GlobalSymbolData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class GlobalSymbolData {
  String? symbolId;
  String? symbolName;
  String? symbolTitle;
  String? exchangeId;
  String? exchangeName;
  DateTime? expiryDate;
  String? description;
  num? lotSize;
  num? ask;
  num? bid;
  num? ch;
  num? chp;
  num? close;
  num? high;
  num? low;
  num? ls;
  num? ltp;
  num? oi;
  num? open;
  num? tbq;
  num? ts;
  num? tsq;
  num? volume;
  num? oddLotTrade;
  num? tradeMargin;
  num? tradeTimingBy;
  String? tradeTimingByValue;
  String? tradeAttribute;
  num? allowTrade;
  String? allowTradeValue;
  bool? modifyStatus;
  num? status;
  bool isApiCallRunning = false;

  GlobalSymbolData({
    this.symbolId,
    this.symbolName,
    this.symbolTitle,
    this.exchangeId,
    this.exchangeName,
    this.expiryDate,
    this.description,
    this.lotSize,
    this.ask,
    this.bid,
    this.ch,
    this.chp,
    this.close,
    this.high,
    this.low,
    this.ls,
    this.ltp,
    this.oi,
    this.open,
    this.tbq,
    this.ts,
    this.tsq,
    this.volume,
    this.oddLotTrade,
    this.tradeMargin,
    this.tradeTimingBy,
    this.tradeTimingByValue,
    this.tradeAttribute,
    this.allowTrade,
    this.allowTradeValue,
    this.modifyStatus,
    this.status,
  });

  factory GlobalSymbolData.fromJson(Map<String, dynamic> json) => GlobalSymbolData(
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        symbolTitle: json["symbolTitle"],
        exchangeId: json["exchangeId"],
        exchangeName: json["exchangeName"],
        expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
        description: json["description"],
        lotSize: json["lotSize"],
        ask: json["ask"]?.toDouble(),
        bid: json["bid"]?.toDouble(),
        ch: json["ch"]?.toDouble(),
        chp: json["chp"]?.toDouble(),
        close: json["close"],
        high: json["high"]?.toDouble(),
        low: json["low"]?.toDouble(),
        ls: json["ls"],
        ltp: json["ltp"]?.toDouble(),
        oi: json["oi"],
        open: json["open"]?.toDouble(),
        tbq: json["tbq"],
        ts: json["ts"]?.toDouble(),
        tsq: json["tsq"],
        volume: json["volume"],
        oddLotTrade: json["oddLotTrade"],
        tradeMargin: json["tradeMargin"],
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
        "ask": ask,
        "bid": bid,
        "ch": ch,
        "chp": chp,
        "close": close,
        "high": high,
        "low": low,
        "ls": ls,
        "ltp": ltp,
        "oi": oi,
        "open": open,
        "tbq": tbq,
        "ts": ts,
        "tsq": tsq,
        "volume": volume,
        "oddLotTrade": oddLotTrade,
        "tradeMargin": tradeMargin,
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

  Meta({
    this.message,
    this.totalCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "totalCount": totalCount,
      };
}
