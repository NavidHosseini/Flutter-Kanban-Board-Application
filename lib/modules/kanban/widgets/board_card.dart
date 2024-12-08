import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';
import 'package:kanban/modules/task_detail/models/screen_args_model.dart';

class BoardCard extends StatelessWidget {
  final BoardItemModel item;
  final String columnName;
  final int columnIndex;

  const BoardCard({
    super.key,
    required this.item,
    required this.columnName,
    required this.columnIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/task',
            extra: ScreenArgsModel(
              task: item,
              columnIndex: columnIndex,
              columnName: columnName,
            ));
      },
      child: Card(
        color: Theme.of(context).cardColor,
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Opacity(opacity: 0.6, child: Text(item.description, maxLines: 1)),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.supervised_user_circle_outlined),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
