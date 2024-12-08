import 'package:equatable/equatable.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';

class TaskDetailState extends Equatable {
  final BoardItemModel task;
  final bool hasUnsavedChanges;

  const TaskDetailState({required this.task, this.hasUnsavedChanges = false});

  TaskDetailState copyWith({BoardItemModel? task, bool? hasUnsavedChanges}) {
    return TaskDetailState(
      task: task ?? this.task,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
    );
  }

  @override
  List<Object> get props => [task, hasUnsavedChanges];
}
