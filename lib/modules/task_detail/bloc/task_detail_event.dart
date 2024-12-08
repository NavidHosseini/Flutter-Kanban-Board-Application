import 'package:equatable/equatable.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';
import 'package:kanban/modules/kanban/models/comment.dart';

abstract class TaskDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskDetailTitleChanged extends TaskDetailEvent {
  final String title;

  TaskDetailTitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

class TaskDetailDescriptionChanged extends TaskDetailEvent {
  final String description;

  TaskDetailDescriptionChanged(this.description);

  @override
  List<Object> get props => [description];
}

class TaskDetailCommentAdded extends TaskDetailEvent {
  final Comment comment;

  TaskDetailCommentAdded(this.comment);

  @override
  List<Object> get props => [comment];
}

class TaskDetailSaved extends TaskDetailEvent {
  final int columnIndex;

  TaskDetailSaved(this.columnIndex);

  @override
  List<Object> get props => [columnIndex];
}

class TaskDetailTimerChange extends TaskDetailEvent {
  final BoardItemModelTimeTrack boardItemModelTimeTrack;

  TaskDetailTimerChange(this.boardItemModelTimeTrack);

  @override
  List<Object> get props => [boardItemModelTimeTrack];
}
