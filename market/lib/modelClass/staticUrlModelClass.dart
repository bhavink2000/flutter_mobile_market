// To parse this JSON data, do
//
//     final staticUrlModel = staticUrlModelFromJson(jsonString);

import 'dart:convert';

StaticUrlModel staticUrlModelFromJson(String str) => StaticUrlModel.fromJson(json.decode(str));

String staticUrlModelToJson(StaticUrlModel data) => json.encode(data.toJson());

class StaticUrlModel {
  StaticUrlModel({
    this.status,
    this.data,
    this.message,
  });

  bool? status;
  urlData? data;
  String? message;

  factory StaticUrlModel.fromJson(Map<String, dynamic> json) => StaticUrlModel(
        status: json["status"],
        data: json["data"] == null ? null : urlData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class urlData {
  urlData({
    this.privacyPolicyUrl,
    this.termsConditionsUrl,
    this.eula,
    this.paymentURL,
    this.paymentFailURL,
    this.paymentSuccessURL,
    this.faqURL,
    this.shareBaseURL,
  });

  String? privacyPolicyUrl;
  String? termsConditionsUrl;
  String? eula;
  String? paymentURL;
  String? paymentSuccessURL;
  String? paymentFailURL;
  String? faqURL;
  String? shareBaseURL;

  factory urlData.fromJson(Map<String, dynamic> json) => urlData(
        privacyPolicyUrl: json["privacy-policy-url"],
        termsConditionsUrl: json["terms-conditions-url"],
        eula: json["eula"],
        paymentURL: json["payment"],
        paymentSuccessURL: json["payment_success"],
        paymentFailURL: json["payment_cancel"],
        faqURL: json["FAQ"],
        shareBaseURL: json["shareable_link"],
      );

  Map<String, dynamic> toJson() => {
        "privacy-policy-url": privacyPolicyUrl,
        "terms-conditions-url": termsConditionsUrl,
        "eula": eula,
        "payment": paymentURL,
        "payment_success": paymentSuccessURL,
        "payment_cancel": paymentFailURL,
        "FAQ": faqURL,
        "shareable_link": shareBaseURL,
      };
}
