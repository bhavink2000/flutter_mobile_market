class ExchangeAllowModel {
  List<ExchangeAllow>? exchangeAllow;

  ExchangeAllowModel({
    this.exchangeAllow,
  });

  factory ExchangeAllowModel.fromJson(Map<String, dynamic> json) => ExchangeAllowModel(
        exchangeAllow: json["exchangeAllow"] == null ? [] : List<ExchangeAllow>.from(json["exchangeAllow"]!.map((x) => ExchangeAllow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exchangeAllow": exchangeAllow == null ? [] : List<dynamic>.from(exchangeAllow!.map((x) => x.toJson())),
      };
}

class ExchangeAllow {
  String? exchangeId;
  bool? isTurnoverWise;
  bool? isSymbolWise;
  List<dynamic>? groupId;

  ExchangeAllow({
    this.exchangeId,
    this.isTurnoverWise,
    this.isSymbolWise,
    this.groupId,
  });

  factory ExchangeAllow.fromJson(Map<String, dynamic> json) => ExchangeAllow(
        exchangeId: json["exchangeId"],
        isTurnoverWise: json["isTurnoverWise"],
        isSymbolWise: json["isSymbolWise"],
        groupId: json["groupId"] == null ? [] : List<dynamic>.from(json["groupId"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "exchangeId": exchangeId,
        "isTurnoverWise": isTurnoverWise,
        "isSymbolWise": isSymbolWise,
        "groupId": groupId == null ? [] : List<dynamic>.from(groupId!.map((x) => x)),
      };
}

class ExchangeAllowforMaster {
  String? exchangeId;
  List<String>? groupId;

  ExchangeAllowforMaster({
    this.exchangeId,
    this.groupId,
  });

  factory ExchangeAllowforMaster.fromJson(Map<String, dynamic> json) => ExchangeAllowforMaster(
        exchangeId: json["exchangeId"],
        groupId: json["groupId"] == null ? [] : List<String>.from(json["groupId"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    if (groupId!.isEmpty) {
      return {"exchangeId": exchangeId, "groupId": null};
    } else {
      return {
        "exchangeId": exchangeId,
        "groupId": groupId == null ? [] : List<dynamic>.from(groupId!.toSet().toList().map((x) => x)),
      };
    }
  }
}
