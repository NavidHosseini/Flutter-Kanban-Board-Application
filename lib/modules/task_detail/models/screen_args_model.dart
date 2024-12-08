import 'package:kanban/modules/kanban/models/board_item_model.dart';

class ScreenArgsModel {
  BoardItemModel task;
  final String columnName;
  final int columnIndex;

  ScreenArgsModel({
    required this.columnIndex,
    required this.task,
    required this.columnName,
  });
}
