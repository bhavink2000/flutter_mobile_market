// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

class ItemModel {
  ItemModel({required this.name, required this.ImageName});
  String name;
  String ImageName;
  
}

class GroupModel {
  GroupModel({required this.name, required this.items});
  String name;
  List<ItemModel> items;
}


class sharingDetailsItemModel {
  sharingDetailsItemModel({required this.names, required this.amountPer, required this.isImage});
  String names;
  String amountPer;
  bool isImage;
}

class sharingDetailsGroupModel {
  sharingDetailsGroupModel({required this.name, required this.items});
  String name;
  List<sharingDetailsItemModel> items;
}