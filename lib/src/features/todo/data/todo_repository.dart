import 'package:awesome_todo_app/src/core/data/drift_local_database/database.dart';

/// [TodoRepository] is a service layer that handles operations for managing
/// to-do items stored in a local database. It acts as an abstraction over
/// the [AppDatabase] and provides methods for fetching, creating, updating,
/// and deleting tasks.
///
/// This repository ensures a clear separation of concerns by encapsulating
/// database operations and exposing a simple interface for interacting with
/// to-do data.
class TodoRepository {
  /// The local database instance used for performing CRUD operations.
  final AppDatabase _localDatabase;

  /// Creates a [TodoRepository] with the required [AppDatabase] instance.
  TodoRepository({
    required AppDatabase localDatabase,
  }) : _localDatabase = localDatabase;

  /// Fetches the complete list of to-do items from the database.
  ///
  /// Returns a [Future] containing a list of [AppTodo].
  /// Throws an [Exception] if the fetch operation fails.
  Future<List<AppTodo>> fetchTodoList() async {
    try {
      return _localDatabase.select(_localDatabase.appTodos).get();
    } on Exception {
      throw Exception('Failed to fetch to-do list');
    }
  }

  /// Retrieves a specific to-do item by its unique [id].
  ///
  /// Returns a [Future] containing the [AppTodo] if found, or `null` if no
  /// matching to-do item exists.
  /// Throws an [Exception] if the retrieval operation fails.
  Future<AppTodo?> getTodoById(int id) async {
    try {
      return (_localDatabase.select(_localDatabase.appTodos)
            ..where(
              (tbl) => tbl.id.equals(id),
            ))
          .getSingleOrNull();
    } on Exception {
      throw Exception('Failed to retrieve to-do item');
    }
  }

  /// Creates a new to-do item with the provided [description].
  ///
  /// Returns a [Future] containing the newly created to-do item's ID.
  /// Throws an [Exception] if the insertion operation fails.
  Future<int> createTodo(String description) async {
    try {
      return _localDatabase.into(_localDatabase.appTodos).insert(
            AppTodosCompanion.insert(description: description),
          );
    } on Exception {
      throw Exception('Failed to insert new to-do item');
    }
  }

  /// Updates an existing to-do item in the database.
  ///
  /// Takes an [AppTodo] object representing the updated to-do item.
  /// Returns a [Future] containing a boolean indicating whether the update
  /// was successful.
  /// Throws an [Exception] if the update operation fails.
  Future<bool> updateTodo(AppTodo todo) async {
    try {
      return _localDatabase.update(_localDatabase.appTodos).replace(todo);
    } on Exception {
      throw Exception('Failed to update to-do item');
    }
  }

  /// Deletes an existing to-do item from the database.
  ///
  /// Takes an [AppTodo] object representing the to-do item to be deleted.
  /// Returns a [Future] containing the number of rows affected.
  /// Throws an [Exception] if the delete operation fails.
  Future<int> deleteTodo(AppTodo todo) async {
    try {
      return _localDatabase.delete(_localDatabase.appTodos).delete(todo);
    } on Exception {
      throw Exception('Failed to delete to-do item');
    }
  }
}
