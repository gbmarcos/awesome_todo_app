import 'package:awesome_todo_app/src/core/data/drift_local_database/database.dart';

class TodoRepository {
  final AppDatabase _localDatabase;

  TodoRepository({
    required AppDatabase localDatabase,
  }) : _localDatabase = localDatabase;

  Future<List<AppTodo>> fetchTodoList() async {
    try {
      return _localDatabase.select(_localDatabase.appTodos).get();
    } on Exception {
      throw Exception('Failed todo fetching');
    }
  }

  Future<AppTodo?> getTodoById(int id) async {
    try {
      return (_localDatabase.select(_localDatabase.appTodos)
            ..where(
              (tbl) => tbl.id.equals(id),
            ))
          .getSingleOrNull();
    } on Exception {
      throw Exception('Failed todo getting');
    }
  }

  Future<int> createTodo(String description) async {
    try {
      return _localDatabase.into(_localDatabase.appTodos).insert(
            AppTodosCompanion.insert(description: description),
          );
    } on Exception {
      throw Exception('Failed todo insertion');
    }
  }

  Future<bool> updateTodo(AppTodo todo) async {
    try {
      return _localDatabase.update(_localDatabase.appTodos).replace(todo);
    } on Exception {
      throw Exception('Failed todo updating');
    }
  }

  Future<int> deleteTodo(AppTodo todo) async {
    try {
      return _localDatabase.delete(_localDatabase.appTodos).delete(todo);
    } on Exception {
      throw Exception('Failed todo removing');
    }
  }
}
