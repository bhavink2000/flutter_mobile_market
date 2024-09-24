// To parse this JSON data, do
//
//     final allScriptModel = allScriptModelFromJson(jsonString);

import 'dart:convert';

AllScriptModel allScriptModelFromJson(String str) => AllScriptModel.fromJson(json.decode(str));

String allScriptModelToJson(AllScriptModel data) => json.encode(data.toJson());

class AllScriptModel {
  bool? status;
  String? message;
  AllScriptData? data;

  AllScriptModel({
    this.status,
    this.message,
    this.data,
  });

  factory AllScriptModel.fromJson(Map<String, dynamic> json) => AllScriptModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : AllScriptData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AllScriptData {
  List<SymbolValues>? symbols;

  AllScriptData({
    this.symbols,
  });

  factory AllScriptData.fromJson(Map<String, dynamic> json) => AllScriptData(
        symbols: json["symbols"] == null ? [] : List<SymbolValues>.from(json["symbols"]!.map((x) => SymbolValues.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "symbols": symbols == null ? [] : List<dynamic>.from(symbols!.map((x) => x.toJson())),
      };
}

class SymbolValues {
  String? symbol;
  String? exchange;
  DateTime? expiry;
  String? name;
  int? ls;
  double? ts;

  SymbolValues({
    this.symbol,
    this.exchange,
    this.expiry,
    this.name,
    this.ls,
    this.ts,
  });

  factory SymbolValues.fromJson(Map<String, dynamic> json) => SymbolValues(
        symbol: json["symbol"],
        exchange: json["exchange"],
        expiry: json["expiry"] == null ? null : DateTime.parse(json["expiry"]),
        name: json["name"],
        ls: json["ls"],
        ts: json["ts"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "exchange": exchange,
        "expiry":
            "${expiry!.year.toString().padLeft(4, '0')}-${expiry!.month.toString().padLeft(2, '0')}-${expiry!.day.toString().padLeft(2, '0')}",
        "name": name,
        "ls": ls,
        "ts": ts,
      };
}

enum Exchange { NSE, MCX, CRYPTO, BCD, COMEX, OTHERS, SGX }

final exchangeValues = EnumValues({
  "BCD": Exchange.BCD,
  "COMEX": Exchange.COMEX,
  "CRYPTO": Exchange.CRYPTO,
  "MCX": Exchange.MCX,
  "NSE": Exchange.NSE,
  "OTHERS": Exchange.OTHERS,
  "SGX": Exchange.SGX
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
