import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/global/widgets/app_text_field.dart';
import 'package:kanban/l10n/l10n.dart';
import 'package:kanban/modules/add_task/bloc/add_task_bloc.dart';
import 'package:kanban/modules/add_task/bloc/add_task_event.dart';
import 'package:kanban/modules/add_task/bloc/add_task_state.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key, required this.columnIndex});
  final int columnIndex;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {
        if (state.success) {
          Navigator.pop(context, true);
        }
      },
      child: BlocBuilder<AddTaskBloc, AddTaskState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.localizations.add_task),
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    context.read<AddTaskBloc>().add(AddTaskSubmitted(columnIndex));
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    title: context.localizations.title,
                    hint: context.localizations.task_title,
                    onChanged: (value) {
                      context.read<AddTaskBloc>().add(AddTaskTitleChanged(value));
                    },
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    title: context.localizations.description,
                    hint: context.localizations.task_description,
                    maxLines: 5,
                    onChanged: (value) {
                      context.read<AddTaskBloc>().add(AddTaskDescriptionChanged(value));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
