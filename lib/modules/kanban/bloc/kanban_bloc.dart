import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';
import 'package:kanban/modules/kanban/models/column_model.dart';
import 'package:kanban/modules/kanban/models/kanban_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'kanban_event.dart';
import 'kanban_state.dart';

class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
  KanbanBloc() : super(KanbanInitial()) {
    on<AddBoardItem>(_onAddBoardItem);
    on<UpdateBoardItem>(_onUpdateBoardItem);
    on<DeleteBoardItem>(_onDeleteBoardItem);
    on<ReorderColumn>(_onReorderColumn);
    on<ReorderBoardItem>(_onReorderBoardItem);

    _loadKanban();
  }

  Future<void> _loadKanban() async {
    final prefs = await SharedPreferences.getInstance();
    final kanbanString = prefs.getString('kanban');
    if (kanbanString != null) {
      final kanbanJson = jsonDecode(kanbanString) as Map<String, dynamic>;
      final kanban = KanbanModel.fromJson(kanbanJson);
      emit(KanbanLoadSuccess(kanban));
    } else {
      emit(KanbanLoadSuccess(KanbanModel(columns: [
        BoardColumnModel(columnName: "TODO", columnCount: 1, items: [
          BoardItemModel(
            boardItemModelTimeTrack: BoardItemModelTimeTrack(),
            id: 1,
            title: "Lorem ipsum dolor sit amet",
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          )
        ]),
        BoardColumnModel(columnName: "IN PROGRESS", columnCount: 0, items: []),
        BoardColumnModel(columnName: "DONE", columnCount: 0, items: []),
      ])));
    }
  }

  Future<void> _saveKanban(KanbanModel kanban) async {
    final prefs = await SharedPreferences.getInstance();
    final kanbanJson = jsonEncode(kanban.toJson());
    prefs.setString('kanban', kanbanJson);
  }

  void _onAddBoardItem(AddBoardItem event, Emitter<KanbanState> emit) async {
    if (state is KanbanLoadSuccess) {
      final kanban = (state as KanbanLoadSuccess).kanban;
      final updatedColumns = List<BoardColumnModel>.from(kanban.columns);
      final column = updatedColumns[event.columnIndex];
      final updatedItems = List<BoardItemModel>.from(column.items!)..add(event.item);
      final updatedColumn = BoardColumnModel(columnName: column.columnName, columnCount: updatedItems.length, items: updatedItems);
      updatedColumns[event.columnIndex] = updatedColumn;
      final updatedKanban = KanbanModel(columns: updatedColumns);
      emit(KanbanLoadSuccess(updatedKanban));
      await _saveKanban(updatedKanban);
    }
  }

  void _onUpdateBoardItem(UpdateBoardItem event, Emitter<KanbanState> emit) async {
    if (state is KanbanLoadSuccess) {
      final kanban = (state as KanbanLoadSuccess).kanban;
      final updatedColumns = List<BoardColumnModel>.from(kanban.columns);
      final column = updatedColumns[event.columnIndex];
      final updatedItems = column.items!.map((item) {
        return item.id == event.item.id ? event.item : item;
      }).toList();
      final updatedColumn = BoardColumnModel(columnName: column.columnName, columnCount: updatedItems.length, items: updatedItems);
      updatedColumns[event.columnIndex] = updatedColumn;
      final updatedKanban = KanbanModel(columns: updatedColumns);
      emit(KanbanLoadSuccess(updatedKanban));
      await _saveKanban(updatedKanban);
    }
  }

  void _onDeleteBoardItem(DeleteBoardItem event, Emitter<KanbanState> emit) async {
    if (state is KanbanLoadSuccess) {
      final kanban = (state as KanbanLoadSuccess).kanban;
      final updatedColumns = List<BoardColumnModel>.from(kanban.columns);
      final column = updatedColumns[event.columnIndex];
      final updatedItems = column.items!.where((item) => item.id != event.itemId).toList();
      final updatedColumn = BoardColumnModel(columnName: column.columnName, columnCount: updatedItems.length, items: updatedItems);
      updatedColumns[event.columnIndex] = updatedColumn;
      final updatedKanban = KanbanModel(columns: updatedColumns);
      emit(KanbanLoadSuccess(updatedKanban));
      await _saveKanban(updatedKanban);
    }
  }

  void _onReorderColumn(ReorderColumn event, Emitter<KanbanState> emit) async {
    if (state is KanbanLoadSuccess) {
      final kanban = (state as KanbanLoadSuccess).kanban;
      final updatedColumns = List<BoardColumnModel>.from(kanban.columns);
      final column = updatedColumns.removeAt(event.oldIndex);
      updatedColumns.insert(event.newIndex, column);
      final updatedKanban = KanbanModel(columns: updatedColumns);
      emit(KanbanLoadSuccess(updatedKanban));
      await _saveKanban(updatedKanban);
    }
  }

  void _onReorderBoardItem(ReorderBoardItem event, Emitter<KanbanState> emit) async {
    if (state is KanbanLoadSuccess) {
      final kanban = (state as KanbanLoadSuccess).kanban;
      final updatedColumns = List<BoardColumnModel>.from(kanban.columns);
      final sourceColumn = updatedColumns[event.oldListIndex];
      final destinationColumn = updatedColumns[event.listIndex];
      final item = sourceColumn.items!.removeAt(event.oldItemIndex);
      destinationColumn.items!.insert(event.itemIndex, item);
      updatedColumns[event.oldListIndex] = BoardColumnModel(
          columnName: sourceColumn.columnName, columnCount: sourceColumn.items!.length, items: List<BoardItemModel>.from(sourceColumn.items!));
      updatedColumns[event.listIndex] = BoardColumnModel(
          columnName: destinationColumn.columnName,
          columnCount: destinationColumn.items!.length,
          items: List<BoardItemModel>.from(destinationColumn.items!));
      final updatedKanban = KanbanModel(columns: updatedColumns);
      emit(KanbanLoadSuccess(updatedKanban));
      await _saveKanban(updatedKanban);
    }
  }
}
