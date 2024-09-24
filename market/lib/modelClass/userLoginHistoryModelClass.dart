class UserLoginHistoryModel {
  Meta? meta;
  List<userLoginHistoryData>? data;
  int? statusCode;

  UserLoginHistoryModel({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory UserLoginHistoryModel.fromJson(Map<String, dynamic> json) => UserLoginHistoryModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<userLoginHistoryData>.from(json["data"]!.map((x) => userLoginHistoryData.fromJson(x))),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
      };
}

class userLoginHistoryData {
  String? loginHistoryId;
  String? userId;
  String? loginBy;
  String? deviceToken;
  String? deviceId;
  String? systemToken;
  String? ip;
  DateTime? loginDate;
  DateTime? logoutDate;
  String? userName;
  String? name;
  String? city;
  String? country;
  String? role;

  userLoginHistoryData({
    this.loginHistoryId,
    this.userId,
    this.loginBy,
    this.deviceToken,
    this.deviceId,
    this.systemToken,
    this.ip,
    this.loginDate,
    this.logoutDate,
    this.userName,
    this.name,
    this.city,
    this.country,
    this.role,
  });

  factory userLoginHistoryData.fromJson(Map<String, dynamic> json) => userLoginHistoryData(
        loginHistoryId: json["loginHistoryId"],
        userId: json["userId"],
        loginBy: json["loginBy"],
        deviceToken: json["deviceToken"],
        deviceId: json["deviceId"],
        systemToken: json["systemToken"],
        ip: json["ip"],
        loginDate: json["loginDate"] == null || json["loginDate"] == "" ? null : DateTime.parse(json["loginDate"]),
        logoutDate: json["logoutDate"] == null || json["logoutDate"] == "" ? null : DateTime.parse(json["logoutDate"]),
        userName: json["userName"],
        name: json["name"],
        city: json["city"],
        country: json["country"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "loginHistoryId": loginHistoryId,
        "userId": userId,
        "loginBy": loginBy,
        "deviceToken": deviceToken,
        "deviceId": deviceId,
        "systemToken": systemToken,
        "ip": ip,
        "loginDate": loginDate?.toIso8601String(),
        "logoutDate": logoutDate,
        "userName": userName,
        "name": name,
        "city": city,
        "country": country,
        "role": role,
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
