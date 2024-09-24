// To parse this JSON data, do
//
//     final commonModel = commonModelFromJson(jsonString);

import 'dart:convert';

CommonModel commonModelFromJson(String str) => CommonModel.fromJson(json.decode(str));

String commonModelToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
    Meta? meta;
    int? statusCode;
 String? message;
    CommonModel({
        this.meta,
        this.statusCode,
         this.message,
    });

    factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        statusCode: json["statusCode"],
         message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "statusCode": statusCode,
         "message": message,
        
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
