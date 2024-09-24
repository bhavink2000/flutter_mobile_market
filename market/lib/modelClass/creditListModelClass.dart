// To parse this JSON data, do
//
//     final creditListModel = creditListModelFromJson(jsonString);

import 'dart:convert';

CreditListModel creditListModelFromJson(String str) => CreditListModel.fromJson(json.decode(str));

String creditListModelToJson(CreditListModel data) => json.encode(data.toJson());

class CreditListModel {
  Meta? meta;
  List<creditData>? data;
  int? statusCode;

  CreditListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory CreditListModel.fromJson(Map<String, dynamic> json) => CreditListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<creditData>.from(json["data"]!.map((x) => creditData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class creditData {
  String? transactionId;
  String? userId;
  String? from;
  String? fromName;
  String? fromUserName;
  String? to;
  String? toName;
  String? toUserName;
  num? amount;
  num balance = 0.0;
  String? transactionType;
  String? type;
  String? comment;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  creditData({
    this.transactionId,
    this.userId,
    this.from,
    this.fromName,
    this.fromUserName,
    this.to,
    this.toName,
    this.toUserName,
    this.amount,
    this.transactionType,
    this.type,
    this.comment,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory creditData.fromJson(Map<String, dynamic> json) => creditData(
        transactionId: json["transactionId"],
        userId: json["userId"],
        from: json["from"],
        fromName: json["fromName"],
        fromUserName: json["fromUserName"],
        to: json["to"],
        toName: json["toName"],
        toUserName: json["toUserName"],
        amount: json["amount"],
        transactionType: json["transactionType"],
        type: json["type"],
        comment: json["comment"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "userId": userId,
        "from": from,
        "fromName": fromName,
        "fromUserName": fromUserName,
        "to": to,
        "toName": toName,
        "toUserName": toUserName,
        "amount": amount,
        "transactionType": transactionType,
        "type": type,
        "comment": comment,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Meta {
  String? message;
  int? creditAmount;
  int? debitAmount;
  int? totalAmount;

  Meta({
    this.message,
    this.creditAmount,
    this.debitAmount,
    this.totalAmount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        creditAmount: json["creditAmount"],
        debitAmount: json["debitAmount"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "creditAmount": creditAmount,
        "debitAmount": debitAmount,
        "totalAmount": totalAmount,
      };
}
