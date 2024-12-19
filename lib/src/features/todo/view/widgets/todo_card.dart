import 'package:awesome_todo_app/resources/l10n/l10n.dart';
import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:awesome_todo_app/src/features/todo/view/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents options available for a to-do item.
/// Provides localized text for each option using the app's localization resources.
enum TodoOption {
  edit,
  delete;

  /// Returns the localized text for the enum value.
  /// [context] is used to access the localization resources.
  String localizedText(BuildContext context) => switch (this) {
    TodoOption.edit => context.l10n.edit,
    TodoOption.delete => context.l10n.delete,
  };
}

/// A widget that displays a to-do item as a card with functionality to toggle its completion,
/// edit it, or delete it.
/// 
/// This widget is part of the to-do app's UI and uses the Riverpod state management library
/// to handle state and actions.
class TodoCard extends ConsumerWidget {
  /// Creates a new [TodoCard].
  const TodoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the current to-do item from the provider.
    final todo = ref.watch(currentTodoProvider);

    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: ListTile(
        // Checkbox for toggling the completion status of the to-do.
        leading: Checkbox(
          value: todo.completed,
          onChanged: (value) =>
              ref.read(todoListProvider.notifier).toggle(todo),
        ),
        // Animated text style that changes based on the to-do's completion status.
        title: AnimatedDefaultTextStyle(
          style: TextStyle(
            color: todo.completed ? Colors.black45 : Colors.black,
            decoration: todo.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
          duration: const Duration(microseconds: 200),
          child: Text(
            todo.description,
          ),
        ),
        // Popup menu with options to edit or delete the to-do.
        trailing: PopupMenuButton<TodoOption>(
          color: Colors.white,
          onSelected: (option) {
            // Shows a dialog for the selected action (edit or delete).
            showDialog(
              context: context,
              builder: (context) => ProviderScope(
                overrides: [currentTodoProvider.overrideWithValue(todo)],
                child: switch (option) {
                  TodoOption.edit => const EditDialog(),
                  TodoOption.delete => const DeleteDialog(),
                },
              ),
            );
          },
          // Builds the popup menu items dynamically for each TodoOption.
          itemBuilder: (context) => List.generate(
            TodoOption.values.length,
                (index) => PopupMenuItem(
              value: TodoOption.values[index],
              child: Text(TodoOption.values[index].localizedText(context)),
            ),
          ),
        ),
      ),
    );
  }
}
