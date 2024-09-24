// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

categoryDataModel signInModelFromJson(String str) => categoryDataModel.fromJson(json.decode(str));

String signInModelToJson(categoryDataModel data) => json.encode(data.toJson());

class categoryDataModel {
  categoryDataModel(
      {
      this.name,
      this.values,
      this.isSwitch,
      this.isMore,
      });
  
  String? name;
  String? values;
  bool? isSwitch;
  bool? isMore;

  factory categoryDataModel.fromJson(Map<String, dynamic> json) => categoryDataModel(
        name: json["name"],
        values: json["values"],
        isSwitch: json["isSwitch"],
        isMore: json["isMore"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "values":values,
        "isSwitch":isSwitch,
        "isMore":isMore,
      };
}
