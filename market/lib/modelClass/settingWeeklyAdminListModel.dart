// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

settingWeeklyAdmimListModel settingUserListFromJson(String str) => settingWeeklyAdmimListModel.fromJson(json.decode(str));

String settingUserListToJson(settingWeeklyAdmimListModel data) => json.encode(data.toJson());

class settingWeeklyAdmimListModel {
  settingWeeklyAdmimListModel(
      {
      this.userName,
      this.releasePL,
      this.MMPL,
      this.totalPL,
      this.adminProfit,
      this.adminBrokerage,
      this.totalAdminProfil,
      });

  String? userName;
  String? releasePL;
  String? MMPL;
  String? totalPL;
  String? adminProfit;
  String? adminBrokerage;
  String? totalAdminProfil;

  factory settingWeeklyAdmimListModel.fromJson(Map<String, dynamic> json) => settingWeeklyAdmimListModel(
        userName: json["userName"],
        releasePL: json["releasePL"],
        MMPL: json["MMPL"],
        totalPL: json["totalPL"],
        adminProfit: json["adminProfit"],
        adminBrokerage: json["adminBrokerage"],
        totalAdminProfil: json["totalAdminProfil"],
      );

  Map<String, dynamic> toJson() => {
        "userName":userName,
        "releasePL": releasePL,
        "MMPL":MMPL,
        "totalPL":totalPL,
        "adminProfit":adminProfit,
        "adminBrokerage": adminBrokerage,
        "totalAdminProfil" : totalAdminProfil,
      };
}


