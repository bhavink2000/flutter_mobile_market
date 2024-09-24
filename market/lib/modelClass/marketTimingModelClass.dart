// To parse this JSON data, do
//
//     final marketTimingModel = marketTimingModelFromJson(jsonString);

import 'dart:convert';

MarketTimingModel marketTimingModelFromJson(String str) => MarketTimingModel.fromJson(json.decode(str));

String marketTimingModelToJson(MarketTimingModel data) => json.encode(data.toJson());

class MarketTimingModel {
  Meta? meta;
  // TimingData? data;
  List<TimingData>? data;
  int? statusCode;

  MarketTimingModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory MarketTimingModel.fromJson(Map<String, dynamic> json) => MarketTimingModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<TimingData>.from(json["data"]!.map((x) => TimingData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class TimingData {
  String? exchangeName;
  String? exchangeId;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String? eventLength;
  String? text;
  List<int>? weekOff;

  TimingData({
    this.exchangeName,
    this.exchangeId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.eventLength,
    this.text,
    this.weekOff,
  });

  factory TimingData.fromJson(Map<String, dynamic> json) => TimingData(
        exchangeName: json["exchangeName"],
        exchangeId: json["exchangeId"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        eventLength: json["eventLength"],
        text: json["text"],
        weekOff: json["weekOff"] == null ? [] : List<int>.from(json["weekOff"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "exchangeName": exchangeName,
        "exchangeId": exchangeId,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "startTime": startTime,
        "endTime": endTime,
        "eventLength": eventLength,
        "text": text,
        "weekOff": weekOff == null ? [] : List<dynamic>.from(weekOff!.map((x) => x)),
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
