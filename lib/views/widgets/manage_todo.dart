

import 'package:flutter/material.dart';

import '../../models/todo_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ManageTodoDialog extends StatefulWidget {
  final Todo? todo;
  const ManageTodoDialog({
    super.key,
    this.todo,
  });

  @override
  State<ManageTodoDialog> createState() => _ManageTodoDialogState();
}

class _ManageTodoDialogState extends State<ManageTodoDialog> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  String date = "";
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      title = widget.todo!.title;
      date = widget.todo!.date;
      isCompleted = widget.todo!.isCompleted;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.pop(context, {
        "title": title,
        "date": date,
        "isCompleted": isCompleted,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        widget.todo != null ? AppLocalizations.of(context)!.addTask : AppLocalizations.of(context)!.editTask,
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: title,
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.taskName,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos vazifa nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                title = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: date,
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.taskDate,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos vazifa vaqtini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                date = newValue!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:  Text(AppLocalizations.of(context)!.cancel),
        ),
        FilledButton(
          onPressed: submit,
          child:  Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}