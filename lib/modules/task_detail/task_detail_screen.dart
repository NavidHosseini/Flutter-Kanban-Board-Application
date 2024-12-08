import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/global/bloc/app_bloc.dart';
import 'package:kanban/global/widgets/app_text_field.dart';
import 'package:kanban/l10n/l10n.dart';
import 'package:kanban/locator.dart';
import 'package:kanban/modules/kanban/bloc/kanban_bloc.dart';
import 'package:kanban/modules/kanban/bloc/kanban_event.dart';
import 'package:kanban/modules/kanban/models/board_item_model.dart';
import 'package:kanban/modules/kanban/models/comment.dart';
import 'package:kanban/modules/task_detail/bloc/task_detail_bloc.dart';
import 'package:kanban/modules/task_detail/bloc/task_detail_event.dart';
import 'package:kanban/modules/task_detail/bloc/task_detail_state.dart';
import 'package:kanban/modules/task_detail/widgets/comment_widget.dart';
import 'package:kanban/modules/task_detail/widgets/time_tacking_widget.dart';

class TaskDetailScreen extends StatelessWidget {
  final BoardItemModel task;
  final String columnName;
  final int columnIndex;

  TaskDetailScreen({super.key, required this.task, required this.columnName, required this.columnIndex});

  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state.hasUnsavedChanges) {
              _showSaveDialog(context, state);
              return false;
            } else {
              return true;
            }
          },
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(context.localizations.task_details),
                actions: [
                  IconButton(
                    onPressed: () {
                      _deleteTask(context);
                    },
                    icon: const Icon(Icons.delete, color: Color.fromARGB(255, 163, 58, 52)),
                  ),
                ],
              ),
              body: _buildTaskDetails(context, state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskDetails(BuildContext context, TaskDetailState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 60),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    title: context.localizations.title,
                    hint: context.localizations.task_title,
                    initialValue: state.task.title,
                    onChanged: (value) {
                      context.read<TaskDetailBloc>().add(TaskDetailTitleChanged(value));
                    },
                    autofocus: false,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    initialValue: state.task.description,
                    title: context.localizations.description,
                    hint: context.localizations.working_on,
                    maxLines: 5,
                    autofocus: false,
                    onChanged: (value) {
                      context.read<TaskDetailBloc>().add(TaskDetailDescriptionChanged(value));
                    },
                  ),
                  TimeTrackingWidget(
                    taskTimer: state.task.boardItemModelTimeTrack,
                    onChange: (taskTimer) => context.read<TaskDetailBloc>().add(TaskDetailTimerChange(taskTimer)),
                  ),
                  CommentWidget(comments: state.task.comments),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      hint: context.localizations.add_a_comment,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      controller: _commentController,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        final commentModel = Comment(
                          userName: "user", // TODO: Replace with actual user
                          text: _commentController.text, createdAt: DateTime.now(),
                        );
                        context.read<TaskDetailBloc>().add(TaskDetailCommentAdded(commentModel));
                        _commentController.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    locator<KanbanBloc>().add(DeleteBoardItem(columnIndex, task.id!));
    Navigator.pop(context);
  }

  Future<void> _showSaveDialog(BuildContext context, TaskDetailState state) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext c) {
        return AlertDialog(
          title: Text(context.localizations.save_changes),
          content: Text(
            context.localizations.do_you_want_to_save_your_current_changes,
            style: TextStyle(color: context.read<AppBloc>().state.themeName == "dark" ? Colors.white : null),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(context.localizations.no),
            ),
            TextButton(
              onPressed: () {
                context.read<TaskDetailBloc>().add(TaskDetailSaved(columnIndex));

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(context.localizations.yes),
            ),
          ],
        );
      },
    );
  }
}
