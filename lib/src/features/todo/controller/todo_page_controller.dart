import 'package:awesome_todo_app/src/core/data/drift_local_database/database.dart';
import 'package:awesome_todo_app/src/core/exceptions/exceptions.dart';
import 'package:awesome_todo_app/src/core/services/providers.dart';
import 'package:awesome_todo_app/src/features/todo/data/todo_repository.dart';
import 'package:awesome_todo_app/src/features/todo/view/widgets/menu.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_page_controller.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<List<AppTodo>> build() async {
    state = const AsyncValue.loading();
    return ref.watch(todoRepositoryProvider).fetchTodoList();
  }

  TodoRepository get repository => ref.read(todoRepositoryProvider);

  Future<void> toggle(AppTodo todo) async {
    state = await AsyncValue.guard(
      () async {
        await repository.updateTodo(todo.copyWith(completed: !todo.completed));
        todo.copyWith(completed: !todo.completed);
        return repository.fetchTodoList();
      },
    );
  }

  Future<void> edit(AppTodo todo) async {
    state = await AsyncValue.guard(
      () async {
        await repository.updateTodo(todo);
        return repository.fetchTodoList();
      },
    );
  }

  Future<void> add(String description) async {
    state = await AsyncValue.guard(
      () async {
        await repository.createTodo(description);
        return repository.fetchTodoList();
      },
    );
  }
}

@riverpod
class TodoFilter extends _$TodoFilter {
  @override
  TodoListFilter build() {
    return TodoListFilter.all;
  }

  void setState(TodoListFilter filter) {
    state = filter;
  }
}

@riverpod
List<AppTodo> filteredTodos(FilteredTodosRef ref) {
  final filter = ref.watch(todoFilterProvider);
  final todoList = ref.watch(todoListProvider);
  return switch (todoList) {
    AsyncData(:final value) => value
        .where(
          (todo) => switch (filter) {
            TodoListFilter.all => true,
            TodoListFilter.active => !todo.completed,
            TodoListFilter.completed => todo.completed,
          },
        )
        .toList(),
    _ => [],
  };
}

@riverpod
int uncompletedTodosCount(UncompletedTodosCountRef ref) {
  final todoList = ref.watch(todoListProvider);
  return switch (todoList) {
    AsyncData(value: final list) => list
        .where(
          (todo) => !todo.completed,
        )
        .length,
    _ => 0,
  };
}

@riverpod
AppTodo currentTodo(CurrentTodoRef ref) {
  throw ProviderNotOverriddenException(name: 'currentTodoProvider');
}

@Riverpod(keepAlive: true)
TodoRepository todoRepository(TodoRepositoryRef ref) {
  return TodoRepository(localDatabase: ref.watch(appDatabaseProvider));
}
