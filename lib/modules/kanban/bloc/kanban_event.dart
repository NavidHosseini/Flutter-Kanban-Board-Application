import 'package:equatable/equatable.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';

abstract class KanbanEvent extends Equatable {
  const KanbanEvent();

  @override
  List<Object?> get props => [];
}

class AddBoardItem extends KanbanEvent {
  final int columnIndex;
  final BoardItemModel item;

  const AddBoardItem(this.columnIndex, this.item);

  @override
  List<Object?> get props => [columnIndex, item];
}

class UpdateBoardItem extends KanbanEvent {
  final int columnIndex;
  final BoardItemModel item;

  const UpdateBoardItem(this.columnIndex, this.item);

  @override
  List<Object?> get props => [columnIndex, item];
}

class DeleteBoardItem extends KanbanEvent {
  final int columnIndex;
  final int itemId;

  const DeleteBoardItem(this.columnIndex, this.itemId);

  @override
  List<Object?> get props => [columnIndex, itemId];
}

class ReorderColumn extends KanbanEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderColumn(this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class ReorderBoardItem extends KanbanEvent {
  final int listIndex;
  final int itemIndex;
  final int oldListIndex;
  final int oldItemIndex;

  const ReorderBoardItem(this.listIndex, this.itemIndex, this.oldListIndex, this.oldItemIndex);

  @override
  List<Object?> get props => [listIndex, itemIndex, oldListIndex, oldItemIndex];
}
