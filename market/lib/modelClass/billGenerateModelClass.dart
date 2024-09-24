// To parse this JSON data, do
//
//     final billGenerateModel = billGenerateModelFromJson(jsonString);

import 'dart:convert';

BillGenerateModel billGenerateModelFromJson(String str) => BillGenerateModel.fromJson(json.decode(str));

String billGenerateModelToJson(BillGenerateModel data) => json.encode(data.toJson());

class BillGenerateModel {
  Meta? meta;
  BillGenerateData? data;
  int? statusCode;
  String? message;

  BillGenerateModel({
    this.meta,
    this.data,
    this.statusCode,
    this.message,
  });

  factory BillGenerateModel.fromJson(Map<String, dynamic> json) => BillGenerateModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : BillGenerateData.fromJson(json["data"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
        "statusCode": statusCode,
        "message": message,
      };
}

class BillGenerateData {
  String? pdfUrl;
  String? excelUrl;
  String? html;

  BillGenerateData({
    this.pdfUrl,
    this.excelUrl,
    this.html,
  });

  factory BillGenerateData.fromJson(Map<String, dynamic> json) => BillGenerateData(
        pdfUrl: json["pdfUrl"],
        excelUrl: json["excelUrl"],
        html: json["html"],
      );

  Map<String, dynamic> toJson() => {
        "pdfUrl": pdfUrl,
        "excelUrl": excelUrl,
        "html": html,
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
