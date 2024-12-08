import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/global/bloc/app_bloc.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.onChanged,
    this.controller,
    this.error,
    this.maxLines,
    this.maxLength,
    this.title,
    this.inputType,
    this.focusNode,
    this.autofocus = false,
    this.initialValue,
    this.keyboardType,
  });
  final TextInputType? keyboardType;
  final String hint;
  final String? initialValue;
  final String? title;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? error;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? inputType;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title!, style: TextStyle(fontSize: 18, color: context.read<AppBloc>().state.themeName == "dark" ? Colors.white : null)),
        SizedBox(height: title != null ? 8 : 0),
        TextFormField(
          initialValue: initialValue,
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          // style: context.theme.textTheme.bodyLarge,
          onChanged: onChanged,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            // fillColor: const Color.fromARGB(255, 216, 210, 210),
            // fillColor: fillColor ?? context.customTheme.color.fill,
            filled: true,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 216, 210, 210),
                // color: context.customTheme.color.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            hintText: hint,

            border: const OutlineInputBorder(),
            errorText: error != null && error!.isNotEmpty ? error : null,
          ),
        ),
      ],
    );
  }
}
