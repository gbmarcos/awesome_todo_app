import 'package:awesome_todo_app/src/core/data/drift_local_database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

/// Provides a single instance of [AppDatabase] using Riverpod.
///
/// - **KeepAlive**: Ensures the database instance stays in memory for the app's lifetime.
/// - Simplifies access to the local database throughout the application.

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}
