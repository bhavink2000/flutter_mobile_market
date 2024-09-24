// To parse this JSON data, do
//
//     final tradeExecuteModel = tradeExecuteModelFromJson(jsonString);

import 'dart:convert';

TradeExecuteModel tradeExecuteModelFromJson(String str) => TradeExecuteModel.fromJson(json.decode(str));

String tradeExecuteModelToJson(TradeExecuteModel data) => json.encode(data.toJson());

class TradeExecuteModel {
  Meta? meta;
  tradeExecuteData? data;
  int? statusCode;
  String? message;

  TradeExecuteModel({
    this.meta,
    this.data,
    this.statusCode,
    this.message,
  });

  factory TradeExecuteModel.fromJson(Map<String, dynamic> json) => TradeExecuteModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : tradeExecuteData.fromJson(json["data"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
        "statusCode": statusCode,
        "message": message,
      };
}

class tradeExecuteData {
  String? tradeId;
  String? userId;
  String? naOfUser;
  String? userName;
  String? symbolId;
  String? symbolName;
  num? price;
  num? quantity;
  num? lotSize;
  num? totalQuantity;
  num? stopLoss;
  num? total;
  String? orderType;
  String? orderTypeValue;
  String? tradeType;
  String? tradeTypeValue;
  String? exchangeId;
  String? exchangeName;
  String? productType;
  String? productTypeValue;
  String? status;

  tradeExecuteData({
    this.tradeId,
    this.userId,
    this.naOfUser,
    this.userName,
    this.symbolId,
    this.symbolName,
    this.price,
    this.quantity,
    this.lotSize,
    this.totalQuantity,
    this.stopLoss,
    this.total,
    this.orderType,
    this.orderTypeValue,
    this.tradeType,
    this.tradeTypeValue,
    this.exchangeId,
    this.exchangeName,
    this.productType,
    this.productTypeValue,
    this.status,
  });

  factory tradeExecuteData.fromJson(Map<String, dynamic> json) => tradeExecuteData(
        tradeId: json["tradeId"],
        userId: json["userId"],
        naOfUser: json["naOfUser"],
        userName: json["userName"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        price: json["price"],
        quantity: json["quantity"],
        lotSize: json["lotSize"],
        totalQuantity: json["totalQuantity"],
        stopLoss: json["stopLoss"],
        total: json["total"],
        orderType: json["orderType"],
        orderTypeValue: json["orderTypeValue"],
        tradeType: json["tradeType"],
        tradeTypeValue: json["tradeTypeValue"],
        exchangeId: json["exchangeId"],
        exchangeName: json["exchangeName"],
        productType: json["productType"],
        productTypeValue: json["productTypeValue"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tradeId": tradeId,
        "userId": userId,
        "naOfUser": naOfUser,
        "userName": userName,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "price": price,
        "quantity": quantity,
        "lotSize": lotSize,
        "totalQuantity": totalQuantity,
        "stopLoss": stopLoss,
        "total": total,
        "orderType": orderType,
        "orderTypeValue": orderTypeValue,
        "tradeType": tradeType,
        "tradeTypeValue": tradeTypeValue,
        "exchangeId": exchangeId,
        "exchangeName": exchangeName,
        "productType": productType,
        "productTypeValue": productTypeValue,
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
