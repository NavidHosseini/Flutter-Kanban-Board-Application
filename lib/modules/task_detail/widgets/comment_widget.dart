import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kanban/global/bloc/app_bloc.dart';
import 'package:kanban/l10n/l10n.dart';
import 'package:kanban/modules/kanban/models/comment.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.comments});

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(context.localizations.comments,
            style: TextStyle(fontSize: 18, color: context.read<AppBloc>().state.themeName == "dark" ? Colors.white : null)),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: comments.map((comment) {
            return Column(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(comment.userName)),
                      Text(
                        DateFormat('yyyy-MM-dd – kk:mm').format(comment.createdAt),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  subtitle: Text(comment.text),
                ),
                const Divider()
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
