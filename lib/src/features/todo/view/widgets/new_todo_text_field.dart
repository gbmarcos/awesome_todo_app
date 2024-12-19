import 'package:awesome_todo_app/resources/l10n/l10n.dart';
import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// A [StatefulHookConsumerWidget] used for creating a text field to add new
/// tasks in a to-do list application. This widget integrates Riverpod for state
/// management and hooks for efficient controller management.
///
/// This widget is designed to provide a seamless user experience for adding new
/// tasks, featuring:
/// - Localization support for placeholder text.
/// - A modern UI with rounded borders and color theming.
/// - Automatic submission of tasks to the to-do list upon pressing "Enter".
///
/// ### Usage:
/// Simply include this widget within a parent widget and ensure that the
/// necessary dependencies, such as `todoListProvider` and localization, are properly set up.
class NewTodoTextField extends StatefulHookConsumerWidget {
  /// Creates a [NewTodoTextField] widget.
  const NewTodoTextField({
    super.key,
  });

  @override
  NewTodoTextFieldState createState() => NewTodoTextFieldState();
}

/// State class for [NewTodoTextField].
///
/// Manages the text input state and handles task submission.
class NewTodoTextFieldState extends ConsumerState<NewTodoTextField> {
  @override
  Widget build(BuildContext context) {
    // Using Flutter Hooks to manage a TextEditingController efficiently.
    final newTodoController = useTextEditingController();

    return TextField(
      controller: newTodoController,
      decoration: InputDecoration(
        // Uses localization for the label text.
        labelText: context.l10n.whatDoWeNeedToDo,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
      ),
      // Callback executed when the user submits text.
      onSubmitted: (value) {
        // Adds the new task to the to-do list using the Riverpod provider.
        ref.read(todoListProvider.notifier).add(value);
        // Clears the text field for the next input.
        newTodoController.clear();
      },
    );
  }
}
