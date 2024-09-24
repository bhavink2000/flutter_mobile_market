// To parse this JSON data, do
//
//     final userWiseNetPositionModel = userWiseNetPositionModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

import 'getScriptFromSocket.dart';

UserWiseNetPositionModel userWiseNetPositionModelFromJson(String str) => UserWiseNetPositionModel.fromJson(json.decode(str));

String userWiseNetPositionModelToJson(UserWiseNetPositionModel data) => json.encode(data.toJson());

class UserWiseNetPositionModel {
  Meta? meta;
  List<UWNPData>? data;
  int? statusCode;

  UserWiseNetPositionModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory UserWiseNetPositionModel.fromJson(Map<String, dynamic> json) => UserWiseNetPositionModel(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<UWNPData>.from(json["data"]!.map((x) => UWNPData.fromJson(x))),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "statusCode": statusCode,
  };
}

class UWNPData {
  String? tradeId;
  String? positionId;
  String? userId;
  String? parentId;
  String? naOfUser;
  String? userName;
  String? symbolId;
  String? symbolName;
  String? symbolTitle;
  dynamic price;
  dynamic quantity;
  dynamic lotSize;
  dynamic totalQuantity;
  dynamic stopLoss;
  dynamic total;
  dynamic buyTotalQuantity;
  dynamic buyTotal;
  dynamic buyPrice;
  dynamic sellTotalQuantity;
  dynamic sellTotal;
  dynamic sellPrice;
  String? orderType;
  String? orderTypeValue;
  String? tradeType;
  String? tradeTypeValue;
  String? exchangeId;
  String? exchangeName;
  String? productType;
  String? productTypeValue;
  dynamic brokerageAmount;
  String? ipAddress;
  String? deviceId;
  String? orderMethod;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? currentPriceFromSocket;
  double profitLossValue = 0;
  Rx<ScriptData> scriptDataFromSocket = ScriptData().obs;

  UWNPData({
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
    this.createdAt,
    this.updatedAt,
    this.currentPriceFromSocket,
    this.profitLossValue = 0
  });

  factory UWNPData.fromJson(Map<String, dynamic> json) => UWNPData(
    tradeId: json["tradeId"],
    positionId: json["positionId"],
    userId: json["userId"],
    parentId: json["parentId"],
    naOfUser: json["naOfUser"],
    userName: json["userName"],
    symbolId: json["symbolId"],
    symbolName: json["symbolName"],
    symbolTitle: json["symbolTitle"],
    price: json["price"]?.toDouble(),
    quantity: json["quantity"],
    lotSize: json["lotSize"],
    totalQuantity: json["totalQuantity"],
    stopLoss: json["stopLoss"],
    total: json["total"]?.toDouble(),
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
    brokerageAmount: json["brokerageAmount"],
    ipAddress: json["ipAddress"],
    deviceId: json["deviceId"],
    orderMethod: json["orderMethod"],
    status: json["status"],
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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
