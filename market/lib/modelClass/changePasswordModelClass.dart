class ChangePasswordModel {
  Meta? meta;
  dynamic data;
  String? message;
  int? statusCode;

  ChangePasswordModel({
    this.meta,
    this.data,
    this.statusCode,
    this.message,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"],
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data,
        "statusCode": statusCode,
        "message": message,
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
