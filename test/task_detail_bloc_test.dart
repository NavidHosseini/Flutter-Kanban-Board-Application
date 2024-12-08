import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';
import 'package:kanban/modules/kanban/models/comment.dart';
import 'package:kanban/modules/task_detail/bloc/task_detail_bloc.dart';
import 'package:kanban/modules/task_detail/bloc/task_detail_event.dart';
import 'package:kanban/modules/task_detail/bloc/task_detail_state.dart';

void main() {
  group('TaskDetailBloc Tests', () {
    late TaskDetailBloc taskDetailBloc;

    setUp(() {
      final initialTask = BoardItemModel(
        id: 1,
        title: "Initial Task",
        description: "Initial Description",
        boardItemModelTimeTrack: BoardItemModelTimeTrack(),
      );
      taskDetailBloc = TaskDetailBloc(initialTask);
    });

    tearDown(() {
      taskDetailBloc.close();
    });

    test('Initial state should contain the initial task', () {
      expect(taskDetailBloc.state.task.title, "Initial Task");
      expect(taskDetailBloc.state.task.description, "Initial Description");
      expect(taskDetailBloc.state.task.comments, isEmpty);
    });

    blocTest<TaskDetailBloc, TaskDetailState>(
      'Should update task title and set hasUnsavedChanges to true',
      build: () => taskDetailBloc,
      act: (bloc) => bloc.add(TaskDetailTitleChanged("Updated Task Title")),
      expect: () => [
        isA<TaskDetailState>().having(
          (state) => (state).task.title == "Updated Task Title",
          'updated task title',
          true,
        ),
      ],
    );

    blocTest<TaskDetailBloc, TaskDetailState>(
      'Should update task description and set hasUnsavedChanges to true',
      build: () => taskDetailBloc,
      act: (bloc) => bloc.add(TaskDetailDescriptionChanged("Updated Task Description")),
      expect: () => [
        isA<TaskDetailState>().having(
          (state) => (state).task.description == "Updated Task Description",
          'updated task description',
          true,
        ),
      ],
    );

    blocTest<TaskDetailBloc, TaskDetailState>(
      'Should add a comment and set hasUnsavedChanges to true',
      build: () => taskDetailBloc,
      act: (bloc) {
        final comment = Comment(userName: "test", text: "New Comment", createdAt: DateTime.now());
        bloc.add(TaskDetailCommentAdded(comment));
      },
      expect: () => [
        isA<TaskDetailState>().having(
          (state) {
            final int index = (state).task.comments.indexWhere((e) => e.text == "New Comment");
            if (index == -1) {
              return false;
            }
            return true;
          },
          'add task comment ',
          true,
        ),
      ],
    );
  });
}
