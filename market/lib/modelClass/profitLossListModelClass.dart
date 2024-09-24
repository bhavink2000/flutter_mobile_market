// To parse this JSON data, do
//
//     final profitLossListModel = profitLossListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';

ProfitLossListModel profitLossListModelFromJson(String str) => ProfitLossListModel.fromJson(json.decode(str));

String profitLossListModelToJson(ProfitLossListModel data) => json.encode(data.toJson());

class ProfitLossListModel {
  Meta? meta;
  List<ProfitLossData>? data;
  num? statusCode;

  ProfitLossListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory ProfitLossListModel.fromJson(Map<String, dynamic> json) => ProfitLossListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<ProfitLossData>.from(json["data"]!.map((x) => ProfitLossData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class ProfitLossData {
  String? userId;
  String? parentId;
  String? role;
  String? roleName;
  String? userName;
  String? name;
  double? profitLoss;
  double plPer = 0.0;
  num? brokerageTotal;
  num? profitAndLossSharing;
  num? profitAndLossSharingDownLine;
  num? brkSharing;
  num? brkSharingDownLine;
  DateTime? createdAt;
  List<ChildUserDataPosition>? childUserDataPosition;
  double totalProfitLossValue = 0;
  double plWithBrk = 0;
  double netPL = 0;
  num childUserProfitLossTotal = 0.0;
  num childUserBrokerageTotal = 0.0;
  num parentBrokerageTotal = 0.0;

  ProfitLossData({
    this.userId,
    this.parentId,
    this.role,
    this.roleName,
    this.userName,
    this.name,
    this.profitLoss,
    this.brokerageTotal,
    this.profitAndLossSharing,
    this.profitAndLossSharingDownLine,
    this.brkSharing,
    this.brkSharingDownLine,
    this.createdAt,
    this.childUserDataPosition,
  });

  factory ProfitLossData.fromJson(Map<String, dynamic> json) => ProfitLossData(
        userId: json["userId"],
        parentId: json["parentId"],
        role: json["role"],
        roleName: json["roleName"],
        userName: json["userName"],
        name: json["name"],
        profitLoss: json["profitLoss"]?.toDouble(),
        brokerageTotal: json["brokerageTotal"],
        profitAndLossSharing: json["profitAndLossSharing"],
        profitAndLossSharingDownLine: json["profitAndLossSharingDownLine"],
        brkSharing: json["brkSharing"],
        brkSharingDownLine: json["brkSharingDownLine"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        childUserDataPosition: json["childUserDataPosition"] == null ? [] : List<ChildUserDataPosition>.from(json["childUserDataPosition"]!.map((x) => ChildUserDataPosition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "parentId": parentId,
        "role": role,
        "roleName": roleName,
        "userName": userName,
        "name": name,
        "profitLoss": profitLoss,
        "brokerageTotal": brokerageTotal,
        "profitAndLossSharing": profitAndLossSharing,
        "profitAndLossSharingDownLine": profitAndLossSharingDownLine,
        "brkSharing": brkSharing,
        "brkSharingDownLine": brkSharingDownLine,
        "createdAt": createdAt?.toIso8601String(),
        "childUserDataPosition": childUserDataPosition == null ? [] : List<dynamic>.from(childUserDataPosition!.map((x) => x.toJson())),
      };
}

class ChildUserDataPosition {
  String? id;
  String? userId;
  String? symbolId;
  String? symbolName;
  num? buyQuantity;
  double? buyPrice;
  num? buyLotSize;
  num? buyTotalQuantity;
  double? buyTotal;
  num? buyStopLoss;
  num? sellQuantity;
  num? sellPrice;
  num? sellLotSize;
  num? sellTotalQuantity;
  num? sellTotal;
  num? sellStopLoss;
  num? quantity;
  double? price;
  num? lotSize;
  num? totalQuantity;
  num? totalSlQuantity;
  num? slQuantity;
  double? total;
  num? stopLoss;
  String? productType;
  String? tradeType;
  num? tradeMargin;
  double? tradeMarginPrice;
  double? tradeMarginTotal;
  String? exchangeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  double? profitLossValue = 0;
  Rx<ScriptData> scriptDataFromSocket = ScriptData().obs;

  ChildUserDataPosition({
    this.id,
    this.userId,
    this.symbolId,
    this.symbolName,
    this.buyQuantity,
    this.buyPrice,
    this.buyLotSize,
    this.buyTotalQuantity,
    this.buyTotal,
    this.buyStopLoss,
    this.sellQuantity,
    this.sellPrice,
    this.sellLotSize,
    this.sellTotalQuantity,
    this.sellTotal,
    this.sellStopLoss,
    this.quantity,
    this.price,
    this.lotSize,
    this.totalQuantity,
    this.totalSlQuantity,
    this.slQuantity,
    this.total,
    this.stopLoss,
    this.productType,
    this.tradeType,
    this.tradeMargin,
    this.tradeMarginPrice,
    this.tradeMarginTotal,
    this.exchangeId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ChildUserDataPosition.fromJson(Map<String, dynamic> json) => ChildUserDataPosition(
        id: json["_id"],
        userId: json["userId"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        buyQuantity: json["buyQuantity"],
        buyPrice: json["buyPrice"]?.toDouble(),
        buyLotSize: json["buyLotSize"],
        buyTotalQuantity: json["buyTotalQuantity"],
        buyTotal: json["buyTotal"]?.toDouble(),
        buyStopLoss: json["buyStopLoss"],
        sellQuantity: json["sellQuantity"],
        sellPrice: json["sellPrice"],
        sellLotSize: json["sellLotSize"],
        sellTotalQuantity: json["sellTotalQuantity"],
        sellTotal: json["sellTotal"],
        sellStopLoss: json["sellStopLoss"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        lotSize: json["lotSize"],
        totalQuantity: json["totalQuantity"],
        totalSlQuantity: json["totalSLQuantity"],
        slQuantity: json["slQuantity"],
        total: json["total"]?.toDouble(),
        stopLoss: json["stopLoss"],
        productType: json["productType"],
        tradeType: json["tradeType"],
        tradeMargin: json["tradeMargin"],
        tradeMarginPrice: json["tradeMarginPrice"]?.toDouble(),
        tradeMarginTotal: json["tradeMarginTotal"]?.toDouble(),
        exchangeId: json["exchangeId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "buyQuantity": buyQuantity,
        "buyPrice": buyPrice,
        "buyLotSize": buyLotSize,
        "buyTotalQuantity": buyTotalQuantity,
        "buyTotal": buyTotal,
        "buyStopLoss": buyStopLoss,
        "sellQuantity": sellQuantity,
        "sellPrice": sellPrice,
        "sellLotSize": sellLotSize,
        "sellTotalQuantity": sellTotalQuantity,
        "sellTotal": sellTotal,
        "sellStopLoss": sellStopLoss,
        "quantity": quantity,
        "price": price,
        "lotSize": lotSize,
        "totalQuantity": totalQuantity,
        "totalSLQuantity": totalSlQuantity,
        "slQuantity": slQuantity,
        "total": total,
        "stopLoss": stopLoss,
        "productType": productType,
        "tradeType": tradeType,
        "tradeMargin": tradeMargin,
        "tradeMarginPrice": tradeMarginPrice,
        "tradeMarginTotal": tradeMarginTotal,
        "exchangeId": exchangeId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Meta {
  String? message;
  num? totalCount;
  num? currentPage;
  num? limit;
  num? totalPage;

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
