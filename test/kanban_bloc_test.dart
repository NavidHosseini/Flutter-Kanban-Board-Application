import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban/modules/kanban/bloc/kanban_bloc.dart';
import 'package:kanban/modules/kanban/bloc/kanban_event.dart';
import 'package:kanban/modules/kanban/bloc/kanban_state.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('KanbanBloc Tests', () {
    late KanbanBloc kanbanBloc;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      SharedPreferences.setMockInitialValues({});
      kanbanBloc = KanbanBloc();
    });

    tearDown(() {
      kanbanBloc.close();
    });

    test('Initial state should be KanbanInitial', () {
      expect(kanbanBloc.state, KanbanInitial());
    });

    blocTest<KanbanBloc, KanbanState>(
      'Should emit KanbanLoadSuccess when initialized with no saved data',
      build: () {
        when(mockSharedPreferences.getString("any")).thenReturn(null);
        return KanbanBloc();
      },
      wait: const Duration(milliseconds: 100), // Added wait to handle asynchronous initialization
      expect: () => [
        isA<KanbanLoadSuccess>(),
      ],
    );

    blocTest<KanbanBloc, KanbanState>(
      'Should add a new task and update state',
      build: () => kanbanBloc,
      act: (bloc) {
        final task = BoardItemModel(
          id: 1,
          title: "New Task",
          description: "Task Description",
          boardItemModelTimeTrack: BoardItemModelTimeTrack(),
        );
        bloc.add(AddBoardItem(0, task));
      },
      expect: () => [
        isA<KanbanLoadSuccess>().having(
          (state) {
            int index = (state).kanban.columns[0].items!.indexWhere((e) => e.id == 1);
            if (index == -1) {
              return false;
            }
            return true;
          },
          'contains task',
          true,
        ),
      ],
    );

    blocTest<KanbanBloc, KanbanState>(
      'Should update a board item and update state',
      build: () => kanbanBloc,
      act: (bloc) {
        final task = BoardItemModel(
          id: 1,
          title: "Updated Task",
          description: "Updated Description",
          boardItemModelTimeTrack: BoardItemModelTimeTrack(),
        );
        bloc.add(UpdateBoardItem(0, task));
      },
      expect: () => [
        isA<KanbanLoadSuccess>().having(
          (state) => (state).kanban.columns[0].items!.any(
                (item) => item.id == 1 && item.title == "Updated Task" && item.description == "Updated Description",
              ),
          'updated task',
          true,
        ),
      ],
    );
    blocTest<KanbanBloc, KanbanState>(
      'Should delete a board item and update state',
      build: () => kanbanBloc,
      act: (bloc) {
        final task = BoardItemModel(
          id: 2,
          title: "Task to Delete",
          description: "Delete this task",
          boardItemModelTimeTrack: BoardItemModelTimeTrack(),
        );
        bloc.add(AddBoardItem(0, task));
        bloc.add(const DeleteBoardItem(0, 2));
      },
      expect: () => [
        isA<KanbanLoadSuccess>(),
        isA<KanbanLoadSuccess>().having(
          (state) => !(state).kanban.columns[0].items!.any(
                (item) => item.id == 2,
              ),
          'deleted task',
          true,
        ),
      ],
    );
    blocTest<KanbanBloc, KanbanState>(
      'Should reorder columns and update state',
      build: () => kanbanBloc,
      act: (bloc) {
        bloc.add(const ReorderColumn(0, 1));
      },
      expect: () => [
        isA<KanbanLoadSuccess>().having(
          (state) => (state).kanban.columns[1].columnName == "TODO",
          'reordered columns',
          true,
        ),
      ],
    );
  });
}
