import 'dart:convert';

settingPLListModel settingUserListFromJson(String str) =>
    settingPLListModel.fromJson(json.decode(str));

String settingUserListToJson(settingPLListModel data) =>
    json.encode(data.toJson());

class settingPLListModel {
  settingPLListModel({
    this.userName,
    this.releasedPL,
    this.MMPL,
    this.total,
  });

  String? userName;
  String? releasedPL;
  String? MMPL;
  String? total;

  factory settingPLListModel.fromJson(Map<String, dynamic> json) =>
      settingPLListModel(
        userName: json["userName"],
        releasedPL: json["releasedPL"],
        MMPL: json["MMPL"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "releasedPL": releasedPL,
        "MMPL": MMPL,
        "total": total,
      };
}
