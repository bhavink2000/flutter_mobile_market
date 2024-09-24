// To parse this JSON data, do
//
//     final tradeLogsModel = tradeLogsModelFromJson(jsonString);

import 'dart:convert';

TradeLogsModel tradeLogsModelFromJson(String str) => TradeLogsModel.fromJson(json.decode(str));

String tradeLogsModelToJson(TradeLogsModel data) => json.encode(data.toJson());

class TradeLogsModel {
  Meta? meta;
  List<TradeLogData>? data;
  int? statusCode;

  TradeLogsModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory TradeLogsModel.fromJson(Map<String, dynamic> json) => TradeLogsModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<TradeLogData>.from(json["data"]!.map((x) => TradeLogData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class TradeLogData {
  String? tradeId;
  String? positionId;
  String? userId;
  String? parentId;
  String? parentUserName;
  String? naOfUser;
  String? userName;
  String? naOfUpdatedUser;
  String? userUpdatedName;
  String? symbolId;
  String? symbolName;
  String? symbolTitle;
  num? quantity;
  num? oldQuantity;
  num? oldPrice;
  num? price;
  num? oldBrokerageAmount;
  num? brokerageAmount;
  num? totalQuantity;
  num? oldTotalQuantity;
  num? lotSize;
  num? total;
  num? oldTotal;
  String? productType;
  String? productTypeValue;
  String? tradeType;
  String? tradeTypeValue;
  String? orderTypeValue;
  String? orderType;
  String? oldOrderTypeValue;
  String? exchangeName;
  String? oldOrderType;
  String? ipAddress;
  String? deviceId;
  String? orderMethod;
  DateTime? executionDateTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  TradeLogData({
    this.tradeId,
    this.positionId,
    this.userId,
    this.parentId,
    this.parentUserName,
    this.naOfUser,
    this.userName,
    this.naOfUpdatedUser,
    this.userUpdatedName,
    this.symbolId,
    this.exchangeName,
    this.symbolName,
    this.symbolTitle,
    this.quantity,
    this.oldQuantity,
    this.oldPrice,
    this.price,
    this.oldBrokerageAmount,
    this.brokerageAmount,
    this.totalQuantity,
    this.oldTotalQuantity,
    this.lotSize,
    this.total,
    this.oldTotal,
    this.productType,
    this.productTypeValue,
    this.tradeType,
    this.tradeTypeValue,
    this.orderTypeValue,
    this.orderType,
    this.oldOrderTypeValue,
    this.oldOrderType,
    this.ipAddress,
    this.deviceId,
    this.orderMethod,
    this.executionDateTime,
    this.createdAt,
    this.updatedAt,
  });

  factory TradeLogData.fromJson(Map<String, dynamic> json) => TradeLogData(
        tradeId: json["tradeId"],
        positionId: json["positionId"],
        userId: json["userId"],
        parentId: json["parentId"],
        parentUserName: json["parentUserName"],
        naOfUser: json["naOfUser"],
        userName: json["userName"],
        naOfUpdatedUser: json["naOfUpdatedUser"],
        userUpdatedName: json["userUpdatedName"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        symbolTitle: json["symbolTitle"],
        quantity: json["quantity"],
        oldQuantity: json["oldQuantity"],
        oldPrice: json["oldPrice"],
        price: json["price"],
        exchangeName: json["exchangeName"],
        oldBrokerageAmount: json["oldBrokerageAmount"],
        brokerageAmount: json["brokerageAmount"],
        totalQuantity: json["totalQuantity"],
        oldTotalQuantity: json["oldTotalQuantity"],
        lotSize: json["lotSize"],
        total: json["total"],
        oldTotal: json["oldTotal"],
        productType: json["productType"],
        productTypeValue: json["productTypeValue"],
        tradeType: json["tradeType"],
        tradeTypeValue: json["tradeTypeValue"],
        orderTypeValue: json["orderTypeValue"],
        orderType: json["orderType"],
        oldOrderTypeValue: json["oldOrderTypeValue"],
        oldOrderType: json["oldOrderType"],
        ipAddress: json["ipAddress"],
        deviceId: json["deviceId"],
        orderMethod: json["orderMethod"],
        executionDateTime: json["executionDateTime"] == null || json["executionDateTime"] == "" ? null : DateTime.parse(json["executionDateTime"]),
        createdAt: json["createdAt"] == null || json["createdAt"] == "" ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null || json["updatedAt"] == "" ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "tradeId": tradeId,
        "positionId": positionId,
        "userId": userId,
        "parentId": parentId,
        "parentUserName": parentUserName,
        "naOfUser": naOfUser,
        "userName": userName,
        "naOfUpdatedUser": naOfUpdatedUser,
        "userUpdatedName": userUpdatedName,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "symbolTitle": symbolTitle,
        "quantity": quantity,
        "oldQuantity": oldQuantity,
        "oldPrice": oldPrice,
        "price": price,
        "exchangeName": exchangeName,
        "oldBrokerageAmount": oldBrokerageAmount,
        "brokerageAmount": brokerageAmount,
        "totalQuantity": totalQuantity,
        "oldTotalQuantity": oldTotalQuantity,
        "lotSize": lotSize,
        "total": total,
        "oldTotal": oldTotal,
        "productType": productType,
        "productTypeValue": productTypeValue,
        "tradeType": tradeType,
        "tradeTypeValue": tradeTypeValue,
        "orderTypeValue": orderTypeValue,
        "orderType": orderType,
        "oldOrderTypeValue": oldOrderTypeValue,
        "oldOrderType": oldOrderType,
        "ipAddress": ipAddress,
        "deviceId": deviceId,
        "orderMethod": orderMethod,
        "executionDateTime": executionDateTime?.toIso8601String(),
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
