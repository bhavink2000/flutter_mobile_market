// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

settingIntradayHistoryListModel settingUserListFromJson(String str) =>
    settingIntradayHistoryListModel.fromJson(json.decode(str));

String settingUserListToJson(settingIntradayHistoryListModel data) =>
    json.encode(data.toJson());

class settingIntradayHistoryListModel {
  settingIntradayHistoryListModel({
    this.timing,
    this.high,
    this.low,
    this.volume,
    this.open,
    this.close,
  });

  String? timing;
  String? high;
  String? low;
  String? volume;
  String? open;
  String? close;

  factory settingIntradayHistoryListModel.fromJson(Map<String, dynamic> json) =>
      settingIntradayHistoryListModel(
        timing: json["timing"],
        high: json["high"],
        low: json["low"],
        volume: json["volume"],
        open: json["open"],
        close: json["close"],
      );

  Map<String, dynamic> toJson() => {
        "timing": timing,
        "high": high,
        "low": low,
        "volume": volume,
        "open": open,
        "close": close,
      };
}
