import 'package:awesome_todo_app/src/core/data/drift_local_database/database.dart';
import 'package:awesome_todo_app/src/features/todo/controller/todo_page_controller.dart';
import 'package:awesome_todo_app/src/features/todo/view/widgets/menu.dart';
import 'package:awesome_todo_app/src/features/todo/view/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Keys for components for testing
final addTodoKey = UniqueKey();

class TodoPage extends StatefulHookConsumerWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _HomeState();
}

class _HomeState extends ConsumerState<TodoPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> onRefresh() {
    ref.invalidate(todoListProvider);
    return ref.read(todoListProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<AppTodo>> todosProvider = ref
        .watch(todoListProvider); // this is only used for the loading animation

    final todos = ref.watch(filteredTodosProvider);
    final newTodoController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: Scaffold(
          body: todosProvider.when(
              loading: () => const Center(
                  child: Center(child: CircularProgressIndicator())),
              error: (error, stack) => const Center(
                      child: Center(
                    child: Text(
                        'Could\'nt make API request. Make sure server is running.'),
                  )),
              data: (_) => ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    children: [
                      TextField(
                        key: addTodoKey,
                        controller: newTodoController,
                        decoration: const InputDecoration(
                          labelText: 'What do we need to do?',
                        ),
                        onSubmitted: (value) {
                          ref.read(todoListProvider.notifier).add(value);
                          newTodoController.clear();
                        },
                      ),
                      const SizedBox(height: 42),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                            '${ref.watch(uncompletedTodosCountProvider)} items left',
                            style: const TextStyle(fontSize: 20)),
                      ),
                      if (todos.isNotEmpty) const Divider(height: 0),
                      for (var i = 0; i < todos.length; i++) ...[
                        if (i > 0) const Divider(height: 0),
                        ProviderScope(
                          overrides: [
                            currentTodoProvider.overrideWithValue(todos[i]),
                          ],
                          child: const TodoItem(),
                        ),
                      ],
                    ],
                  )),
          bottomNavigationBar: const Menu(),
        ),
      ),
    );
  }
}
