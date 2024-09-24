// To parse this JSON data, do
//
//     final m2MProfitLossModel = m2MProfitLossModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:market/modelClass/getScriptFromSocket.dart';

M2MProfitLossModel m2MProfitLossModelFromJson(String str) =>
    M2MProfitLossModel.fromJson(json.decode(str));

String m2MProfitLossModelToJson(M2MProfitLossModel data) =>
    json.encode(data.toJson());

class M2MProfitLossModel {
  Meta? meta;
  List<m2mProfitLossData>? data;
  int? statusCode;

  M2MProfitLossModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory M2MProfitLossModel.fromJson(Map<String, dynamic> json) =>
      M2MProfitLossModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<m2mProfitLossData>.from(
                json["data"]!.map((x) => m2mProfitLossData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class m2mProfitLossData {
  String? userId;
  String? parentId;
  String? role;
  String? roleName;
  String? userName;
  String? name;
  int? profitAndLossSharing;
  int? profitAndLossSharingDownLine;
  int? brkSharing;
  int? brkSharingDownLine;
  DateTime? createdAt;
  List<ChildUserDataPosition>? childUserDataPosition;
  double totalProfitLossValue = 0;

  m2mProfitLossData({
    this.userId,
    this.parentId,
    this.role,
    this.roleName,
    this.userName,
    this.name,
    this.profitAndLossSharing,
    this.profitAndLossSharingDownLine,
    this.brkSharing,
    this.brkSharingDownLine,
    this.createdAt,
    this.childUserDataPosition,
  });

  factory m2mProfitLossData.fromJson(Map<String, dynamic> json) =>
      m2mProfitLossData(
        userId: json["userId"],
        parentId: json["parentId"],
        role: json["role"],
        roleName: json["roleName"],
        userName: json["userName"],
        name: json["name"],
        profitAndLossSharing: json["profitAndLossSharing"],
        profitAndLossSharingDownLine: json["profitAndLossSharingDownLine"],
        brkSharing: json["brkSharing"],
        brkSharingDownLine: json["brkSharingDownLine"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        childUserDataPosition: json["childUserDataPosition"] == null
            ? []
            : List<ChildUserDataPosition>.from(json["childUserDataPosition"]!
                .map((x) => ChildUserDataPosition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "parentId": parentId,
        "role": role,
        "roleName": roleName,
        "userName": userName,
        "name": name,
        "profitAndLossSharing": profitAndLossSharing,
        "profitAndLossSharingDownLine": profitAndLossSharingDownLine,
        "brkSharing": brkSharing,
        "brkSharingDownLine": brkSharingDownLine,
        "createdAt": createdAt?.toIso8601String(),
        "childUserDataPosition": childUserDataPosition == null
            ? []
            : List<dynamic>.from(childUserDataPosition!.map((x) => x.toJson())),
      };
  @override
  bool operator ==(other) {
    if (other is m2mProfitLossData) {
      return this.userName == other.userName;
    } else {
      return false;
    }
  }
}

class ChildUserDataPosition {
  String? id;
  String? userId;
  String? symbolId;
  String? symbolName;
  int? quantity;
  double? price;
  int? lotSize;
  int? totalQuantity;
  double? total;
  String? productType;
  String? tradeType;
  String? exchangeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? stopLoss;
  double? profitLossValue = 0;
  Rx<ScriptData> scriptDataFromSocket = ScriptData().obs;

  ChildUserDataPosition({
    this.id,
    this.userId,
    this.symbolId,
    this.symbolName,
    this.quantity,
    this.price,
    this.lotSize,
    this.totalQuantity,
    this.total,
    this.productType,
    this.tradeType,
    this.exchangeId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.stopLoss,
  });

  factory ChildUserDataPosition.fromJson(Map<String, dynamic> json) =>
      ChildUserDataPosition(
        id: json["_id"],
        userId: json["userId"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        lotSize: json["lotSize"],
        totalQuantity: json["totalQuantity"],
        total: json["total"]?.toDouble(),
        productType: json["productType"],
        tradeType: json["tradeType"],
        exchangeId: json["exchangeId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        stopLoss: json["stopLoss"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "quantity": quantity,
        "price": price,
        "lotSize": lotSize,
        "totalQuantity": totalQuantity,
        "total": total,
        "productType": productType,
        "tradeType": tradeType,
        "exchangeId": exchangeId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "stopLoss": stopLoss,
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
