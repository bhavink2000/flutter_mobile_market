// To parse this JSON data, do
//
//     final accountSuumaryListModel = accountSuumaryListModelFromJson(jsonString);

import 'dart:convert';

AccountSuumaryListModel accountSuumaryListModelFromJson(String str) => AccountSuumaryListModel.fromJson(json.decode(str));

String accountSuumaryListModelToJson(AccountSuumaryListModel data) => json.encode(data.toJson());

class AccountSuumaryListModel {
  Meta? meta;
  List<AccountSummaryData>? data;
  int? statusCode;

  AccountSuumaryListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory AccountSuumaryListModel.fromJson(Map<String, dynamic> json) => AccountSuumaryListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<AccountSummaryData>.from(json["data"]!.map((x) => AccountSummaryData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class AccountSummaryData {
  String? transactionId;
  String? userId;
  String? userName;
  String? naOfUser;
  String? symbolName;
  String? type;
  String? tradeId;
  String? transactionType;
  num? amount;
  int? quantity;
  num? price;
  num? total;
  num? positionDataQuantity;
  num? positionDataAveragePrice;
  num? closing;
  String? positionDataType;
  int? totalQuantity;
  String? tradeType;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? comment;
  String? fromUserName;

  AccountSummaryData({
    this.transactionId,
    this.userId,
    this.userName,
    this.naOfUser,
    this.symbolName,
    this.type,
    this.tradeId,
    this.transactionType,
    this.amount,
    this.quantity,
    this.price,
    this.total,
    this.closing,
    this.positionDataAveragePrice,
    this.positionDataQuantity,
    this.positionDataType,
    this.totalQuantity,
    this.tradeType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.comment,
    this.fromUserName,
  });

  factory AccountSummaryData.fromJson(Map<String, dynamic> json) => AccountSummaryData(
        transactionId: json["transactionId"],
        userId: json["userId"],
        userName: json["userName"],
        naOfUser: json["naOfUser"],
        symbolName: json["symbolName"],
        type: json["type"],
        tradeId: json["tradeId"],
        transactionType: json["transactionType"],
        amount: json["amount"],
        comment: json["comment"],
        fromUserName: json["fromUserName"],
        quantity: int.tryParse(json["quantity"].toString()) ?? 0,
        price: num.tryParse(json["price"].toString()) ?? 0.00,
        total: num.tryParse(json["total"].toString()) ?? 0.00,
        closing: num.tryParse(json["closing"].toString()) ?? 0.00,
        positionDataAveragePrice: num.tryParse(json["positionDataAveragePrice"].toString()) ?? 0.00,
        positionDataQuantity: num.tryParse(json["positionDataQuantity"].toString()) ?? 0.00,
        positionDataType: json["positionDataType"] ?? "",
        totalQuantity: int.tryParse(json["totalQuantity"].toString()) ?? 0,
        tradeType: json["tradeType"] ?? "",
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "userId": userId,
        "userName": userName,
        "naOfUser": naOfUser,
        "symbolName": symbolName,
        "type": type,
        "tradeId": tradeId,
        "transactionType": transactionType,
        "amount": amount,
        "quantity": quantity,
        "price": price,
        "total": total,
        "closing": closing,
        "positionDataAveragePrice": positionDataAveragePrice,
        "positionDataQuantity": positionDataQuantity,
        "positionDataType": positionDataType,
        "totalQuantity": totalQuantity,
        "tradeType": tradeType,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "fromUserName": fromUserName,
        "comment": comment,
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
