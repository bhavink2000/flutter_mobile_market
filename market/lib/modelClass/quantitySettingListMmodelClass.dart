// To parse this JSON data, do
//
//     final quantitySettingListModel = quantitySettingListModelFromJson(jsonString);

import 'dart:convert';

QuantitySettingListModel quantitySettingListModelFromJson(String str) => QuantitySettingListModel.fromJson(json.decode(str));

String quantitySettingListModelToJson(QuantitySettingListModel data) => json.encode(data.toJson());

class QuantitySettingListModel {
    Meta? meta;
    List<QuantitySettingData>? data;
    int? statusCode;

    QuantitySettingListModel({
        this.meta,
        this.data,
        this.statusCode,
    });

    factory QuantitySettingListModel.fromJson(Map<String, dynamic> json) => QuantitySettingListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<QuantitySettingData>.from(json["data"]!.map((x) => QuantitySettingData.fromJson(x))),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
    };
}

class QuantitySettingData {
    String? userWiseGroupDataAssociationId;
    String? groupId;
    String? groupName;
    String? exchangeId;
    String? exchangeName;
    String? symbolId;
    String? symbolName;
    int? lotSize;
    int? quantityMax;
    int? lotMax;
    int? breakQuantity;
    int? breakUpLot;
    String? updatedBy;
    String? updatedByName;
    String? updatedByUserName;
    String? userId;
    String? nameOfUser;
    String? userName;
    int? status;
     DateTime? createdAt;
    DateTime? updatedAt;
    bool isSelected;

    QuantitySettingData({
        this.userWiseGroupDataAssociationId,
        this.groupId,
        this.groupName,
        this.exchangeId,
        this.exchangeName,
        this.symbolId,
        this.symbolName,
        this.lotSize,
        this.quantityMax,
        this.lotMax,
        this.breakQuantity,
        this.breakUpLot,
        this.updatedBy,
        this.updatedByName,
        this.updatedByUserName,
        this.userId,
        this.nameOfUser,
        this.userName,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isSelected = false,
    });

    factory QuantitySettingData.fromJson(Map<String, dynamic> json) => QuantitySettingData(
        userWiseGroupDataAssociationId: json["userWiseGroupDataAssociationId"],
        groupId: json["groupId"],
        groupName: json["groupName"],
        exchangeId: json["exchangeId"],
        exchangeName: json["exchangeName"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        lotSize: json["lotSize"],
        quantityMax: json["quantityMax"],
        lotMax: json["lotMax"],
        breakQuantity: json["breakQuantity"],
        breakUpLot: json["breakUpLot"],
        updatedBy: json["updatedBy"],
        updatedByName: json["updatedByName"],
        updatedByUserName: json["updatedByUserName"],
        userId: json["userId"],
        nameOfUser: json["nameOfUser"],
        userName: json["userName"],
        status: json["status"],
          createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "userWiseGroupDataAssociationId": userWiseGroupDataAssociationId,
        "groupId": groupId,
        "groupName": groupName,
        "exchangeId": exchangeId,
        "exchangeName": exchangeName,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "lotSize": lotSize,
        "quantityMax": quantityMax,
        "lotMax": lotMax,
        "breakQuantity": breakQuantity,
        "breakUpLot": breakUpLot,
        "updatedBy": updatedBy,
        "updatedByName": updatedByName,
        "updatedByUserName": updatedByUserName,
        "userId": userId,
        "nameOfUser": nameOfUser,
        "userName": userName,
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
