import 'package:kanban/modules/kanban/models/column_model.dart';

class KanbanModel {
  List<BoardColumnModel> columns;
  KanbanModel({
    required this.columns,
  });
  factory KanbanModel.fromJson(Map<String, dynamic> json) {
    var columnsFromJson = json['columns'] as List;
    List<BoardColumnModel> columnList = columnsFromJson.map((c) => BoardColumnModel.fromJson(c)).toList();
    return KanbanModel(
      columns: columnList,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'columns': columns.map((column) => column.toJson()).toList(),
    };
  }

  KanbanModel copyWith({List<BoardColumnModel>? columns}) {
    return KanbanModel(
      columns: columns ?? this.columns.map((column) => column.copyWith()).toList(),
    );
  }
}
