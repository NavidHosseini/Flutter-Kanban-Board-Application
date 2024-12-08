import 'package:equatable/equatable.dart';

abstract class AddTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTaskTitleChanged extends AddTaskEvent {
  final String title;

  AddTaskTitleChanged(this.title);

  @override
  List<Object?> get props => [title];
}

class AddTaskDescriptionChanged extends AddTaskEvent {
  final String description;

  AddTaskDescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class AddTaskSubmitted extends AddTaskEvent {
  final int columnIndex;

  AddTaskSubmitted(this.columnIndex);

  @override
  List<Object?> get props => [columnIndex];
}
