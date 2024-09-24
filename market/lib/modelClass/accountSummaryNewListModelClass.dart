// To parse this JSON data, do
//
//     final accountSummaryNewListModel = accountSummaryNewListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';

AccountSummaryNewListModel accountSummaryNewListModelFromJson(String str) => AccountSummaryNewListModel.fromJson(json.decode(str));

String accountSummaryNewListModelToJson(AccountSummaryNewListModel data) => json.encode(data.toJson());

class AccountSummaryNewListModel {
  Meta? meta;
  List<AccountSummaryNewListData>? data;
  num? statusCode;

  AccountSummaryNewListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory AccountSummaryNewListModel.fromJson(Map<String, dynamic> json) => AccountSummaryNewListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<AccountSummaryNewListData>.from(json["data"]!.map((x) => AccountSummaryNewListData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class AccountSummaryNewListData {
  // TransactionId? transactionId;
  String? userId;
  String? userName;
  String? parentUserName;
  String? naOfUser;
  String? symbolTitle;
  String? symbolName;
  String? exchangeName;
  String? exchangeId;
  String? symbolId;
  num? profitLoss;
  num? brokerageTotal;
  num? buyTotalQuantity;
  num? buyTotalLot;
  num? buyTotalPrice;
  num? buyPrice;
  num? sellTotalLot;
  num? sellPrice;
  num? sellTotalPrice;
  num? sellTotalQuantity;
  num? totalQuantity;
  num? totalLot;
  num? avgPrice;
  num? ask;
  num? bid;
  num? ltp;
  num? positionBrokerageTotal;
  List<PositionDatum>? positionData;
  List<TradeDatum>? tradeData;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? currentPriceFromSocket = 0.0;
  double? profitLossValue = 0.0;
  num? profitAndLossSharing = 0.0;
  num? adminBrokerageTotal;
  num? totalShareQuantity = 0.0;
  num total = 0.0;
  num ourPer = 0.0;
  Rx<ScriptData> scriptDataFromSocket = ScriptData().obs;

  AccountSummaryNewListData({
    // this.transactionId,
    this.userId,
    this.userName,
    this.parentUserName,
    this.naOfUser,
    this.symbolTitle,
    this.symbolName,
    this.exchangeName,
    this.exchangeId,
    this.symbolId,
    this.profitLoss,
    this.brokerageTotal,
    this.buyTotalQuantity,
    this.buyTotalLot,
    this.buyTotalPrice,
    this.buyPrice,
    this.sellTotalLot,
    this.sellPrice,
    this.ask,
    this.bid,
    this.ltp,
    this.sellTotalPrice,
    this.sellTotalQuantity,
    this.totalQuantity,
    this.totalLot,
    this.avgPrice,
    this.positionBrokerageTotal,
    this.positionData,
    this.tradeData,
    this.createdAt,
    this.updatedAt,
    this.profitAndLossSharing,
    this.totalShareQuantity,
    this.adminBrokerageTotal,
  });

  factory AccountSummaryNewListData.fromJson(Map<String, dynamic> json) => AccountSummaryNewListData(
        // transactionId: json["transactionId"] == null ? null : TransactionId.fromJson(json["transactionId"]),
        userId: json["userId"],
        userName: json["userName"],
        parentUserName: json["parentUserName"],
        naOfUser: json["naOfUser"],
        symbolTitle: json["symbolTitle"],
        symbolName: json["symbolName"],
        exchangeName: json["exchangeName"],
        exchangeId: json["exchangeId"],
        symbolId: json["symbolId"],
        profitLoss: json["profitLoss"],
        brokerageTotal: json["brokerageTotal"],
        buyTotalQuantity: json["buyTotalQuantity"],
        buyTotalLot: json["buyTotalLot"],
        buyTotalPrice: json["buyTotalPrice"],
        buyPrice: json["buyPrice"],
        sellTotalLot: json["sellTotalLot"],
        sellPrice: json["sellPrice"],
        sellTotalPrice: json["sellTotalPrice"],
        totalShareQuantity: json["totalShareQuantity"] ?? 0.0,
        adminBrokerageTotal: json["adminBrokerageTotal"],
        ask: json["ask"] == "" || json["ask"] == null ? 0.0 : json["ask"],
        bid: json["bid"] == "" || json["bid"] == null ? 0.0 : json["bid"],
        ltp: json["ltp"] == "" || json["ltp"] == null ? 0.0 : json["ltp"],
        sellTotalQuantity: json["sellTotalQuantity"],
        totalQuantity: json["totalQuantity"],
        totalLot: json["totalLot"],
        avgPrice: json["avgPrice"],
        profitAndLossSharing: json["profitAndLossSharing"] ?? 0.0,
        positionBrokerageTotal: json["positionBrokerageTotal"] ?? 0.0,
        positionData: json["positionData"] == null ? [] : List<PositionDatum>.from(json["positionData"]!.map((x) => PositionDatum.fromJson(x))),
        tradeData: json["tradeData"] == null ? [] : List<TradeDatum>.from(json["tradeData"]!.map((x) => TradeDatum.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        // "transactionId": transactionId?.toJson(),
        "userId": userId,
        "userName": userName,
        "parentUserName": parentUserName,
        "naOfUser": naOfUser,
        "symbolTitle": symbolTitle,
        "symbolName": symbolName,
        "exchangeName": exchangeName,
        "symbolId": symbolId,
        "profitLoss": profitLoss,
        "brokerageTotal": brokerageTotal,
        "buyTotalQuantity": buyTotalQuantity,
        "buyTotalLot": buyTotalLot,
        "buyTotalPrice": buyTotalPrice,
        "buyPrice": buyPrice,
        "sellTotalLot": sellTotalLot,
        "exchangeId": exchangeId,
        "sellPrice": sellPrice,
        "sellTotalPrice": sellTotalPrice,
        "sellTotalQuantity": sellTotalQuantity,
        "totalQuantity": totalQuantity,
        "totalLot": totalLot,
        "avgPrice": avgPrice,
        "ask": ask,
        "bid": bid,
        "ltp": ltp,
        "adminBrokerageTotal": adminBrokerageTotal,
        "totalShareQuantity": totalShareQuantity,
        "profitAndLossSharing": profitAndLossSharing,
        "positionBrokerageTotal": positionBrokerageTotal,
        "positionData": positionData == null ? [] : List<dynamic>.from(positionData!.map((x) => x.toJson())),
        "tradeData": tradeData == null ? [] : List<dynamic>.from(tradeData!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class PositionDatum {
  String? id;
  String? userId;
  String? symbolId;
  String? symbolName;
  num? buyQuantity;
  num? buyPrice;
  num? buyLotSize;
  num? buyTotalQuantity;
  num? buyTotal;
  num? buyStopLoss;
  num? sellQuantity;
  num? sellPrice;
  num? sellLotSize;
  num? sellTotalQuantity;
  num? sellTotal;
  num? sellStopLoss;
  num? quantity;
  num? price;
  num? lotSize;
  num? totalQuantity;
  num? totalSlQuantity;
  num? slQuantity;
  num? total;
  num? stopLoss;
  String? productType;
  String? tradeType;
  double? tradeMargin;
  num? tradeMarginPrice;
  num? tradeMarginTotal;
  num? profitLoss;
  String? exchangeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  PositionDatum({
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
    this.profitLoss,
    this.exchangeId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PositionDatum.fromJson(Map<String, dynamic> json) => PositionDatum(
        id: json["_id"],
        userId: json["userId"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        buyQuantity: json["buyQuantity"],
        buyPrice: json["buyPrice"],
        buyLotSize: json["buyLotSize"],
        buyTotalQuantity: json["buyTotalQuantity"],
        buyTotal: json["buyTotal"],
        buyStopLoss: json["buyStopLoss"],
        sellQuantity: json["sellQuantity"],
        sellPrice: json["sellPrice"],
        sellLotSize: json["sellLotSize"],
        sellTotalQuantity: json["sellTotalQuantity"],
        sellTotal: json["sellTotal"],
        sellStopLoss: json["sellStopLoss"],
        quantity: json["quantity"],
        price: json["price"],
        lotSize: json["lotSize"],
        totalQuantity: json["totalQuantity"],
        totalSlQuantity: json["totalSLQuantity"],
        slQuantity: json["slQuantity"],
        total: json["total"],
        stopLoss: json["stopLoss"],
        productType: json["productType"],
        tradeType: json["tradeType"],
        tradeMargin: json["tradeMargin"]?.toDouble(),
        tradeMarginPrice: json["tradeMarginPrice"],
        tradeMarginTotal: json["tradeMarginTotal"],
        profitLoss: json["profitLoss"],
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
        "profitLoss": profitLoss,
        "exchangeId": exchangeId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class TradeDatum {
  String? id;
  String? userId;
  String? symbolId;
  String? symbolName;
  num? quantity;
  double? price;
  num? brokerageAmount;
  bool? isTurnoverWise;
  bool? isSymbolWise;
  bool? isBrokerageCalculated;
  num? lotSize;
  num? totalQuantity;
  num? stopLoss;
  double? total;
  String? productType;
  String? tradeType;
  String? exchangeId;
  String? orderType;
  String? ipAddress;
  String? deviceId;
  String? orderMethod;
  double? tradeMargin;
  double? tradeMarginPrice;
  double? tradeMarginTotal;
  DateTime? executionDateTime;
  bool? carryforwardOldStatus;
  bool? carryforwardNewStatus;
  bool? squareOff;
  num? profitLoss;
  bool? pendingToExecuted;
  bool? modified;
  String? status;
  String? parentId;
  String? symbolTitle;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  TradeDatum({
    this.id,
    this.userId,
    this.symbolId,
    this.symbolName,
    this.quantity,
    this.price,
    this.brokerageAmount,
    this.isTurnoverWise,
    this.isSymbolWise,
    this.isBrokerageCalculated,
    this.lotSize,
    this.totalQuantity,
    this.stopLoss,
    this.total,
    this.productType,
    this.tradeType,
    this.exchangeId,
    this.orderType,
    this.ipAddress,
    this.deviceId,
    this.orderMethod,
    this.tradeMargin,
    this.tradeMarginPrice,
    this.tradeMarginTotal,
    this.executionDateTime,
    this.carryforwardOldStatus,
    this.carryforwardNewStatus,
    this.squareOff,
    this.profitLoss,
    this.pendingToExecuted,
    this.modified,
    this.status,
    this.parentId,
    this.symbolTitle,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TradeDatum.fromJson(Map<String, dynamic> json) => TradeDatum(
        id: json["_id"],
        userId: json["userId"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        brokerageAmount: json["brokerageAmount"],
        isTurnoverWise: json["isTurnoverWise"],
        isSymbolWise: json["isSymbolWise"],
        isBrokerageCalculated: json["isBrokerageCalculated"],
        lotSize: json["lotSize"],
        totalQuantity: json["totalQuantity"],
        stopLoss: json["stopLoss"],
        total: json["total"]?.toDouble(),
        productType: json["productType"],
        tradeType: json["tradeType"],
        exchangeId: json["exchangeId"],
        orderType: json["orderType"],
        ipAddress: json["ipAddress"],
        deviceId: json["deviceId"],
        orderMethod: json["orderMethod"],
        tradeMargin: json["tradeMargin"]?.toDouble(),
        tradeMarginPrice: json["tradeMarginPrice"]?.toDouble(),
        tradeMarginTotal: json["tradeMarginTotal"]?.toDouble(),
        executionDateTime: json["executionDateTime"] == null ? null : DateTime.parse(json["executionDateTime"]),
        carryforwardOldStatus: json["carryforwardOldStatus"],
        carryforwardNewStatus: json["carryforwardNewStatus"],
        squareOff: json["squareOff"],
        profitLoss: json["profitLoss"],
        pendingToExecuted: json["pendingToExecuted"],
        modified: json["modified"],
        status: json["status"],
        parentId: json["parentId"],
        symbolTitle: json["symbolTitle"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "quantity": quantity,
        "price": price,
        "brokerageAmount": brokerageAmount,
        "isTurnoverWise": isTurnoverWise,
        "isSymbolWise": isSymbolWise,
        "isBrokerageCalculated": isBrokerageCalculated,
        "lotSize": lotSize,
        "totalQuantity": totalQuantity,
        "stopLoss": stopLoss,
        "total": total,
        "productType": productType,
        "tradeType": tradeType,
        "exchangeId": exchangeId,
        "orderType": orderType,
        "ipAddress": ipAddress,
        "deviceId": deviceId,
        "orderMethod": orderMethod,
        "tradeMargin": tradeMargin,
        "tradeMarginPrice": tradeMarginPrice,
        "tradeMarginTotal": tradeMarginTotal,
        "executionDateTime": executionDateTime?.toIso8601String(),
        "carryforwardOldStatus": carryforwardOldStatus,
        "carryforwardNewStatus": carryforwardNewStatus,
        "squareOff": squareOff,
        "profitLoss": profitLoss,
        "pendingToExecuted": pendingToExecuted,
        "modified": modified,
        "status": status,
        "parentId": parentId,
        "symbolTitle": symbolTitle,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class TransactionId {
  String? symbolId;
  String? userId;

  TransactionId({
    this.symbolId,
    this.userId,
  });

  factory TransactionId.fromJson(Map<String, dynamic> json) => TransactionId(
        symbolId: json["symbolId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "symbolId": symbolId,
        "userId": userId,
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
