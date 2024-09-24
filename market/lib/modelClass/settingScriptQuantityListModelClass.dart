// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

settingScriptQuantityListModel settingUserListFromJson(String str) =>
    settingScriptQuantityListModel.fromJson(json.decode(str));

String settingUserListToJson(settingScriptQuantityListModel data) =>
    json.encode(data.toJson());

class settingScriptQuantityListModel {
  settingScriptQuantityListModel({
    this.symbol,
    this.brkQty,
    this.maxQty,
    this.brkLot,
    this.maxLot,
  });

  String? symbol;
  String? brkQty;
  String? maxQty;
  String? brkLot;
  String? maxLot;

  factory settingScriptQuantityListModel.fromJson(Map<String, dynamic> json) =>
      settingScriptQuantityListModel(
        symbol: json["symbol"],
        brkQty: json["brkQty"],
        maxQty: json["maxQty"],
        brkLot: json["brkLot"],
        maxLot: json["maxLot"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "brkQty": brkQty,
        "maxQty": maxQty,
        "brkLot": brkLot,
        "maxLot": maxLot,
      };
}
