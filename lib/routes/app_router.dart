import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/locator.dart';
import 'package:kanban/modules/add_task/add_task_screen.dart';
import 'package:kanban/modules/add_task/bloc/add_task_bloc.dart';
import 'package:kanban/modules/kanban/bloc/kanban_bloc.dart';
import 'package:kanban/modules/kanban/kanban_board_screen.dart';
import 'package:kanban/modules/task_detail/bloc/task_detail_bloc.dart';
import 'package:kanban/modules/task_detail/models/screen_args_model.dart';
import 'package:kanban/modules/task_detail/task_detail_screen.dart';

class AppRouter {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  static final GoRouter router = GoRouter(
    observers: [FirebaseAnalyticsObserver(analytics: analytics)],
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) => locator<KanbanBloc>(),
          child: const KanbanBoardScreen(),
        ),
      ),
      GoRoute(
          path: '/add_task',
          builder: (context, state) {
            final int args = state.extra as int;
            return MultiBlocProvider(
              providers: [BlocProvider.value(value: locator<AddTaskBloc>())],
              child: AddTaskScreen(columnIndex: args),
            );
          }),
      GoRoute(
        path: '/task',
        builder: (context, state) {
          ScreenArgsModel args = state.extra as ScreenArgsModel;
          return BlocProvider(
            create: (_) => TaskDetailBloc(args.task.copyWith()),
            child: TaskDetailScreen(
              task: args.task.copyWith(),
              columnIndex: args.columnIndex,
              columnName: args.columnName,
            ),
          );
        },
      ),
    ],
  );

  static GoRouter get _router => router;
}
