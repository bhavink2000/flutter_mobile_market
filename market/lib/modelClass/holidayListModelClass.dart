// To parse this JSON data, do
//
//     final holidayListModel = holidayListModelFromJson(jsonString);

import 'dart:convert';

HolidayListModel holidayListModelFromJson(String str) => HolidayListModel.fromJson(json.decode(str));

String holidayListModelToJson(HolidayListModel data) => json.encode(data.toJson());

class HolidayListModel {
  Meta? meta;
  List<HolidayData>? data;
  int? statusCode;

  HolidayListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory HolidayListModel.fromJson(Map<String, dynamic> json) => HolidayListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<HolidayData>.from(json["data"]!.map((x) => HolidayData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class HolidayData {
  DateTime? startDate;
  DateTime? endDate;
  String? text;

  HolidayData({
    this.startDate,
    this.endDate,
    this.text,
  });

  factory HolidayData.fromJson(Map<String, dynamic> json) => HolidayData(
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "text": text,
      };
}

class Meta {
  String? message;

  Meta({
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
