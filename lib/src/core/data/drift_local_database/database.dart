import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class AppTodos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text()();

  BoolColumn get completed => boolean().clientDefault(() => false)();
}

@DriftDatabase(tables: [AppTodos])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor?  e]) : super(e??_openConnection());

  @override
  int get schemaVersion => 1;
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'my_database');
  }
}
