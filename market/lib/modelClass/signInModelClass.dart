// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

// import 'dart:convert';

// LoginModel loginModelFromJson(String str) =>
//     LoginModel.fromJson(json.decode(str));

// String loginModelToJson(LoginModel data) => json.encode(data.toJson());

// class LoginModel {
//   Meta? meta;
//   SignInData? data;
//   int? statusCode;
//   String? message;

//   LoginModel({
//     this.meta,
//     this.data,
//     this.statusCode,
//     this.message,
//   });

//   factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//         meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
//         data: json["data"] == null ? null : SignInData.fromJson(json["data"]),
//         statusCode: json["statusCode"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "meta": meta?.toJson(),
//         "data": data?.toJson(),
//         "statusCode": statusCode,
//         "message": message,
//       };
// }

// class SignInData {
//   int? status;
//   String? userId;
//   String? name;
//   String? userName;
//   String? phone;
//   String? city;
//   num? credit;
//   String? remark;
//   num? profitAndLossSharing;
//   num? brkSharing;
//   List<String>? exchangeAllow;
//   List<String>? highLowBetweenTradeLimit;
//   bool? firstLogin;
//   bool? changePasswordOnFirstLogin;
//   String? role;
//   String? parentId;

//   SignInData({
//     this.status,
//     this.userId,
//     this.name,
//     this.userName,
//     this.phone,
//     this.city,
//     this.credit,
//     this.remark,
//     this.profitAndLossSharing,
//     this.brkSharing,
//     this.exchangeAllow,
//     this.highLowBetweenTradeLimit,
//     this.firstLogin,
//     this.changePasswordOnFirstLogin,
//     this.role,
//     this.parentId,
//   });

//   factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
//         status: json["status"],
//         userId: json["userId"],
//         name: json["name"],
//         userName: json["userName"],
//         phone: json["phone"],
//         city: json["city"],
//         credit: json["credit"],
//         remark: json["remark"],
//         profitAndLossSharing: json["profitAndLossSharing"],
//         brkSharing: json["brkSharing"],
//         exchangeAllow: json["exchangeAllow"] == null
//             ? []
//             : List<String>.from(json["exchangeAllow"]!.map((x) => x)),
//         highLowBetweenTradeLimit: json["highLowBetweenTradeLimit"] == null
//             ? []
//             : List<String>.from(
//                 json["highLowBetweenTradeLimit"]!.map((x) => x)),
//         firstLogin: json["firstLogin"],
//         changePasswordOnFirstLogin: json["changePasswordOnFirstLogin"],
//         role: json["role"],
//         parentId: json["parentId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "userId": userId,
//         "name": name,
//         "userName": userName,
//         "phone": phone,
//         "city": city,
//         "credit": credit,
//         "remark": remark,
//         "profitAndLossSharing": profitAndLossSharing,
//         "brkSharing": brkSharing,
//         "exchangeAllow": exchangeAllow == null
//             ? []
//             : List<dynamic>.from(exchangeAllow!.map((x) => x)),
//         "highLowBetweenTradeLimit": highLowBetweenTradeLimit == null
//             ? []
//             : List<dynamic>.from(highLowBetweenTradeLimit!.map((x) => x)),
//         "firstLogin": firstLogin,
//         "changePasswordOnFirstLogin": changePasswordOnFirstLogin,
//         "role": role,
//         "parentId": parentId,
//       };
// }

// class Meta {
//   String? message;
//   String? token;

//   Meta({
//     this.message,
//     this.token,
//   });

//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         message: json["message"],
//         token: json["token"],
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "token": token,
//       };
// }

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  Meta? meta;
  SignInData? data;
  int? statusCode;
  String? message;

  LoginModel({
    this.meta,
    this.data,
    this.statusCode,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : SignInData.fromJson(json["data"]),
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

class SignInData {
  int? status;
  String? userId;
  String? name;
  String? userName;
  String? phone;
  num? credit;
  String? remark;
  num? profitAndLossSharing;
  num? profitAndLossSharingDownLine;
  num? brkSharing;
  num? brkSharingDownLine;
  List<dynamic>? exchangeAllow;
  List<dynamic>? highLowBetweenTradeLimit;
  bool? firstLogin;
  bool? changePasswordOnFirstLogin;
  String? role;
  String? roleName;
  String? parentId;
  bool? bet;
  bool? closeOnly;
  bool? marginSquareOff;
  bool? freshStopLoss;
  num? cmpOrder;
  String? cmpOrderValue;
  num? manualOrder;
  String? manualOrderValue;
  num? addMaster;
  String? addMasterValue;
  num? modifyOrder;
  String? modifyOrderValue;
  num? autoSquareOff;
  String? autoSquareOffValue;
  num? noOfLogin;
  String? lastLoginTime;
  String? lastLogoutTime;
  String? leverage;
  num? cutOff;
  num? intraday;
  String? intradayValue;

  SignInData({
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
    this.roleName,
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

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
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
        exchangeAllow: json["exchangeAllow"] == null ? [] : List<dynamic>.from(json["exchangeAllow"]!.map((x) => x)),
        highLowBetweenTradeLimit: json["highLowBetweenTradeLimit"] == null ? [] : List<dynamic>.from(json["highLowBetweenTradeLimit"]!.map((x) => x)),
        firstLogin: json["firstLogin"],
        changePasswordOnFirstLogin: json["changePasswordOnFirstLogin"],
        role: json["role"],
        roleName: json["roleName"],
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
        "exchangeAllow": exchangeAllow == null ? [] : List<dynamic>.from(exchangeAllow!.map((x) => x)),
        "highLowBetweenTradeLimit": highLowBetweenTradeLimit == null ? [] : List<dynamic>.from(highLowBetweenTradeLimit!.map((x) => x)),
        "firstLogin": firstLogin,
        "changePasswordOnFirstLogin": changePasswordOnFirstLogin,
        "role": role,
        "roleName": roleName,
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
  String? token;

  Meta({
    this.message,
    this.token,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
      };
}
