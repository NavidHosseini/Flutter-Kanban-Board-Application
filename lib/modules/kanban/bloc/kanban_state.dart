import 'package:equatable/equatable.dart';
import 'package:kanban/modules/kanban/models/kanban_model.dart';

abstract class KanbanState extends Equatable {
  const KanbanState();

  @override
  List<Object?> get props => [];
}

class KanbanInitial extends KanbanState {}

class KanbanLoadInProgress extends KanbanState {}

class KanbanLoadSuccess extends KanbanState {
  final KanbanModel kanban;

  const KanbanLoadSuccess(this.kanban);

  @override
  List<Object?> get props => [kanban];
}

class KanbanLoadFailure extends KanbanState {}
