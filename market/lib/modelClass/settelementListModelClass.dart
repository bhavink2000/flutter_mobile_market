// To parse this JSON data, do
//
//     final settelementListModel = settelementListModelFromJson(jsonString);

import 'dart:convert';

SettlementListModel settelementListModelFromJson(String str) => SettlementListModel.fromJson(json.decode(str));

String settelementListModelToJson(SettlementListModel data) => json.encode(data.toJson());

class SettlementListModel {
  Meta? meta;
  SettelementData? data;
  int? statusCode;

  SettlementListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory SettlementListModel.fromJson(Map<String, dynamic> json) => SettlementListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : SettelementData.fromJson(json["data"]),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
        "statusCode": statusCode,
      };
}

class SettelementData {
  List<Profit>? profit;
  List<Profit>? loss;
  double plProfitGrandTotal = 0;
  double brkProfitGrandTotal = 0;
  double profitGrandTotal = 0;
  double plLossGrandTotal = 0;
  double brkLossGrandTotal = 0;
  double LossGrandTotal = 0;
  int? plStatus;
  num? myPLTotal;

  SettelementData({
    this.profit,
    this.loss,
    this.plStatus,
    this.myPLTotal,
  });

  factory SettelementData.fromJson(Map<String, dynamic> json) => SettelementData(
        profit: json["profit"] == null ? [] : List<Profit>.from(json["profit"]!.map((x) => Profit.fromJson(x))),
        loss: json["loss"] == null ? [] : List<Profit>.from(json["loss"]!.map((x) => Profit.fromJson(x))),
        plStatus: json["plStatus"],
        myPLTotal: json["myPLTotal"],
      );

  Map<String, dynamic> toJson() => {
        "profit": profit == null ? [] : List<dynamic>.from(profit!.map((x) => x.toJson())),
        "loss": loss == null ? [] : List<dynamic>.from(loss!.map((x) => x.toJson())),
        "plStatus": plStatus,
        "myPLTotal": myPLTotal,
      };
}

// To parse this JSON data, do
//
//     final profit = profitFromJson(jsonString);

class Profit {
  String? userId;
  String? userName;
  String? name;
  String? displayName;
  num? profitLoss;
  num? brokerageTotal;
  num? total;
  String? createdAt;

  Profit({
    this.userId,
    this.userName,
    this.name,
    this.displayName,
    this.profitLoss,
    this.brokerageTotal,
    this.total,
    this.createdAt,
  });

  factory Profit.fromJson(Map<String, dynamic> json) => Profit(
        userId: json["userId"],
        userName: json["userName"],
        name: json["name"],
        displayName: json["displayName"],
        profitLoss: json["profitLoss"],
        brokerageTotal: json["brokerageTotal"],
        total: json["total"]?.toDouble(),
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "name": name,
        "displayName": displayName,
        "profitLoss": profitLoss,
        "brokerageTotal": brokerageTotal,
        "total": total,
        "createdAt": createdAt,
      };
}

class Meta {
  String? message;
  int? totalProfitCount;
  int? currentPage;
  int? limit;
  int? totalPage;

  Meta({
    this.message,
    this.totalProfitCount,
    this.currentPage,
    this.limit,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        totalProfitCount: json["totalProfitCount"],
        currentPage: json["currentPage"],
        limit: json["limit"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "totalProfitCount": totalProfitCount,
        "currentPage": currentPage,
        "limit": limit,
        "totalPage": totalPage,
      };
}
