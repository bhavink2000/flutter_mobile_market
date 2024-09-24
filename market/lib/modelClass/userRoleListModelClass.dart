class UserRoleListModel {
  Meta? meta;
  List<userRoleListData>? data;
  int? statusCode;
  String? message;

  UserRoleListModel({this.meta, this.data, this.statusCode, this.message});

  factory UserRoleListModel.fromJson(Map<String, dynamic> json) => UserRoleListModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<userRoleListData>.from(json["data"]!.map((x) => userRoleListData.fromJson(x))),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "statusCode": statusCode,
        "message": message,
      };
}

class userRoleListData {
  int? status;
  String? roleId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  userRoleListData({
    this.status,
    this.roleId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory userRoleListData.fromJson(Map<String, dynamic> json) => userRoleListData(
        status: json["status"],
        roleId: json["roleId"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "roleId": roleId,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
