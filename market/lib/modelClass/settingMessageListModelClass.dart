import 'dart:convert';

settingMessageListModel settingUserListFromJson(String str) =>
    settingMessageListModel.fromJson(json.decode(str));

String settingUserListToJson(settingMessageListModel data) =>
    json.encode(data.toJson());

class settingMessageListModel {
  settingMessageListModel({
    this.text,
    this.date,
    this.time,
  });

  String? text;
  String? date;
  String? time;

  factory settingMessageListModel.fromJson(Map<String, dynamic> json) =>
      settingMessageListModel(
        text: json["text"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "date": date,
        "time": time,
      };
}
