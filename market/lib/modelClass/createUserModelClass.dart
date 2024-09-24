class CreateUserModel {
  Meta? meta;
  Data? data;
  int? statusCode;
  String? message;

  CreateUserModel({
    this.meta,
    this.data,
    this.statusCode,
    this.message,
  });

  factory CreateUserModel.fromJson(Map<String, dynamic> json) =>
      CreateUserModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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

class Data {
  int? status;
  String? userId;
  String? name;
  String? userName;
  String? phone;
  String? city;
  int? credit;
  String? remark;
  int? profitAndLossSharing;
  int? brkSharing;
  List<dynamic>? exchangeAllow;
  List<dynamic>? highLowBetweenTradeLimit;
  bool? firstLogin;
  bool? changePasswordOnFirstLogin;
  String? role;
  String? parentId;

  Data({
    this.status,
    this.userId,
    this.name,
    this.userName,
    this.phone,
    this.city,
    this.credit,
    this.remark,
    this.profitAndLossSharing,
    this.brkSharing,
    this.exchangeAllow,
    this.highLowBetweenTradeLimit,
    this.firstLogin,
    this.changePasswordOnFirstLogin,
    this.role,
    this.parentId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        userId: json["userId"],
        name: json["name"],
        userName: json["userName"],
        phone: json["phone"],
        city: json["city"],
        credit: json["credit"],
        remark: json["remark"],
        profitAndLossSharing: json["profitAndLossSharing"],
        brkSharing: json["brkSharing"],
        exchangeAllow: json["exchangeAllow"] == null
            ? []
            : List<dynamic>.from(json["exchangeAllow"]!.map((x) => x)),
        highLowBetweenTradeLimit: json["highLowBetweenTradeLimit"] == null
            ? []
            : List<dynamic>.from(
                json["highLowBetweenTradeLimit"]!.map((x) => x)),
        firstLogin: json["firstLogin"],
        changePasswordOnFirstLogin: json["changePasswordOnFirstLogin"],
        role: json["role"],
        parentId: json["parentId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "name": name,
        "userName": userName,
        "phone": phone,
        "city": city,
        "credit": credit,
        "remark": remark,
        "profitAndLossSharing": profitAndLossSharing,
        "brkSharing": brkSharing,
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
