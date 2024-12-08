import 'package:equatable/equatable.dart';

class AddTaskState extends Equatable {
  final String title;
  final String description;
  final bool success;

  const AddTaskState({
    this.title = '',
    this.description = '',
    this.success = false,
  });

  @override
  List<Object?> get props => [title, description, success];
}
