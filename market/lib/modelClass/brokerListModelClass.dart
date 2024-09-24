import 'dart:convert';

BrokerListModel brokerListModelFromJson(String str) =>
    BrokerListModel.fromJson(json.decode(str));

String brokerListModelToJson(BrokerListModel data) =>
    json.encode(data.toJson());

class BrokerListModel {
  Meta? meta;
  List<BrokerListModelData>? data;
  int? statusCode;

  BrokerListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory BrokerListModel.fromJson(Map<String, dynamic> json) =>
      BrokerListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<BrokerListModelData>.from(json["data"]!.map((x) => BrokerListModelData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class BrokerListModelData {
  int? status;
  String? userId;
  String? name;
  String? userName;
  String? phone;
  int? credit;
  String? remark;
  int? profitAndLossSharing;
  int? profitAndLossSharingDownLine;
  int? brkSharing;
  int? brkSharingDownLine;
  List<String>? exchangeAllow;
  List<String>? highLowBetweenTradeLimit;
  bool? firstLogin;
  bool? changePasswordOnFirstLogin;
  String? role;
  String? parentId;
  bool? bet;
  bool? closeOnly;
  bool? marginSquareOff;
  bool? freshStopLoss;
  int? cmpOrder;
  String? cmpOrderValue;
  int? manualOrder;
  String? manualOrderValue;
  int? addMaster;
  String? addMasterValue;
  int? modifyOrder;
  String? modifyOrderValue;
  int? autoSquareOff;
  String? autoSquareOffValue;
  int? noOfLogin;
  String? lastLoginTime;
  String? lastLogoutTime;
  int? leverage;
  int? cutOff;
  int? intraday;
  String? intradayValue;

  BrokerListModelData({
    this.status,
    this.userId,
    this.name,
    this.userName,
    this.phone,
    this.credit,
    this.remark,
    this.profitAndLossSharing,
    this.profitAndLossSharingDownLine,
    this.brkSharing,
    this.brkSharingDownLine,
    this.exchangeAllow,
    this.highLowBetweenTradeLimit,
    this.firstLogin,
    this.changePasswordOnFirstLogin,
    this.role,
    this.parentId,
    this.bet,
    this.closeOnly,
    this.marginSquareOff,
    this.freshStopLoss,
    this.cmpOrder,
    this.cmpOrderValue,
    this.manualOrder,
    this.manualOrderValue,
    this.addMaster,
    this.addMasterValue,
    this.modifyOrder,
    this.modifyOrderValue,
    this.autoSquareOff,
    this.autoSquareOffValue,
    this.noOfLogin,
    this.lastLoginTime,
    this.lastLogoutTime,
    this.leverage,
    this.cutOff,
    this.intraday,
    this.intradayValue,
  });

  factory BrokerListModelData.fromJson(Map<String, dynamic> json) => BrokerListModelData(
        status: json["status"],
        userId: json["userId"],
        name: json["name"],
        userName: json["userName"],
        phone: json["phone"],
        credit: json["credit"],
        remark: json["remark"],
        profitAndLossSharing: json["profitAndLossSharing"],
        profitAndLossSharingDownLine: json["profitAndLossSharingDownLine"],
        brkSharing: json["brkSharing"],
        brkSharingDownLine: json["brkSharingDownLine"],
        exchangeAllow: json["exchangeAllow"] == null
            ? []
            : List<String>.from(json["exchangeAllow"]!.map((x) => x)),
        highLowBetweenTradeLimit: json["highLowBetweenTradeLimit"] == null
            ? []
            : List<String>.from(
                json["highLowBetweenTradeLimit"]!.map((x) => x)),
        firstLogin: json["firstLogin"],
        changePasswordOnFirstLogin: json["changePasswordOnFirstLogin"],
        role: json["role"],
        parentId: json["parentId"],
        bet: json["bet"],
        closeOnly: json["closeOnly"],
        marginSquareOff: json["marginSquareOff"],
        freshStopLoss: json["freshStopLoss"],
        cmpOrder: json["cmpOrder"],
        cmpOrderValue: json["cmpOrderValue"],
        manualOrder: json["manualOrder"],
        manualOrderValue: json["manualOrderValue"],
        addMaster: json["addMaster"],
        addMasterValue: json["addMasterValue"],
        modifyOrder: json["modifyOrder"],
        modifyOrderValue: json["modifyOrderValue"],
        autoSquareOff: json["autoSquareOff"],
        autoSquareOffValue: json["autoSquareOffValue"],
        noOfLogin: json["noOfLogin"],
        lastLoginTime: json["lastLoginTime"],
        lastLogoutTime: json["lastLogoutTime"],
        leverage: json["leverage"],
        cutOff: json["cutOff"],
        intraday: json["intraday"],
        intradayValue: json["intradayValue"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "name": name,
        "userName": userName,
        "phone": phone,
        "credit": credit,
        "remark": remark,
        "profitAndLossSharing": profitAndLossSharing,
        "profitAndLossSharingDownLine": profitAndLossSharingDownLine,
        "brkSharing": brkSharing,
        "brkSharingDownLine": brkSharingDownLine,
        "exchangeAllow": exchangeAllow == null
            ? []
            : List<dynamic>.from(exchangeAllow!.map((x) => x)),
        "highLowBetweenTradeLimit": highLowBetweenTradeLimit == null
            ? []
            : List<dynamic>.from(highLowBetweenTradeLimit!.map((x) => x)),
        "firstLogin": firstLogin,
        "changePasswordOnFirstLogin": changePasswordOnFirstLogin,
        "role": role,
        "parentId": parentId,
        "bet": bet,
        "closeOnly": closeOnly,
        "marginSquareOff": marginSquareOff,
        "freshStopLoss": freshStopLoss,
        "cmpOrder": cmpOrder,
        "cmpOrderValue": cmpOrderValue,
        "manualOrder": manualOrder,
        "manualOrderValue": manualOrderValue,
        "addMaster": addMaster,
        "addMasterValue": addMasterValue,
        "modifyOrder": modifyOrder,
        "modifyOrderValue": modifyOrderValue,
        "autoSquareOff": autoSquareOff,
        "autoSquareOffValue": autoSquareOffValue,
        "noOfLogin": noOfLogin,
        "lastLoginTime": lastLoginTime,
        "lastLogoutTime": lastLogoutTime,
        "leverage": leverage,
        "cutOff": cutOff,
        "intraday": intraday,
        "intradayValue": intradayValue,
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
