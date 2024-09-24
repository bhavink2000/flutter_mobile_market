import 'dart:convert';

import 'exchangeAllowModelClass.dart';

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  Meta? meta;
  List<UserData>? data;
  int? statusCode;

  UserListModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      data: json["data"] == null ? [] : List<UserData>.from(json["data"]!.map((x) => UserData.fromJson(x))),
      statusCode: json["statusCode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class UserData {
  int? status;
  String? userId;
  String? name;
  String? userName;
  String? phone;
  num? credit;
  num? initialCredit;
  num? balance;
  num? tradeMarginBalance;
  num? marginBalance;
  String? remark;
  num? profitAndLossSharing;
  num? profitAndLossSharingDownLine;
  num? brkSharing;
  num? brkSharingDownLine;
  List<ExchangeAllow>? exchangeAllow;
  List<AssignGroupDatum>? assignGroupData;
  List<String>? highLowBetweenTradeLimit;
  bool? firstLogin;
  bool? changePasswordOnFirstLogin;
  String? role;
  String? roleName;
  String? parentId;
  String? parentUser;
  bool? bet;
  bool? closeOnly;
  bool? marginSquareOff;
  bool? freshStopLoss;
  int? cmpOrder;
  String? cmpOrderValue;
  int? manualOrder;
  String? manualOrderValue;
  int? marketOrder;
  String? marketOrderValue;
  int? addMaster;
  String? addMasterValue;
  int? modifyOrder;
  String? modifyOrderValue;
  int? executePendingOrder;
  String? executePendingOrderValue;
  int? deleteTrade;
  String? deleteTradeValue;
  int? autoSquareOff;
  String? autoSquareOffValue;
  int? noOfLogin;
  String? lastLoginTime;
  String? lastLogoutTime;
  String? leverage;
  int? cutOff;
  int? intraday;
  String? intradayValue;
  DateTime? createdAt;
  String? ipAddress;
  String? deviceToken;
  String? deviceId;
  String? deviceType;
  num? profitLoss;
  num? brokerageTotal;
  bool? freshLimitSL;

  UserData({
    this.status,
    this.userId,
    this.name,
    this.userName,
    this.phone,
    this.credit,
    this.initialCredit,
    this.balance,
    this.tradeMarginBalance,
    this.marginBalance,
    this.remark,
    this.profitAndLossSharing,
    this.profitAndLossSharingDownLine,
    this.brkSharing,
    this.brkSharingDownLine,
    this.exchangeAllow,
    this.assignGroupData,
    this.highLowBetweenTradeLimit,
    this.firstLogin,
    this.changePasswordOnFirstLogin,
    this.role,
    this.roleName,
    this.parentId,
    this.parentUser,
    this.bet,
    this.closeOnly,
    this.marginSquareOff,
    this.freshStopLoss,
    this.cmpOrder,
    this.cmpOrderValue,
    this.manualOrder,
    this.manualOrderValue,
    this.marketOrder,
    this.marketOrderValue,
    this.addMaster,
    this.addMasterValue,
    this.modifyOrder,
    this.modifyOrderValue,
    this.executePendingOrder,
    this.executePendingOrderValue,
    this.deleteTrade,
    this.deleteTradeValue,
    this.autoSquareOff,
    this.autoSquareOffValue,
    this.noOfLogin,
    this.lastLoginTime,
    this.lastLogoutTime,
    this.leverage,
    this.cutOff,
    this.intraday,
    this.intradayValue,
    this.createdAt,
    this.ipAddress,
    this.deviceToken,
    this.deviceId,
    this.deviceType,
    this.profitLoss,
    this.brokerageTotal,
    this.freshLimitSL,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    try {
      return UserData(
        status: json["status"],
        userId: json["userId"],
        name: json["name"],
        userName: json["userName"],
        phone: json["phone"],
        credit: json["credit"],
        initialCredit: json["initialCredit"],
        balance: json["balance"],
        tradeMarginBalance: json["tradeMarginBalance"],
        marginBalance: json["marginBalance"],
        remark: json["remark"],
        profitAndLossSharing: json["profitAndLossSharing"],
        profitAndLossSharingDownLine: json["profitAndLossSharingDownLine"],
        brkSharing: json["brkSharing"],
        brkSharingDownLine: json["brkSharingDownLine"],
        exchangeAllow: json["exchangeAllow"] == null ? [] : List<ExchangeAllow>.from(json["exchangeAllow"]!.map((x) => ExchangeAllow.fromJson(x))),
        assignGroupData: json["assignGroupData"] == null ? [] : List<AssignGroupDatum>.from(json["assignGroupData"]!.map((x) => AssignGroupDatum.fromJson(x))),
        highLowBetweenTradeLimit: [], //json["highLowBetweenTradeLimit"] == null ? [] : List<String>.from(json["highLowBetweenTradeLimit"]!.map((x) => x)),
        firstLogin: json["firstLogin"],
        changePasswordOnFirstLogin: json["changePasswordOnFirstLogin"],
        role: json["role"],
        roleName: json["roleName"],
        parentId: json["parentId"],
        parentUser: json["parentUser"],
        bet: json["bet"],
        closeOnly: json["closeOnly"],
        marginSquareOff: json["marginSquareOff"],
        freshStopLoss: json["freshStopLoss"],
        cmpOrder: json["cmpOrder"],
        cmpOrderValue: json["cmpOrderValue"],
        manualOrder: json["manualOrder"],
        manualOrderValue: json["manualOrderValue"],
        marketOrder: json["marketOrder"],
        marketOrderValue: json["marketOrderValue"],
        addMaster: json["addMaster"],
        addMasterValue: json["addMasterValue"],
        modifyOrder: json["modifyOrder"],
        modifyOrderValue: json["modifyOrderValue"],
        executePendingOrder: json["executePendingOrder"],
        executePendingOrderValue: json["executePendingOrderValue"],
        deleteTrade: json["deleteTrade"],
        deleteTradeValue: json["deleteTradeValue"],
        autoSquareOff: json["autoSquareOff"],
        autoSquareOffValue: json["autoSquareOffValue"],
        noOfLogin: json["noOfLogin"],
        lastLoginTime: json["lastLoginTime"],
        lastLogoutTime: json["lastLogoutTime"],
        leverage: json["leverage"],
        cutOff: json["cutOff"],
        intraday: json["intraday"],
        intradayValue: json["intradayValue"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        ipAddress: json["ipAddress"],
        deviceToken: json["deviceToken"],
        deviceId: json["deviceId"],
        deviceType: json["deviceType"],
        profitLoss: json["profitLoss"],
        brokerageTotal: json["brokerageTotal"],
        freshLimitSL: json["freshLimitSL"],
      );
    } catch (e) {
      print(e);
    }
    return UserData(
      status: json["status"],
      userId: json["userId"],
      name: json["name"],
      userName: json["userName"],
      phone: json["phone"],
      credit: json["credit"],
      initialCredit: json["initialCredit"],
      balance: json["balance"],
      tradeMarginBalance: json["tradeMarginBalance"],
      marginBalance: json["marginBalance"],
      remark: json["remark"],
      profitAndLossSharing: json["profitAndLossSharing"],
      profitAndLossSharingDownLine: json["profitAndLossSharingDownLine"],
      brkSharing: json["brkSharing"],
      brkSharingDownLine: json["brkSharingDownLine"],
      exchangeAllow: json["exchangeAllow"] == null ? [] : List<ExchangeAllow>.from(json["exchangeAllow"]!.map((x) => ExchangeAllow.fromJson(x))),
      assignGroupData: json["assignGroupData"] == null ? [] : List<AssignGroupDatum>.from(json["assignGroupData"]!.map((x) => AssignGroupDatum.fromJson(x))),
      highLowBetweenTradeLimit: json["highLowBetweenTradeLimit"] == null ? [] : List<String>.from(json["highLowBetweenTradeLimit"]!.map((x) => x)),
      firstLogin: json["firstLogin"],
      changePasswordOnFirstLogin: json["changePasswordOnFirstLogin"],
      role: json["role"],
      roleName: json["roleName"],
      parentId: json["parentId"],
      parentUser: json["parentUser"],
      bet: json["bet"],
      closeOnly: json["closeOnly"],
      marginSquareOff: json["marginSquareOff"],
      freshStopLoss: json["freshStopLoss"],
      cmpOrder: json["cmpOrder"],
      cmpOrderValue: json["cmpOrderValue"],
      manualOrder: json["manualOrder"],
      manualOrderValue: json["manualOrderValue"],
      marketOrder: json["marketOrder"],
      marketOrderValue: json["marketOrderValue"],
      addMaster: json["addMaster"],
      addMasterValue: json["addMasterValue"],
      modifyOrder: json["modifyOrder"],
      modifyOrderValue: json["modifyOrderValue"],
      executePendingOrder: json["executePendingOrder"],
      executePendingOrderValue: json["executePendingOrderValue"],
      deleteTrade: json["deleteTrade"],
      deleteTradeValue: json["deleteTradeValue"],
      autoSquareOff: json["autoSquareOff"],
      autoSquareOffValue: json["autoSquareOffValue"],
      noOfLogin: json["noOfLogin"],
      lastLoginTime: json["lastLoginTime"],
      lastLogoutTime: json["lastLogoutTime"],
      leverage: json["leverage"],
      cutOff: json["cutOff"],
      intraday: json["intraday"],
      intradayValue: json["intradayValue"],
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      ipAddress: json["ipAddress"],
      deviceToken: json["deviceToken"],
      deviceId: json["deviceId"],
      deviceType: json["deviceType"],
      profitLoss: json["profitLoss"],
      brokerageTotal: json["brokerageTotal"],
      freshLimitSL: json["freshLimitSL"],
    );
  }

  factory UserData.fromProfileData(Map<String, dynamic> json) => UserData(
        status: json["status"],
        userId: json["userId"],
        name: json["name"],
        userName: json["userName"],
        phone: json["phone"],
        credit: json["credit"],
        initialCredit: json["initialCredit"],
        balance: json["balance"],
        tradeMarginBalance: json["tradeMarginBalance"],
        marginBalance: json["marginBalance"],
        remark: json["remark"],
        profitAndLossSharing: json["profitAndLossSharing"],
        profitAndLossSharingDownLine: json["profitAndLossSharingDownLine"],
        brkSharing: json["brkSharing"],
        brkSharingDownLine: json["brkSharingDownLine"],
        exchangeAllow: json["exchangeAllow"] == null ? [] : List<ExchangeAllow>.from(json["exchangeAllow"]!.map((x) => ExchangeAllow(exchangeId: x))),
        assignGroupData: json["assignGroupData"] == null ? [] : List<AssignGroupDatum>.from(json["assignGroupData"]!.map((x) => AssignGroupDatum.fromJson(x))),
        highLowBetweenTradeLimit: json["highLowBetweenTradeLimit"] == null ? [] : List<String>.from(json["highLowBetweenTradeLimit"]!.map((x) => x)),
        firstLogin: json["firstLogin"],
        changePasswordOnFirstLogin: json["changePasswordOnFirstLogin"],
        role: json["role"],
        roleName: json["roleName"],
        parentId: json["parentId"],
        parentUser: json["parentUser"],
        bet: json["bet"],
        closeOnly: json["closeOnly"],
        marginSquareOff: json["marginSquareOff"],
        freshStopLoss: json["freshStopLoss"],
        cmpOrder: json["cmpOrder"],
        cmpOrderValue: json["cmpOrderValue"],
        manualOrder: json["manualOrder"],
        manualOrderValue: json["manualOrderValue"],
        marketOrder: json["marketOrder"],
        marketOrderValue: json["marketOrderValue"],
        addMaster: json["addMaster"],
        addMasterValue: json["addMasterValue"],
        modifyOrder: json["modifyOrder"],
        modifyOrderValue: json["modifyOrderValue"],
        executePendingOrder: json["executePendingOrder"],
        executePendingOrderValue: json["executePendingOrderValue"],
        deleteTrade: json["deleteTrade"],
        deleteTradeValue: json["deleteTradeValue"],
        autoSquareOff: json["autoSquareOff"],
        autoSquareOffValue: json["autoSquareOffValue"],
        noOfLogin: json["noOfLogin"],
        lastLoginTime: json["lastLoginTime"],
        lastLogoutTime: json["lastLogoutTime"],
        leverage: json["leverage"],
        cutOff: json["cutOff"],
        intraday: json["intraday"],
        intradayValue: json["intradayValue"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        ipAddress: json["ipAddress"],
        deviceToken: json["deviceToken"],
        deviceId: json["deviceId"],
        deviceType: json["deviceType"],
        profitLoss: json["profitLoss"],
        brokerageTotal: json["brokerageTotal"],
        freshLimitSL: json["freshLimitSL"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "name": name,
        "userName": userName,
        "phone": phone,
        "credit": credit,
        "initialCredit": initialCredit,
        "balance": balance,
        "tradeMarginBalance": tradeMarginBalance,
        "marginBalance": marginBalance,
        "remark": remark,
        "profitAndLossSharing": profitAndLossSharing,
        "profitAndLossSharingDownLine": profitAndLossSharingDownLine,
        "brkSharing": brkSharing,
        "brkSharingDownLine": brkSharingDownLine,
        "exchangeAllow": exchangeAllow == null ? [] : List<dynamic>.from(exchangeAllow!.map((x) => x.toJson())),
        "assignGroupData": assignGroupData == null ? [] : List<dynamic>.from(assignGroupData!.map((x) => x.toJson())),
        "highLowBetweenTradeLimit": highLowBetweenTradeLimit == null ? [] : List<dynamic>.from(highLowBetweenTradeLimit!.map((x) => x)),
        "firstLogin": firstLogin,
        "changePasswordOnFirstLogin": changePasswordOnFirstLogin,
        "role": role,
        "roleName": roleName,
        "parentId": parentId,
        "parentUser": parentUser,
        "bet": bet,
        "closeOnly": closeOnly,
        "marginSquareOff": marginSquareOff,
        "freshStopLoss": freshStopLoss,
        "cmpOrder": cmpOrder,
        "cmpOrderValue": cmpOrderValue,
        "manualOrder": manualOrder,
        "manualOrderValue": manualOrderValue,
        "marketOrder": marketOrder,
        "marketOrderValue": marketOrderValue,
        "addMaster": addMaster,
        "addMasterValue": addMasterValue,
        "modifyOrder": modifyOrder,
        "modifyOrderValue": modifyOrderValue,
        "executePendingOrder": executePendingOrder,
        "executePendingOrderValue": executePendingOrderValue,
        "deleteTrade": deleteTrade,
        "deleteTradeValue": deleteTradeValue,
        "autoSquareOff": autoSquareOff,
        "autoSquareOffValue": autoSquareOffValue,
        "noOfLogin": noOfLogin,
        "lastLoginTime": lastLoginTime,
        "lastLogoutTime": lastLogoutTime,
        "leverage": leverage,
        "cutOff": cutOff,
        "intraday": intraday,
        "intradayValue": intradayValue,
        "createdAt": createdAt?.toIso8601String(),
        "ipAddress": ipAddress,
        "deviceToken": deviceToken,
        "deviceId": deviceId,
        "deviceType": deviceType,
        "profitLoss": profitLoss,
        "brokerageTotal": brokerageTotal,
        "freshLimitSL": freshLimitSL,
      };
}

class AssignGroupDatum {
  String? id;
  String? groupId;
  String? userId;
  String? exchangeId;
  int? autoSquareOff;
  int? onlySquareOff;
  bool? isTurnoverWise;
  bool? isSymbolWise;
  int? status;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  AssignGroupDatum({
    this.id,
    this.groupId,
    this.userId,
    this.exchangeId,
    this.autoSquareOff,
    this.onlySquareOff,
    this.isTurnoverWise,
    this.isSymbolWise,
    this.status,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory AssignGroupDatum.fromJson(Map<String, dynamic> json) => AssignGroupDatum(
        id: json["_id"],
        groupId: json["groupId"],
        userId: json["userId"],
        exchangeId: json["exchangeId"],
        autoSquareOff: json["autoSquareOff"],
        onlySquareOff: json["onlySquareOff"],
        isTurnoverWise: json["isTurnoverWise"],
        isSymbolWise: json["isSymbolWise"],
        status: json["status"],
        v: json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "groupId": groupId,
        "userId": userId,
        "exchangeId": exchangeId,
        "autoSquareOff": autoSquareOff,
        "onlySquareOff": onlySquareOff,
        "isTurnoverWise": isTurnoverWise,
        "isSymbolWise": isSymbolWise,
        "status": status,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Meta {
  String? message;
  int? totalCount;
  int? currentPage;
  int? limit;
  int? totalPage;

  Meta({
    this.message,
    this.totalCount,
    this.currentPage,
    this.limit,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        totalCount: json["totalCount"],
        currentPage: json["currentPage"],
        limit: json["limit"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "totalCount": totalCount,
        "currentPage": currentPage,
        "limit": limit,
        "totalPage": totalPage,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
