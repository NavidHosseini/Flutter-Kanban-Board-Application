import 'package:kanban/modules/kanban/models/board_item_model.dart';

class BoardColumnModel {
  String columnName;
  int columnCount;
  List<BoardItemModel>? items;

  BoardColumnModel({required this.columnName, required this.columnCount, List<BoardItemModel>? items}) : items = items ?? [];

  factory BoardColumnModel.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] != null ? json['items'] as List : [];
    List<BoardItemModel>? itemList;
    if (itemsFromJson.isNotEmpty) {
      itemList = itemsFromJson.map((i) => BoardItemModel.fromJson(i)).toList();
    }
    return BoardColumnModel(
      columnName: json['columnName'],
      columnCount: json['columnCount'],
      items: itemList ?? [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'columnName': columnName,
      'columnCount': columnCount,
      'items': items != null && items!.isNotEmpty ? items!.map((item) => item.toJson()).toList() : [],
    };
  }

  BoardColumnModel copyWith({String? columnName, List<BoardItemModel>? items}) {
    return BoardColumnModel(
      columnCount: columnCount,
      columnName: columnName ?? this.columnName,
      items: items ?? this.items?.map((item) => item.copyWith()).toList(),
    );
  }
}
