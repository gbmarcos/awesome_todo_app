import 'package:awesome_todo_app/src/core/data/drift_local_database/database.dart';
import 'package:awesome_todo_app/src/core/exceptions/exceptions.dart';
import 'package:awesome_todo_app/src/core/services/providers.dart';
import 'package:awesome_todo_app/src/features/todo/data/todo_repository.dart';
import 'package:awesome_todo_app/src/features/todo/view/widgets/menu.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_page_controller.g.dart';

/// **TodoList**
/// This Riverpod provider manages the state of the to-do list. 
/// It handles fetching, adding, editing, and toggling Todos, ensuring the state 
/// remains consistent and reactive throughout the app.
@riverpod
class TodoList extends _$TodoList {
  /// Initializes the provider with a loading state and fetches the to-do list.
  @override
  FutureOr<List<AppTodo>> build() async {
    state = const AsyncValue.loading();
    return ref.watch(todoRepositoryProvider).fetchTodoList();
  }

  /// Accessor for the `TodoRepository` instance.
  TodoRepository get repository => ref.read(todoRepositoryProvider);

  /// Toggles the `completed` state of a given to-do and updates the list.
  Future<void> toggle(AppTodo todo) async {
    state = await AsyncValue.guard(() async {
      await repository.updateTodo(todo.copyWith(completed: !todo.completed));
      return repository.fetchTodoList();
    });
  }

  /// Updates a to-do with new data and refreshes the list.
  Future<void> edit(AppTodo todo) async {
    state = await AsyncValue.guard(() async {
      await repository.updateTodo(todo);
      return repository.fetchTodoList();
    });
  }

  /// Delete a to-do  and refreshes the list.
  Future<void> delete(AppTodo todo) async {
    state = await AsyncValue.guard(() async {
      await repository.deleteTodo(todo);
      return repository.fetchTodoList();
    });
  }

  /// Adds a new to-do with the provided description and updates the list.
  Future<void> add(String description) async {
    state = await AsyncValue.guard(() async {
      await repository.createTodo(description);
      return repository.fetchTodoList();
    });
  }
}

/// **TodoFilter**
/// This provider manages the filter state for the to-do list, 
/// allowing the user to switch between showing all, active, or completed Todos.
@riverpod
class TodoFilter extends _$TodoFilter {
  /// Initializes the filter state to show all Todos.
  @override
  TodoListFilter build() {
    return TodoListFilter.all;
  }

  /// Updates the filter state.
  void setState(TodoListFilter filter) {
    state = filter;
  }
}

/// **FilteredTodos**
/// This computed provider derives a filtered list of Todos based on the current filter state.
@riverpod
List<AppTodo> filteredTodos(FilteredTodosRef ref) {
  final filter = ref.watch(todoFilterProvider);
  final todoList = ref.watch(todoListProvider);
  return switch (todoList) {
    AsyncData(:final value) => value.where((todo) {
      return switch (filter) {
        TodoListFilter.all => true,
        TodoListFilter.active => !todo.completed,
        TodoListFilter.completed => todo.completed,
      };
    }).toList(),
    _ => [],
  };
}

/// **UncompletedTodosCount**
/// This computed provider calculates the number of uncompleted to-dos.
@riverpod
int uncompletedTodosCount(UncompletedTodosCountRef ref) {
  final todoList = ref.watch(todoListProvider);
  return switch (todoList) {
    AsyncData(value: final list) => list.where((todo) => !todo.completed).length,
    _ => 0,
  };
}

/// **CurrentTodo**
/// This provider is designed to hold the current to-do being interacted with. 
/// It throws an exception if not overridden.
@riverpod
AppTodo currentTodo(CurrentTodoRef ref) {
  throw ProviderNotOverriddenException(name: 'currentTodoProvider');
}

/// **TodoRepository**
/// This provider creates a `TodoRepository` instance and ensures it is shared 
/// across the application while maintaining a long-lived state.
@Riverpod(keepAlive: true)
TodoRepository todoRepository(TodoRepositoryRef ref) {
  return TodoRepository(localDatabase: ref.watch(appDatabaseProvider));
}
