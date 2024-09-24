// To parse this JSON data, do
//
//     final positionTrackListModel = positionTrackListModelFromJson(jsonString);

import 'dart:convert';

PositionTrackListModel positionTrackListModelFromJson(String str) => PositionTrackListModel.fromJson(json.decode(str));

String positionTrackListModelToJson(PositionTrackListModel data) => json.encode(data.toJson());

class PositionTrackListModel {
  Meta? meta;
  List<PositionTrackData>? data;
  int? statusCode;

  PositionTrackListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory PositionTrackListModel.fromJson(Map<String, dynamic> json) => PositionTrackListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<PositionTrackData>.from(json["data"]!.map((x) => PositionTrackData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class PositionTrackData {
  String? tradeId;
  String? positionId;
  String? userId;
  String? parentId;
  String? naOfUser;
  String? userName;
  String? symbolId;
  String? symbolName;
  String? symbolTitle;
  int? quantity;
  int? lotSize;
  int? totalQuantity;
  String? orderType;
  String? ipAddress;
  String? deviceId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  PositionTrackData({
    this.tradeId,
    this.positionId,
    this.userId,
    this.parentId,
    this.naOfUser,
    this.userName,
    this.symbolId,
    this.symbolName,
    this.symbolTitle,
    this.quantity,
    this.lotSize,
    this.totalQuantity,
    this.orderType,
    this.ipAddress,
    this.deviceId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PositionTrackData.fromJson(Map<String, dynamic> json) => PositionTrackData(
        tradeId: json["tradeId"],
        positionId: json["positionId"],
        userId: json["userId"],
        parentId: json["parentId"],
        naOfUser: json["naOfUser"],
        userName: json["userName"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        symbolTitle: json["symbolTitle"],
        quantity: json["quantity"],
        lotSize: json["lotSize"],
        totalQuantity: json["totalQuantity"],
        orderType: json["orderType"],
        ipAddress: json["ipAddress"],
        deviceId: json["deviceId"],
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
        "quantity": quantity,
        "lotSize": lotSize,
        "totalQuantity": totalQuantity,
        "orderType": orderType,
        "ipAddress": ipAddress,
        "deviceId": deviceId,
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
