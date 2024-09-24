// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

settingUserListModel settingUserListFromJson(String str) => settingUserListModel.fromJson(json.decode(str));

String settingUserListToJson(settingUserListModel data) => json.encode(data.toJson());

class settingUserListModel {
  settingUserListModel(
      {
      this.name,
      this.Balance,
      this.credit,
      this.profitPer,
      this.userType,
      this.tradetime,
      this.tradetype,
      this.tradeRate,
      this.tradePValue,
      this.tradeLValue,
      this.tradeClvalue,
      this.tradeTypes,
      });

  String? name;
  String? Balance;
  String? credit;
  String? profitPer;
  String? userType;
  String? tradetime;
  String? tradetype;
  String? tradeRate;
  String? tradePValue;
  String? tradeLValue;
  String? tradeClvalue;
  String? tradeTypes;

  factory settingUserListModel.fromJson(Map<String, dynamic> json) => settingUserListModel(
        name: json["name"],
        Balance: json["Balance"],
        credit: json["credit"],
        profitPer: json["profitPer"],
        userType: json["userType"],
        tradetime: json["tradetime"],
        tradetype: json["tradetype"],
        tradeRate: json["tradeRate"],
        tradePValue: json["tradePValue"],
        tradeLValue: json["tradeLValue"],
        tradeClvalue: json["tradeClvalue"],
        tradeTypes : json["tradeTypes"]

      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "Balance":Balance,
        "credit":credit,
        "profitPer":profitPer,
        "userType": userType,
        "tradetime" : tradetime,
        "tradetype": tradetype,
        "tradeRate": tradeRate,
        "tradePValue": tradePValue,
        "tradeLValue": tradeLValue,
        "tradeClvalue":tradeClvalue,
        "tradeTypes": tradeTypes,
      };
}


