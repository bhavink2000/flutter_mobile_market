// To parse this JSON data, do
//
//     final scriptQuantityModel = scriptQuantityModelFromJson(jsonString);

import 'dart:convert';

ScriptQuantityModel scriptQuantityModelFromJson(String str) => ScriptQuantityModel.fromJson(json.decode(str));

String scriptQuantityModelToJson(ScriptQuantityModel data) => json.encode(data.toJson());

class ScriptQuantityModel {
    Meta? meta;
    List<scriptQuantityData>? data;
    int? statusCode;

    ScriptQuantityModel({
        this.meta,
        this.data,
        this.statusCode,
    });

    factory ScriptQuantityModel.fromJson(Map<String, dynamic> json) => ScriptQuantityModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<scriptQuantityData>.from(json["data"]!.map((x) => scriptQuantityData.fromJson(x))),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
    };
}

class scriptQuantityData {
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

    scriptQuantityData({
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
    });

    factory scriptQuantityData.fromJson(Map<String, dynamic> json) => scriptQuantityData(
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
