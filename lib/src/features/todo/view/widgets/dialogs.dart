import 'package:awesome_todo_app/resources/l10n/l10n.dart';
import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// EditDialog: A dialog widget that provides an interface for editing the description of a to-do item.
///
/// This dialog uses a `TextField` for input and integrates with a Riverpod state management setup
/// to fetch and update the current to-do item's description. It ensures proper resource cleanup
/// by disposing the `TextEditingController` when the widget is disposed.
///
/// Features:
/// - Pre-fills the `TextField` with the current to-do description.
/// - Provides localized text for labels and actions.
/// - Validates user input to ensure the updated text is not empty.
///
/// Usage:
/// - Display this dialog to edit the description of a specific to-do item.
class EditDialog extends ConsumerStatefulWidget {
  const EditDialog({super.key});

  @override
  ConsumerState createState() => _EditDialogState();
}

class _EditDialogState extends ConsumerState<EditDialog> {
  /// The initial text value fetched from the current to-do item.
  late final initialText = ref.read(currentTodoProvider).description;

  /// Controller for managing the input text in the `TextField`.
  late final TextEditingController _textController =
      TextEditingController(text: initialText);

  @override
  void dispose() {
    _textController.dispose(); // Dispose of the controller to free resources.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.l10n.editTodo, // Localized title for the dialog.
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: TextField(
        controller: _textController,
        autofocus: true,
        maxLines: 4,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: context.l10n.enterTaskDetails,
          // Localized hint text.
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without saving.
          },
          child: Text(context.l10n.cancel), // Localized cancel button.
        ),
        ElevatedButton(
          onPressed: () {
            final updatedText = _textController.text.trim();
            if (updatedText.isNotEmpty) {
              save(); // Save the updated description.
              Navigator.of(context).pop(); // Close the dialog.
            }
          },
          child: Text(context.l10n.save), // Localized save button.
        ),
      ],
    );
  }

  /// Saves the updated description for the current to-do item.
  void save() {
    final todo = ref.read(currentTodoProvider);
    if (todo.description != _textController.text.trim()) {
      ref
          .read(todoListProvider.notifier)
          .edit(todo.copyWith(description: _textController.text.trim()));
    }
  }
}

/// DeleteDialog: A dialog widget that provides a confirmation interface for deleting a to-do item.
///
/// This dialog warns the user about the permanence of the deletion action and integrates with
/// Riverpod state management to remove the selected to-do item upon confirmation.
///
/// Features:
/// - Displays a warning message about the irreversible nature of the delete action.
/// - Provides localized text for labels and actions.
///
/// Usage:
/// - Display this dialog to confirm the deletion of a specific to-do item.
class DeleteDialog extends ConsumerWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(
        context.l10n.confirmDelete, // Localized title for the dialog.
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: Text(
        context.l10n
            .areYouSureYouWantToDeleteThisTodoThisActionCannotBeUndone, // Warning message.
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without deleting.
          },
          child: Text(context.l10n.cancel), // Localized cancel button.
        ),
        ElevatedButton(
          onPressed: () {
            final todo = ref.read(currentTodoProvider);
            ref
                .read(todoListProvider.notifier)
                .delete(todo); // Delete the To-do item.
            Navigator.of(context).pop(); // Close the dialog.
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red, // Red color to signify delete action.
          ),
          child: Text(context.l10n.delete), // Localized delete button.
        ),
      ],
    );
  }
}
