import 'package:get_it/get_it.dart';
import 'package:kanban/global/bloc/app_bloc.dart';
import 'package:kanban/modules/add_task/bloc/add_task_bloc.dart';
import 'package:kanban/modules/kanban/bloc/kanban_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(AppBloc());
  locator.registerLazySingleton(() => KanbanBloc());
  locator.registerLazySingleton(() => AddTaskBloc());
}
