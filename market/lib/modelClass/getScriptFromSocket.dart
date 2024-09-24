// To parse this JSON data, do
//
//     final getScriptFromSocket = getScriptFromSocketFromJson(jsonString);

// ignore_for_file: non_nullable_equals_parameter

import 'dart:convert';

GetScriptFromSocket getScriptFromSocketFromJson(String str) => GetScriptFromSocket.fromJson(json.decode(str));

String getScriptFromSocketToJson(GetScriptFromSocket data) => json.encode(data.toJson());

class GetScriptFromSocket {
  bool? status;
  String? message;
  ScriptData? data;

  GetScriptFromSocket({
    this.status,
    this.message,
    this.data,
  });

  factory GetScriptFromSocket.fromJson(Map<String, dynamic> json) => GetScriptFromSocket(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ScriptData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ScriptData {
  num? bid;
  num? ask;
  num? ch;
  num? chp;
  num? ltp;
  num? open;
  num? high;
  num? low;
  num? close;
  num? volume;
  num? oi;
  num? tbq;
  num? tsq;
  num? ts;
  num? ls;
  num? lc;
  num? uc;
  num? strikePrice;
  DateTime? expiry;
  String? exchange;
  String? name;
  String? instrumentType;
  String? symbol;
  Depth? depth;
  DateTime? lut;

  ScriptData({
    this.bid = 0.0,
    this.ask = 0.0,
    this.ch = 0.0,
    this.chp = 0.0,
    this.ltp = 0.0,
    this.open = 0.0,
    this.high = 0.0,
    this.low = 0.0,
    this.close = 0.0,
    this.volume = 0.0,
    this.oi = 0.0,
    this.tbq = 0.0,
    this.tsq = 0.0,
    this.ts = 0.0,
    this.ls = 0.0,
    this.lc = 0.0,
    this.uc = 0.0,
    this.strikePrice = 0.0,
    this.expiry,
    this.exchange = "",
    this.name = "",
    this.instrumentType = "",
    this.symbol = "",
    this.depth,
    this.lut,
  });

  factory ScriptData.fromJson(Map<String, dynamic> json) => ScriptData(
        bid: json["bid"] ?? 0.0,
        ask: json["ask"] ?? 0.0,
        ch: json["ch"] ?? 0.0,
        chp: json["chp"] ?? 0.0,
        ltp: json["ltp"] ?? 0.0,
        open: json["open"] ?? 0.0,
        high: json["high"] ?? 0.0,
        low: json["low"] ?? 0.0,
        close: json["close"] ?? 0.0,
        volume: json["volume"],
        oi: json["oi"],
        tbq: json["tbq"],
        tsq: json["tsq"],
        ts: json["ts"],
        ls: json["ls"],
        lc: json["lc"],
        uc: json["uc"],
        strikePrice: json["strikePrice"],
        expiry: json["expiry"] == null ? null : DateTime.tryParse(json["expiry"]),
        exchange: json["exchange"] ?? "",
        name: json["name"] ?? "",
        instrumentType: json["instrumentType"] ?? "",
        symbol: json["symbol"] ?? "",
        depth: json["depth"] == null ? null : Depth.fromJson(json["depth"]),
      );

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "ask": ask,
        "ch": ch,
        "chp": chp,
        "ltp": ltp,
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "volume": volume,
        "oi": oi,
        "tbq": tbq,
        "tsq": tsq,
        "ts": ts,
        "ls": ls,
        "lc": lc,
        "uc": uc,
        "strikePrice": strikePrice,
        "expiry": expiry?.toIso8601String(),
        "exchange": exchange,
        "name": name,
        "instrumentType": instrumentType,
        "symbol": symbol,
        "depth": depth?.toJson(),
      };
  bool operator ==(dynamic other) {
    if (other is ScriptData) {
      return symbol == other.symbol;
    } else {
      return false;
    }
  }

  copyObject(ScriptData other) {
    bid = other.bid;
    ask = other.ask;
    ch = other.ch;
    chp = other.chp;
    ltp = other.ltp;
    open = other.open;
    high = other.high;
    low = other.low;
    close = other.close;
    volume = other.volume;
    oi = other.oi;
    tbq = other.tbq;
    tsq = other.tsq;
    ts = other.ts;
    ls = other.ls;
    expiry = other.expiry;
    exchange = other.exchange;
    name = other.name;
    symbol = other.symbol;
    depth = other.depth;
    lut = other.lut;
  }
}

class Depth {
  List<Buy>? buy;
  List<Buy>? sell;

  Depth({
    this.buy,
    this.sell,
  });

  factory Depth.fromJson(Map<String, dynamic> json) => Depth(
        buy: json["buy"] == null ? [] : List<Buy>.from(json["buy"]!.map((x) => Buy.fromJson(x))),
        sell: json["sell"] == null ? [] : List<Buy>.from(json["sell"]!.map((x) => Buy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "buy": buy == null ? [] : List<dynamic>.from(buy!.map((x) => x.toJson())),
        "sell": sell == null ? [] : List<dynamic>.from(sell!.map((x) => x.toJson())),
      };
}

class Buy {
  num? orders;
  num? price;
  num? quantity;

  Buy({
    this.orders,
    this.price,
    this.quantity,
  });

  factory Buy.fromJson(Map<String, dynamic> json) => Buy(
        orders: json["orders"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "orders": orders,
        "price": price,
        "quantity": quantity,
      };
}
