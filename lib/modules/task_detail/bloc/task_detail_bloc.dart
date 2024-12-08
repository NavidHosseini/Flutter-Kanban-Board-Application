import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/locator.dart';
import 'package:kanban/modules/kanban/bloc/kanban_bloc.dart';
import 'package:kanban/modules/kanban/bloc/kanban_event.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';
import 'package:kanban/modules/kanban/models/comment.dart';

import 'task_detail_event.dart';
import 'task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  TaskDetailBloc(BoardItemModel initialTask) : super(TaskDetailState(task: initialTask)) {
    on<TaskDetailTitleChanged>(_onTaskDetailTitleChanged);
    on<TaskDetailDescriptionChanged>(_onTaskDetailDescriptionChanged);
    on<TaskDetailCommentAdded>(_onTaskDetailCommentAdded);
    on<TaskDetailTimerChange>(_onTaskTimerChange);
    on<TaskDetailSaved>(_onTaskDetailSaved);
  }

  void _onTaskDetailTitleChanged(TaskDetailTitleChanged event, Emitter<TaskDetailState> emit) {
    final updatedTask = BoardItemModel(
      title: event.title,
      id: state.task.id,
      description: state.task.description,
      comments: state.task.comments,
      boardItemModelTimeTrack: state.task.boardItemModelTimeTrack,
    );
    emit(TaskDetailState(task: updatedTask, hasUnsavedChanges: true));
  }

  void _onTaskDetailDescriptionChanged(TaskDetailDescriptionChanged event, Emitter<TaskDetailState> emit) {
    final updatedTask = BoardItemModel(
        id: state.task.id,
        title: state.task.title,
        description: event.description,
        comments: state.task.comments,
        boardItemModelTimeTrack: state.task.boardItemModelTimeTrack);
    emit(TaskDetailState(task: updatedTask, hasUnsavedChanges: true));
  }

  void _onTaskTimerChange(TaskDetailTimerChange event, Emitter<TaskDetailState> emit) {
    final updatedTask = BoardItemModel(
      id: state.task.id,
      title: state.task.title,
      description: state.task.description,
      comments: state.task.comments,
      boardItemModelTimeTrack: event.boardItemModelTimeTrack,
    );
    emit(TaskDetailState(task: updatedTask, hasUnsavedChanges: true));
  }

  void _onTaskDetailCommentAdded(TaskDetailCommentAdded event, Emitter<TaskDetailState> emit) {
    final updatedComments = List<Comment>.from(state.task.comments)..add(event.comment);
    final updatedTask = BoardItemModel(
      id: state.task.id,
      title: state.task.title,
      description: state.task.description,
      comments: updatedComments,
      boardItemModelTimeTrack: state.task.boardItemModelTimeTrack,
    );
    emit(TaskDetailState(task: updatedTask, hasUnsavedChanges: true));
  }

  void _onTaskDetailSaved(TaskDetailSaved event, Emitter<TaskDetailState> emit) {
    emit(TaskDetailState(task: state.task, hasUnsavedChanges: false));
    locator<KanbanBloc>().add(UpdateBoardItem(event.columnIndex, state.task));
  }
}
