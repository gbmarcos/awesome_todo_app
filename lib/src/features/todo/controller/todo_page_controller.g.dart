// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredTodosHash() => r'7219c45f24a2537de7a2d56c5297f6e00af32300';

/// See also [filteredTodos].
@ProviderFor(filteredTodos)
final filteredTodosProvider = AutoDisposeProvider<List<AppTodo>>.internal(
  filteredTodos,
  name: r'filteredTodosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredTodosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredTodosRef = AutoDisposeProviderRef<List<AppTodo>>;
String _$uncompletedTodosCountHash() =>
    r'b67f83f4e64a0bb8595593bfcb22055dece49f7b';

/// See also [uncompletedTodosCount].
@ProviderFor(uncompletedTodosCount)
final uncompletedTodosCountProvider = AutoDisposeProvider<int>.internal(
  uncompletedTodosCount,
  name: r'uncompletedTodosCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$uncompletedTodosCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UncompletedTodosCountRef = AutoDisposeProviderRef<int>;
String _$currentTodoHash() => r'd6f71ffb86d68ab45803483186db8e3322d3ece2';

/// See also [currentTodo].
@ProviderFor(currentTodo)
final currentTodoProvider = AutoDisposeProvider<AppTodo>.internal(
  currentTodo,
  name: r'currentTodoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentTodoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentTodoRef = AutoDisposeProviderRef<AppTodo>;
String _$todoRepositoryHash() => r'8a7b7a4a6dee585fd9f3146819b67a9c02475896';

/// See also [todoRepository].
@ProviderFor(todoRepository)
final todoRepositoryProvider = Provider<TodoRepository>.internal(
  todoRepository,
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoRepositoryRef = ProviderRef<TodoRepository>;
String _$todoListHash() => r'7ec49025f4ff3b12716f08fe64633c8e72f1d7dc';

/// See also [TodoList].
@ProviderFor(TodoList)
final todoListProvider =
    AutoDisposeAsyncNotifierProvider<TodoList, List<AppTodo>>.internal(
  TodoList.new,
  name: r'todoListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoList = AutoDisposeAsyncNotifier<List<AppTodo>>;
String _$todoFilterHash() => r'10ab3fc669def9e912e43826a9936890b46821df';

/// See also [TodoFilter].
@ProviderFor(TodoFilter)
final todoFilterProvider =
    AutoDisposeNotifierProvider<TodoFilter, TodoListFilter>.internal(
  TodoFilter.new,
  name: r'todoFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoFilter = AutoDisposeNotifier<TodoListFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
