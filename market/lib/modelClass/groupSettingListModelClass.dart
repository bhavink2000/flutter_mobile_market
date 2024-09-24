// To parse this JSON data, do
//
//     final groupSettingListModel = groupSettingListModelFromJson(jsonString);

import 'dart:convert';

GroupSettingListModel groupSettingListModelFromJson(String str) => GroupSettingListModel.fromJson(json.decode(str));

String groupSettingListModelToJson(GroupSettingListModel data) => json.encode(data.toJson());

class GroupSettingListModel {
    Meta? meta;
    List<GroupSettingData>? data;
    int? statusCode;

    GroupSettingListModel({
        this.meta,
        this.data,
        this.statusCode,
    });

    factory GroupSettingListModel.fromJson(Map<String, dynamic> json) => GroupSettingListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<GroupSettingData>.from(json["data"]!.map((x) => GroupSettingData.fromJson(x))),
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
    };
}

class GroupSettingData {
    String? assignGroupId;
    String? groupId;
    String? groupName;
    String? exchangeId;
    String? exchangeName;
    String? userId;
    String? naOfUser;
    String? userName;
    int? autoSquareOff;
    int? onlySquareOff;
    int? credit;
    int? margin;
    bool? isTurnoverWise;
    bool? isSymbolWise;
    int? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    GroupSettingData({
        this.assignGroupId,
        this.groupId,
        this.groupName,
        this.exchangeId,
        this.exchangeName,
        this.userId,
        this.naOfUser,
        this.userName,
        this.autoSquareOff,
        this.onlySquareOff,
        this.credit,
        this.margin,
        this.isTurnoverWise,
        this.isSymbolWise,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory GroupSettingData.fromJson(Map<String, dynamic> json) => GroupSettingData(
        assignGroupId: json["assignGroupId"],
        groupId: json["groupId"],
        groupName: json["groupName"],
        exchangeId: json["exchangeId"],
        exchangeName: json["exchangeName"],
        userId: json["userId"],
        naOfUser: json["naOfUser"],
        userName: json["userName"],
        autoSquareOff: json["autoSquareOff"],
        onlySquareOff: json["onlySquareOff"],
        credit: json["credit"],
        margin: json["margin"],
        isTurnoverWise: json["isTurnoverWise"],
        isSymbolWise: json["isSymbolWise"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "assignGroupId": assignGroupId,
        "groupId": groupId,
        "groupName": groupName,
        "exchangeId": exchangeId,
        "exchangeName": exchangeName,
        "userId": userId,
        "naOfUser": naOfUser,
        "userName": userName,
        "autoSquareOff": autoSquareOff,
        "onlySquareOff": onlySquareOff,
        "credit": credit,
        "margin": margin,
        "isTurnoverWise": isTurnoverWise,
        "isSymbolWise": isSymbolWise,
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
