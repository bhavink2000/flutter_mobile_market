// To parse this JSON data, do
//
//     final tradeDetailModel = tradeDetailModelFromJson(jsonString);

import 'dart:convert';

TradeDetailModel tradeDetailModelFromJson(String str) => TradeDetailModel.fromJson(json.decode(str));

String tradeDetailModelToJson(TradeDetailModel data) => json.encode(data.toJson());

class TradeDetailModel {
  Meta? meta;
  TradeDetailData? data;
  int? statusCode;

  TradeDetailModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory TradeDetailModel.fromJson(Map<String, dynamic> json) => TradeDetailModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : TradeDetailData.fromJson(json["data"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
        "statusCode": statusCode,
      };
}

class TradeDetailData {
  String? tradeId;
  String? positionId;
  String? userId;
  String? parentId;
  String? naOfUser;
  String? userName;
  String? symbolId;
  String? symbolName;
  String? symbolTitle;
  num? price;
  int? quantity;
  int? lotSize;
  int? totalQuantity;
  num? stopLoss;
  num? total;
  int? buyTotalQuantity;
  num? buyTotal;
  num? buyPrice;
  num? sellTotalQuantity;
  num? sellTotal;
  num? sellPrice;
  String? orderType;
  String? orderTypeValue;
  String? tradeType;
  String? tradeTypeValue;
  String? exchangeId;
  String? exchangeName;
  String? productType;
  String? productTypeValue;
  double? brokerageAmount;
  String? ipAddress;
  String? deviceId;
  String? orderMethod;
  String? status;
  DateTime? executionDateTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  TradeDetailData({
    this.tradeId,
    this.positionId,
    this.userId,
    this.parentId,
    this.naOfUser,
    this.userName,
    this.symbolId,
    this.symbolName,
    this.symbolTitle,
    this.price,
    this.quantity,
    this.lotSize,
    this.totalQuantity,
    this.stopLoss,
    this.total,
    this.buyTotalQuantity,
    this.buyTotal,
    this.buyPrice,
    this.sellTotalQuantity,
    this.sellTotal,
    this.sellPrice,
    this.orderType,
    this.orderTypeValue,
    this.tradeType,
    this.tradeTypeValue,
    this.exchangeId,
    this.exchangeName,
    this.productType,
    this.productTypeValue,
    this.brokerageAmount,
    this.ipAddress,
    this.deviceId,
    this.orderMethod,
    this.status,
    this.executionDateTime,
    this.createdAt,
    this.updatedAt,
  });

  factory TradeDetailData.fromJson(Map<String, dynamic> json) => TradeDetailData(
        tradeId: json["tradeId"],
        positionId: json["positionId"],
        userId: json["userId"],
        parentId: json["parentId"],
        naOfUser: json["naOfUser"],
        userName: json["userName"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        symbolTitle: json["symbolTitle"],
        price: json["price"],
        quantity: json["quantity"],
        lotSize: json["lotSize"],
        totalQuantity: json["totalQuantity"],
        stopLoss: json["stopLoss"],
        total: json["total"],
        buyTotalQuantity: json["buyTotalQuantity"],
        buyTotal: json["buyTotal"],
        buyPrice: json["buyPrice"],
        sellTotalQuantity: json["sellTotalQuantity"],
        sellTotal: json["sellTotal"],
        sellPrice: json["sellPrice"],
        orderType: json["orderType"],
        orderTypeValue: json["orderTypeValue"],
        tradeType: json["tradeType"],
        tradeTypeValue: json["tradeTypeValue"],
        exchangeId: json["exchangeId"],
        exchangeName: json["exchangeName"],
        productType: json["productType"],
        productTypeValue: json["productTypeValue"],
        brokerageAmount: json["brokerageAmount"]?.toDouble(),
        ipAddress: json["ipAddress"],
        deviceId: json["deviceId"],
        orderMethod: json["orderMethod"],
        status: json["status"],
        executionDateTime: json["executionDateTime"] == null ? null : DateTime.parse(json["executionDateTime"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "tradeId": tradeId,
        "positionId": positionId,
        "userId": userId,
        "parentId": parentId,
        "naOfUser": naOfUser,
        "userName": userName,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "symbolTitle": symbolTitle,
        "price": price,
        "quantity": quantity,
        "lotSize": lotSize,
        "totalQuantity": totalQuantity,
        "stopLoss": stopLoss,
        "total": total,
        "buyTotalQuantity": buyTotalQuantity,
        "buyTotal": buyTotal,
        "buyPrice": buyPrice,
        "sellTotalQuantity": sellTotalQuantity,
        "sellTotal": sellTotal,
        "sellPrice": sellPrice,
        "orderType": orderType,
        "orderTypeValue": orderTypeValue,
        "tradeType": tradeType,
        "tradeTypeValue": tradeTypeValue,
        "exchangeId": exchangeId,
        "exchangeName": exchangeName,
        "productType": productType,
        "productTypeValue": productTypeValue,
        "brokerageAmount": brokerageAmount,
        "ipAddress": ipAddress,
        "deviceId": deviceId,
        "orderMethod": orderMethod,
        "status": status,
        "executionDateTime": executionDateTime?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
