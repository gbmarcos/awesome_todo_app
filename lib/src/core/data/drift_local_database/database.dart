import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// Represents the schema of the `AppTodos` table, which stores the To-Do items.
class AppTodos extends Table {
  /// The primary key of the table, which is auto-incremented.
  IntColumn get id => integer().autoIncrement()();

  /// A text field for the description of the To-Do item.
  TextColumn get description => text()();

  /// A boolean field indicating whether the To-Do item is completed.
  /// Defaults to `false`.
  BoolColumn get completed => boolean().clientDefault(() => false)();
}

/// The main database class for managing local persistence using Drift.
/// This database includes the `AppTodos` table.
@DriftDatabase(tables: [AppTodos])
class AppDatabase extends _$AppDatabase {
  /// Constructor for the database. If no [QueryExecutor] is provided,
  /// it defaults to an in-app SQLite database.
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  /// The schema version of the database. Used for migration handling.
  @override
  int get schemaVersion => 1;

  /// Opens a connection to the SQLite database.
  /// The database file is named `my_database`.
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'my_database');
  }
}
