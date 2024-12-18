// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AppTodosTable extends AppTodos with TableInfo<$AppTodosTable, AppTodo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppTodosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      clientDefault: () => false);
  @override
  List<GeneratedColumn> get $columns => [id, description, completed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_todos';
  @override
  VerificationContext validateIntegrity(Insertable<AppTodo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppTodo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppTodo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
    );
  }

  @override
  $AppTodosTable createAlias(String alias) {
    return $AppTodosTable(attachedDatabase, alias);
  }
}

class AppTodo extends DataClass implements Insertable<AppTodo> {
  final int id;
  final String description;
  final bool completed;
  const AppTodo(
      {required this.id, required this.description, required this.completed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['description'] = Variable<String>(description);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  AppTodosCompanion toCompanion(bool nullToAbsent) {
    return AppTodosCompanion(
      id: Value(id),
      description: Value(description),
      completed: Value(completed),
    );
  }

  factory AppTodo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppTodo(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  AppTodo copyWith({int? id, String? description, bool? completed}) => AppTodo(
        id: id ?? this.id,
        description: description ?? this.description,
        completed: completed ?? this.completed,
      );
  AppTodo copyWithCompanion(AppTodosCompanion data) {
    return AppTodo(
      id: data.id.present ? data.id.value : this.id,
      description:
          data.description.present ? data.description.value : this.description,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppTodo(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, description, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppTodo &&
          other.id == this.id &&
          other.description == this.description &&
          other.completed == this.completed);
}

class AppTodosCompanion extends UpdateCompanion<AppTodo> {
  final Value<int> id;
  final Value<String> description;
  final Value<bool> completed;
  const AppTodosCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.completed = const Value.absent(),
  });
  AppTodosCompanion.insert({
    this.id = const Value.absent(),
    required String description,
    this.completed = const Value.absent(),
  }) : description = Value(description);
  static Insertable<AppTodo> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (completed != null) 'completed': completed,
    });
  }

  AppTodosCompanion copyWith(
      {Value<int>? id, Value<String>? description, Value<bool>? completed}) {
    return AppTodosCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppTodosCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppTodosTable appTodos = $AppTodosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [appTodos];
}

typedef $$AppTodosTableCreateCompanionBuilder = AppTodosCompanion Function({
  Value<int> id,
  required String description,
  Value<bool> completed,
});
typedef $$AppTodosTableUpdateCompanionBuilder = AppTodosCompanion Function({
  Value<int> id,
  Value<String> description,
  Value<bool> completed,
});

class $$AppTodosTableFilterComposer
    extends Composer<_$AppDatabase, $AppTodosTable> {
  $$AppTodosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));
}

class $$AppTodosTableOrderingComposer
    extends Composer<_$AppDatabase, $AppTodosTable> {
  $$AppTodosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));
}

class $$AppTodosTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppTodosTable> {
  $$AppTodosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);
}

class $$AppTodosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppTodosTable,
    AppTodo,
    $$AppTodosTableFilterComposer,
    $$AppTodosTableOrderingComposer,
    $$AppTodosTableAnnotationComposer,
    $$AppTodosTableCreateCompanionBuilder,
    $$AppTodosTableUpdateCompanionBuilder,
    (AppTodo, BaseReferences<_$AppDatabase, $AppTodosTable, AppTodo>),
    AppTodo,
    PrefetchHooks Function()> {
  $$AppTodosTableTableManager(_$AppDatabase db, $AppTodosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppTodosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppTodosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppTodosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> completed = const Value.absent(),
          }) =>
              AppTodosCompanion(
            id: id,
            description: description,
            completed: completed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String description,
            Value<bool> completed = const Value.absent(),
          }) =>
              AppTodosCompanion.insert(
            id: id,
            description: description,
            completed: completed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppTodosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppTodosTable,
    AppTodo,
    $$AppTodosTableFilterComposer,
    $$AppTodosTableOrderingComposer,
    $$AppTodosTableAnnotationComposer,
    $$AppTodosTableCreateCompanionBuilder,
    $$AppTodosTableUpdateCompanionBuilder,
    (AppTodo, BaseReferences<_$AppDatabase, $AppTodosTable, AppTodo>),
    AppTodo,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppTodosTableTableManager get appTodos =>
      $$AppTodosTableTableManager(_db, _db.appTodos);
}
