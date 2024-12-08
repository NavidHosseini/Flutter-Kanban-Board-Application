import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/global/bloc/app_bloc.dart';
import 'package:kanban/global/bloc/app_event.dart';
import 'package:kanban/global/widgets/custom_kanban/boardview.dart';
import 'package:kanban/global/widgets/custom_kanban/kanban_view.dart';
import 'package:kanban/l10n/l10n.dart';
import 'package:kanban/modules/kanban/bloc/kanban_bloc.dart';
import 'package:kanban/modules/kanban/bloc/kanban_event.dart';
import 'package:kanban/modules/kanban/bloc/kanban_state.dart';
import 'package:kanban/modules/kanban/models/column_model.dart';
import 'package:kanban/modules/kanban/widgets/board_card.dart';

class KanbanBoardScreen extends StatelessWidget {
  const KanbanBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.kanban_board),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (String languageCode) {
              context.read<AppBloc>().add(LanguageChanged(languageCode));
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'en',
                child: Text(context.localizations.english),
              ),
              PopupMenuItem<String>(
                value: 'de',
                child: Text(context.localizations.germany),
              ),
            ],
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.brightness_6),
            onSelected: (String themeName) {
              context.read<AppBloc>().add(ThemeChanged(themeName));
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'light',
                child: Text(context.localizations.light_theme),
              ),
              PopupMenuItem<String>(
                value: 'dark',
                child: Text(context.localizations.dark_theme),
              ),
              PopupMenuItem<String>(
                value: 'red',
                child: Text(context.localizations.red_theme),
              ),
              PopupMenuItem<String>(
                value: 'green',
                child: Text(context.localizations.green_theme),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<KanbanBloc, KanbanState>(
        builder: (context, state) {
          if (state is KanbanLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is KanbanLoadSuccess) {
            return BoardView(lists: _buildKanbanLists(state.kanban.columns, context));
          } else {
            return Center(child: Text(context.localizations.failed_to_load_board));
          }
        },
      ),
    );
  }

  List<BoardList> _buildKanbanLists(List<BoardColumnModel> columns, BuildContext context) {
    return columns
        .mapIndexed(
          (index, e) => BoardList(
            backgroundColor: Theme.of(context).primaryColor,
            draggable: true,
            onDropList: (oldIndex, newIndex) {
              context.read<KanbanBloc>().add(ReorderColumn(oldIndex!, newIndex!));
            },
            footer: TextButton.icon(
              onPressed: () {
                context.push('/add_task', extra: index);
              },
              label: Text(context.localizations.add_task),
              icon: const Icon(Icons.add),
            ),
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  columnNameText(e.columnName, context),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "${e.columnCount}",
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
            ),
            headerBackgroundColor: Colors.transparent,
            items: e.items
                ?.map(
                  (borderItemModel) => BoardItem(
                    draggable: true,
                    onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex, int? oldItemIndex, BoardItemState? state) {
                      context.read<KanbanBloc>().add(ReorderBoardItem(listIndex!, itemIndex!, oldListIndex!, oldItemIndex!));
                    },
                    item: BoardCard(
                      item: borderItemModel,
                      columnName: e.columnName,
                      columnIndex: index,
                    ),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }
}

Widget columnNameText(String columnName, BuildContext context) {
  String name = "";
  switch (columnName) {
    case "TODO":
      name = context.localizations.todo;
      break;
    case "IN PROGRESS":
      name = context.localizations.in_progress;
      break;
    case "DONE":
      name = context.localizations.done;
      break;
    default:
      name = context.localizations.todo;
  }
  return Text(
    name,
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: context.read<AppBloc>().state.themeName == "dark" ? Theme.of(context).cardColor : null,
    ),
  );
}
