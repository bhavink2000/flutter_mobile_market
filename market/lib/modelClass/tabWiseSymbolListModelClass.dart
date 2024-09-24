// To parse this JSON data, do
//
//     final tabWiseSymbolListModel = tabWiseSymbolListModelFromJson(jsonString);

import 'dart:convert';

TabWiseSymbolListModel tabWiseSymbolListModelFromJson(String str) => TabWiseSymbolListModel.fromJson(json.decode(str));

String tabWiseSymbolListModelToJson(TabWiseSymbolListModel data) => json.encode(data.toJson());

class TabWiseSymbolListModel {
  Meta? meta;
  List<SymbolData>? data;
  int? statusCode;

  TabWiseSymbolListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory TabWiseSymbolListModel.fromJson(Map<String, dynamic> json) => TabWiseSymbolListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<SymbolData>.from(json["data"]!.map((x) => SymbolData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class SymbolData {
  String? id;
  String? userTabSymbolId;
  String? userTabId;
  String? userId;
  String? symbolId;
  String? symbolName;
  String? symbolTitle;
  String? exchangeId;
  int? status;
  int? lotSize;
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
  num? strikePrice;
  int? oddLotTrade;
  DateTime? expiry;
  String? exchange;
  String? name;
  String? instrumentType;
  String? symbol;
  Depth? depth;
  num? tradeMargin;
  String? tradeAttribute;
  num? allowTrade;
  String? allowTradeValue;
  num? quantityMax;
  num? lotMax;
  num? breakQuantity;
  num? breakUpLot;
  num? tradeSecond;

  SymbolData({
    this.id,
    this.userTabSymbolId,
    this.userTabId,
    this.userId,
    this.symbolId,
    this.symbolName,
    this.symbolTitle,
    this.exchangeId,
    this.status,
    this.lotSize,
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
    this.strikePrice = 0.0,
    this.expiry,
    this.exchange = "",
    this.name = "",
    this.instrumentType = "",
    this.symbol = "",
    this.depth,
    this.oddLotTrade,
    this.tradeMargin,
    this.tradeAttribute,
    this.allowTrade,
    this.allowTradeValue,
    this.quantityMax,
    this.lotMax,
    this.breakQuantity,
    this.breakUpLot,
    this.tradeSecond,
  });

  factory SymbolData.fromJson(Map<String, dynamic> json) => SymbolData(
        id: json["_id"],
        userTabSymbolId: json["userTabSymbolId"],
        userTabId: json["userTabId"],
        userId: json["userId"],
        symbolId: json["symbolId"],
        symbolName: json["symbolName"],
        symbolTitle: json["symbolTitle"],
        exchangeId: json["exchangeId"],
        status: json["status"],
        lotSize: json["lotSize"],
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
        strikePrice: json["strikePrice"],
        oddLotTrade: json["oddLotTrade"],
        expiry: json["expiry"] != null && json["expiry"] != ""
            ? DateTime.tryParse(json["expiry"])
            : json["expiryDate"] != null && json["expiryDate"] != ""
                ? DateTime.tryParse(json["expiryDate"])
                : null,
        // expiry: json["expiry"] ?? json["expiryDate"] ?? "",
        exchange: json["exchange"] ?? json["exchangeName"] ?? "",
        name: json["name"] ?? json["symbolTitle"] ?? "",
        symbol: json["symbol"] ?? json["symbolName"] ?? "",
        depth: json["depth"] == null ? null : Depth.fromJson(json["depth"]),
        tradeMargin: json["tradeMargin"],
        instrumentType: json["instrumentType"],
        tradeAttribute: json["tradeAttribute"],
        allowTrade: json["allowTrade"],
        allowTradeValue: json["allowTradeValue"],
        quantityMax: json["quantityMax"],
        lotMax: json["lotMax"],
        breakQuantity: json["breakQuantity"],
        breakUpLot: json["breakUpLot"],
        tradeSecond: json["tradeSecond"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userTabSymbolId": userTabSymbolId,
        "userTabId": userTabId,
        "userId": userId,
        "symbolId": symbolId,
        "symbolName": symbolName,
        "symbolTitle": symbolTitle,
        "exchangeId": exchangeId,
        "status": status,
        "lotSize": lotSize,
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
        "strikePrice": strikePrice,
        "expiry": expiry != null ? expiry!.toIso8601String() : "",
        "exchange": exchange,
        "name": name,
        "instrumentType": instrumentType,
        "symbol": symbol,
        "depth": depth?.toJson(),
        "oddLotTrade": oddLotTrade,
        "tradeMargin": tradeMargin,
        "tradeAttribute": tradeAttribute,
        "allowTrade": allowTrade,
        "allowTradeValue": allowTradeValue,
        "quantityMax": quantityMax,
        "lotMax": lotMax,
        "breakQuantity": breakQuantity,
        "breakUpLot": breakUpLot,
        "tradeSecond": tradeSecond,
      };
  // ignore: non_nullable_equals_parameter
  bool operator ==(dynamic other) {
    if (other is SymbolData) {
      return this.symbol == other.symbol;
    } else {
      return false;
    }
  }
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
