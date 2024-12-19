import 'package:awesome_todo_app/resources/l10n/l10n.dart';
import 'package:awesome_todo_app/src/core/data/drift_local_database/database.dart';
import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/widgets.dart';

/// `TodoPage` is a `ConsumerStatefulWidget` that displays the main user interface of the To-Do app.
/// It uses Riverpod to manage state and handles the interaction with a local database to fetch and manage a list of todos.
class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _HomeState();
}

class _HomeState extends ConsumerState<TodoPage> {
  /// The `initState` method is called when the widget is inserted into the widget tree.
  /// It calls the super method to initialize state.
  @override
  void initState() {
    super.initState();
  }

  /// Refreshes the to-do list by invalidating the current provider and re-fetching the data.
  ///
  /// This method triggers the invalidation of the `todoListProvider`, causing it to be reloaded.
  /// It returns a `Future` to allow the UI to update accordingly.
  Future<void> onRefresh() {
    ref.invalidate(todoListProvider);
    return ref.read(todoListProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    // Watching the to-do list provider to manage the asynchronous state of fetching todos.
    final AsyncValue<List<AppTodo>> todosProvider = ref.watch(todoListProvider);
    // Watching the filtered to-do list provider for displaying filtered todos.
    final filteredTodoList = ref.watch(filteredTodosProvider);

    return GestureDetector(
      // Dismisses the keyboard when tapping outside of a text input field.
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        // Pull-to-refresh functionality.
        onRefresh: onRefresh,
        child: Scaffold(
          body: SafeArea(
            child: todosProvider.when(
              // Display a loading indicator when the to-do list is being fetched.
              loading: () => const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // Display an error message if there was an issue fetching the to-do list.
              error: (error, stack) => Center(
                child: Center(
                  child: Text(context.l10n.couldntMakeLocalDatabaseRequest),
                ),
              ),
              // Once the data is successfully fetched, display the to-do list.
              data: (unFilteredTodoList) => Column(
                children: [
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: NewTodoTextField(),
                  ),
                  const SizedBox(height: 42),
                  // If there are uncompleted todos, show a message.
                  if (unFilteredTodoList.isNotEmpty)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Text(
                          context.l10n.xToDosStillToBeDone(
                            ref.watch(uncompletedTodosCountProvider),
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  // Display either the filtered to-do list or a message when there are no to-dos.
                  Expanded(
                    child: filteredTodoList.isEmpty
                        ? const NoTodosWidget()
                        : const TodoListWidget(),
                  ),
                ],
              ),
            ),
          ),
          // Bottom navigation menu.
          bottomNavigationBar: const Menu(),
        ),
      ),
    );
  }
}
