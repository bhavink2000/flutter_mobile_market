// To parse this JSON data, do
//
//     final userWiseBrokerageListModel = userWiseBrokerageListModelFromJson(jsonString);

import 'dart:convert';

UserWiseBrokerageListModel userWiseBrokerageListModelFromJson(String str) => UserWiseBrokerageListModel.fromJson(json.decode(str));

String userWiseBrokerageListModelToJson(UserWiseBrokerageListModel data) => json.encode(data.toJson());

class UserWiseBrokerageListModel {
    Meta? meta;
    List<userWiseBrokerageData>? data;
    int? statusCode;

    UserWiseBrokerageListModel({
        this.meta,
        this.data,
        this.statusCode,
    });

    factory UserWiseBrokerageListModel.fromJson(Map<String, dynamic> json) => UserWiseBrokerageListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<userWiseBrokerageData>.from(json["data"]!.map((x) => userWiseBrokerageData.fromJson(x))),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
    };
}

class userWiseBrokerageData {
    String? userWiseBrokerageId;
    String? userId;
    String? nameOfUser;
    String? userName;
    String? exchangeId;
    String? exchangeName;
    String? symbolId;
    String? symbolName;
    String? brokerageType;
    String? brokerageTypeValue;
    int? brokeragePrice;
    bool isSelected;

    userWiseBrokerageData({
        this.userWiseBrokerageId,
        this.userId,
        this.nameOfUser,
        this.userName,
        this.exchangeId,
        this.exchangeName,
        this.symbolId,
        this.symbolName,
        this.brokerageType,
        this.brokerageTypeValue,
        this.brokeragePrice,
        this.isSelected = false,
    });

    factory userWiseBrokerageData.fromJson(Map<String, dynamic> json) => userWiseBrokerageData(
        userWiseBrokerageId: json["userWiseBrokerageId"],
        userId: json["userId"],
        nameOfUser: json["nameOfUser"],
        userName: json["userName"],
        exchangeId: json["exchangeId"],
        exchangeName: json["exchangeName"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        brokerageType: json["brokerageType"],
        brokerageTypeValue: json["brokerageTypeValue"],
        brokeragePrice: json["brokeragePrice"],
    );

    Map<String, dynamic> toJson() => {
        "userWiseBrokerageId": userWiseBrokerageId,
        "userId": userId,
        "nameOfUser": nameOfUser,
        "userName": userName,
        "exchangeId": exchangeId,
        "exchangeName": exchangeName,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "brokerageType": brokerageType,
        "brokerageTypeValue": brokerageTypeValue,
        "brokeragePrice": brokeragePrice,
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
