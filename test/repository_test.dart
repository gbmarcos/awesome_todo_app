/// Unit tests for the `TodoRepository` class.
///
/// These tests validate the core CRUD functionalities of the repository,
/// which interacts with the local Drift database. The database is instantiated
/// in memory for testing purposes to ensure isolation and consistency.
///
/// The repository provides methods to create, update, delete, and fetch todos,
/// and these tests ensure the correctness of each functionality.
///
/// Author: Marcos Antonio Montes de Oca Robles
/// Last Updated: December 2024
import 'package:awesome_todo_app/src/core/data/drift_local_database/database.dart';
import 'package:awesome_todo_app/src/features/todo/data/todo_repository.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database; // The in-memory Drift database instance
  late TodoRepository repository; // The repository under test

  setUp(() {
    // Initialize the in-memory database and repository before each test.
    database = AppDatabase(DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ));
    repository = TodoRepository(localDatabase: database);
  });

  tearDown(() async {
    // Close the database connection after each test.
    await database.close();
  });

  test('to-dos can be created', () async {
    // Test case: Ensures that a to-do can be successfully created
    // and retrieved by its ID.
    final id = await repository.createTodo('Do something today');
    final todo = await repository.getTodoById(id);

    // Verify the description of the created to-do matches the input.
    expect(todo?.description ?? 'Not Found', 'Do something today');
  });

  test('to-dos can be updated', () async {
    // Test case: Ensures that a to-do can be created and then updated.

    // Create a new to-do.
    final id = await repository.createTodo('Do something today');
    AppTodo? todo = await repository.getTodoById(id);

    // Verify the initial description.
    expect(todo?.description ?? 'Not Found', 'Do something today');

    // Update the to-do with a new description.
    await repository.updateTodo(
      todo!.copyWith(description: 'Do something tomorrow'),
    );
    todo = await repository.getTodoById(id);

    // Verify the updated description.
    expect(todo?.description ?? 'Not Found', 'Do something tomorrow');
  });

  test('to-dos can be deleted', () async {
    // Test case: Ensures that a to-do can be created and then deleted.

    // Create a new to-do.
    final id = await repository.createTodo('Do something today');
    AppTodo? todo = await repository.getTodoById(id);

    // Verify the to-do exists.
    expect(todo?.description ?? 'Not Found', 'Do something today');

    // Delete the to-do.
    await repository.deleteTodo(todo!);

    // Attempt to retrieve the deleted to-do.
    todo = await repository.getTodoById(id);

    // Verify the to-do no longer exists.
    expect(todo?.description ?? 'Not Found', 'Not Found');
  });

  test('to-dos can be recovered', () async {
    // Test case: Ensures that multiple todos can be created and retrieved
    // as a list.

    final Iterable todoStringList = [
      'Do something today 1',
      'Do something today 2',
      'Do something today 3',
    ];

    // Create multiple todos.
    for (final str in todoStringList) {
      await repository.createTodo(str);
    }

    // Retrieve all todos.
    final todoList = await repository.fetchTodoList();

    // Verify the retrieved todos match the created ones.
    expect(todoList.map((e) => e.description), todoStringList);
  });
}
