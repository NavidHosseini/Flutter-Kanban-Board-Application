import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/locator.dart';
import 'package:kanban/modules/kanban/bloc/kanban_bloc.dart';
import 'package:kanban/modules/kanban/bloc/kanban_event.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';

import 'add_task_event.dart';
import 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(const AddTaskState()) {
    on<AddTaskTitleChanged>(_onAddTaskTitleChanged);
    on<AddTaskDescriptionChanged>(_onAddTaskDescriptionChanged);
    on<AddTaskSubmitted>(_onAddTaskSubmitted);
  }

  void _onAddTaskTitleChanged(AddTaskTitleChanged event, Emitter<AddTaskState> emit) {
    emit(AddTaskState(
      title: event.title,
      description: state.description,
      success: false,
    ));
  }

  void _onAddTaskDescriptionChanged(AddTaskDescriptionChanged event, Emitter<AddTaskState> emit) {
    emit(AddTaskState(
      title: state.title,
      description: event.description,
      success: false,
    ));
  }

  void _onAddTaskSubmitted(AddTaskSubmitted event, Emitter<AddTaskState> emit) {
    final newTask = BoardItemModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: state.title,
      description: state.description,
      boardItemModelTimeTrack: BoardItemModelTimeTrack(),
    );

    locator<KanbanBloc>().add(AddBoardItem(event.columnIndex, newTask));

    emit(AddTaskState(
      title: state.title,
      description: state.description,
      success: true,
    ));
  }
}
