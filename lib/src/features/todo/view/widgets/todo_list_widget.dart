import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:awesome_todo_app/src/features/todo/view/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that displays a list of filtered to-do items using Riverpod for state management.
///
/// This widget listens to the `filteredTodosProvider` to get the list of to-dos that 
/// match the current filters. Each to-do item is displayed using the [TodoCard] widget.
/// The list is separated by a small vertical space.
///
/// This class is a [ConsumerWidget], which allows it to listen to Riverpod providers
/// and rebuild when the data from those providers changes.
class TodoListWidget extends ConsumerWidget {
  /// Creates an instance of [TodoListWidget].
  ///
  /// The constructor is marked as `const` to allow compile-time optimizations
  /// when no dynamic dependencies are present.
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the filtered to-do list from the Riverpod provider.
    final filteredTodoList = ref.watch(filteredTodosProvider);

    return ListView.separated(
      padding: const EdgeInsets.all(5),
      separatorBuilder: (context, index) => const SizedBox(
        height: 5, // Adds a vertical space of 5 pixels between each list item.
      ),
      itemCount: filteredTodoList.length, // Total number of to-dos to display.
      itemBuilder: (context, index) {
        // Creates a new provider scope for the current to-do item.
        return ProviderScope(
          overrides: [
            // Overrides the `currentTodoProvider` with the current to-do item.
            currentTodoProvider.overrideWithValue(filteredTodoList[index]),
          ],
          // Displays the to-do item using the `TodoCard` widget.
          child: const TodoCard(),
        );
      },
    );
  }
}
