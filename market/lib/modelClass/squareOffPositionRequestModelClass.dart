// To parse this JSON data, do
//
//     final squareOffPositionRequestModel = squareOffPositionRequestModelFromJson(jsonString);

import 'dart:convert';

SquareOffPositionRequestModel squareOffPositionRequestModelFromJson(String str) =>
    SquareOffPositionRequestModel.fromJson(json.decode(str));

String squareOffPositionRequestModelToJson(SquareOffPositionRequestModel data) => json.encode(data.toJson());

class SquareOffPositionRequestModel {
  String? userId;
  List<SymbolRequestData>? symbolData;

  SquareOffPositionRequestModel({
    this.userId,
    this.symbolData,
  });

  factory SquareOffPositionRequestModel.fromJson(Map<String, dynamic> json) => SquareOffPositionRequestModel(
        userId: json["userId"],
        symbolData: json["symbolData"] == null
            ? []
            : List<SymbolRequestData>.from(json["symbolData"]!.map((x) => SymbolRequestData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "symbolData": symbolData == null ? [] : List<dynamic>.from(symbolData!.map((x) => x.toJson())),
      };
}

class SymbolRequestData {
  String? exchangeId;
  String? symbolId;
  String? price;

  SymbolRequestData({
    this.exchangeId,
    this.symbolId,
    this.price,
  });

  factory SymbolRequestData.fromJson(Map<String, dynamic> json) => SymbolRequestData(
        exchangeId: json["exchangeId"],
        symbolId: json["symbolId"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "exchangeId": exchangeId,
        "symbolId": symbolId,
        "price": price,
      };
}
