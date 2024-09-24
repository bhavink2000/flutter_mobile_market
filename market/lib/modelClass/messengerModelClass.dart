// To parse this JSON data, do
//
//     final messenger = messengerFromJson(jsonString);

class Messenger {
  List<messengerData> data;

  Messenger({
    required this.data,
  });

  factory Messenger.fromJson(Map<String, dynamic> json) => Messenger(
        data: List<messengerData>.from(json["data"].map((x) => messengerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class messengerData {
  String text;
  String from;

  messengerData({
    required this.text,
    required this.from,
  });

  factory messengerData.fromJson(Map<String, dynamic> json) => messengerData(
        text: json["text"],
        from: json["from"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "from": from,
      };
}
