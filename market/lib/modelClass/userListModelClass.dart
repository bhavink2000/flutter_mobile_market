class UserListModels {
  Meta? meta;
  List<dynamic>? data;
  int? statusCode;

  UserListModels({
    this.meta,
    this.data,
    this.statusCode,
  });

  factory UserListModels.fromJson(Map<String, dynamic> json) => UserListModels(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "statusCode": statusCode,
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
