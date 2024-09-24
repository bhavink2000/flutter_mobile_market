// To parse this JSON data, do
//
//     final exchangeListModel = exchangeListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:market/modelClass/groupListModelClass.dart';

ExchangeListModel exchangeListModelFromJson(String str) => ExchangeListModel.fromJson(json.decode(str));

String exchangeListModelToJson(ExchangeListModel data) => json.encode(data.toJson());

class ExchangeListModel {
  Meta? meta;
  List<ExchangeData>? exchangeData;
  int? statusCode;

  ExchangeListModel({
    this.meta,
    this.exchangeData,
    this.statusCode,
  });

  factory ExchangeListModel.fromJson(Map<String, dynamic> json) => ExchangeListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        exchangeData: json["data"] == null ? [] : List<ExchangeData>.from(json["data"]!.map((x) => ExchangeData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": exchangeData == null ? [] : List<dynamic>.from(exchangeData!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class ExchangeData {
  String? exchangeId;
  String? name;
  String? tradeAttribute;
  int? highLowBetweenTradeLimit;
  String? highLowBetweenTradeLimitValue;
  int? oddLotTrade;
  String? oddLotTradeValue;
  String? brokarageType;
  int? autoTickSize;
  String? autoTickSizeValue;
  int? size;
  List<String>? orderType;
  int? autoLotSize;
  String? autoLotSizeValue;
  int? status;
  bool isSelected = false;
  bool? isHighLowTradeSelected;
  bool? isTurnOverSelected;
  bool? isSymbolSelected;
  RxString isDropDownValueSelected = "".obs;
  RxString isDropDownValueSelectedID = "".obs;
  List<String> selectedItems = [];
  List<String> selectedItemsID = [];
  List<groupListModelData> arrGroupList = [];
  int? symbolCount;

  ExchangeData({
    this.exchangeId,
    this.name,
    this.tradeAttribute,
    this.highLowBetweenTradeLimit,
    this.highLowBetweenTradeLimitValue,
    this.oddLotTrade,
    this.oddLotTradeValue,
    this.brokarageType,
    this.autoTickSize,
    this.autoTickSizeValue,
    this.size,
    this.orderType,
    this.autoLotSize,
    this.autoLotSizeValue,
    this.status,
    this.isSelected = false,
    this.isTurnOverSelected,
    this.isSymbolSelected,
    this.isHighLowTradeSelected,
    this.symbolCount,
  });

  factory ExchangeData.fromJson(Map<String, dynamic> json) => ExchangeData(
        exchangeId: json["exchangeId"],
        name: json["name"],
        tradeAttribute: json["tradeAttribute"],
        highLowBetweenTradeLimit: json["highLowBetweenTradeLimit"],
        highLowBetweenTradeLimitValue: json["highLowBetweenTradeLimitValue"],
        oddLotTrade: json["oddLotTrade"],
        oddLotTradeValue: json["oddLotTradeValue"],
        brokarageType: json["brokerageType"],
        autoTickSize: json["autoTickSize"],
        autoTickSizeValue: json["autoTickSizeValue"],
        size: json["size"],
        orderType: json["orderType"] == null ? [] : List<String>.from(json["orderType"]!.map((x) => x)),
        autoLotSize: json["autoLotSize"],
        autoLotSizeValue: json["autoLotSizeValue"],
        status: json["status"],
        symbolCount: json["symbolCount"],
        isSelected: false,
        isTurnOverSelected: false,
        isSymbolSelected: false,
        isHighLowTradeSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "exchangeId": exchangeId,
        "name": name,
        "tradeAttribute": tradeAttribute,
        "highLowBetweenTradeLimit": highLowBetweenTradeLimit,
        "highLowBetweenTradeLimitValue": highLowBetweenTradeLimitValue,
        "oddLotTrade": oddLotTrade,
        "oddLotTradeValue": oddLotTradeValue,
        "brokarageType": brokarageType,
        "autoTickSize": autoTickSize,
        "autoTickSizeValue": autoTickSizeValue,
        "size": size,
        "orderType": orderType == null ? [] : List<dynamic>.from(orderType!.map((x) => x)),
        "autoLotSize": autoLotSize,
        "autoLotSizeValue": autoLotSizeValue,
        "status": status,
        "symbolCount": symbolCount
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
