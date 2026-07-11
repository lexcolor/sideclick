// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedTasksTable extends CachedTasks
    with TableInfo<$CachedTasksTable, CachedTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<int> dueDate = GeneratedColumn<int>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    taskId,
    teamId,
    json,
    dueDate,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedTask> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
        _jsonMeta,
        json.isAcceptableOrUnknown(data['json']!, _jsonMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskId};
  @override
  CachedTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedTask(
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      json: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_date'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedTasksTable createAlias(String alias) {
    return $CachedTasksTable(attachedDatabase, alias);
  }
}

class CachedTask extends DataClass implements Insertable<CachedTask> {
  final String taskId;
  final String teamId;
  final String json;
  final int? dueDate;
  final DateTime cachedAt;
  const CachedTask({
    required this.taskId,
    required this.teamId,
    required this.json,
    this.dueDate,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['task_id'] = Variable<String>(taskId);
    map['team_id'] = Variable<String>(teamId);
    map['json'] = Variable<String>(json);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<int>(dueDate);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedTasksCompanion toCompanion(bool nullToAbsent) {
    return CachedTasksCompanion(
      taskId: Value(taskId),
      teamId: Value(teamId),
      json: Value(json),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedTask.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedTask(
      taskId: serializer.fromJson<String>(json['taskId']),
      teamId: serializer.fromJson<String>(json['teamId']),
      json: serializer.fromJson<String>(json['json']),
      dueDate: serializer.fromJson<int?>(json['dueDate']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<String>(taskId),
      'teamId': serializer.toJson<String>(teamId),
      'json': serializer.toJson<String>(json),
      'dueDate': serializer.toJson<int?>(dueDate),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedTask copyWith({
    String? taskId,
    String? teamId,
    String? json,
    Value<int?> dueDate = const Value.absent(),
    DateTime? cachedAt,
  }) => CachedTask(
    taskId: taskId ?? this.taskId,
    teamId: teamId ?? this.teamId,
    json: json ?? this.json,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedTask copyWithCompanion(CachedTasksCompanion data) {
    return CachedTask(
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      json: data.json.present ? data.json.value : this.json,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedTask(')
          ..write('taskId: $taskId, ')
          ..write('teamId: $teamId, ')
          ..write('json: $json, ')
          ..write('dueDate: $dueDate, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, teamId, json, dueDate, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedTask &&
          other.taskId == this.taskId &&
          other.teamId == this.teamId &&
          other.json == this.json &&
          other.dueDate == this.dueDate &&
          other.cachedAt == this.cachedAt);
}

class CachedTasksCompanion extends UpdateCompanion<CachedTask> {
  final Value<String> taskId;
  final Value<String> teamId;
  final Value<String> json;
  final Value<int?> dueDate;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedTasksCompanion({
    this.taskId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.json = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedTasksCompanion.insert({
    required String taskId,
    required String teamId,
    required String json,
    this.dueDate = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : taskId = Value(taskId),
       teamId = Value(teamId),
       json = Value(json),
       cachedAt = Value(cachedAt);
  static Insertable<CachedTask> custom({
    Expression<String>? taskId,
    Expression<String>? teamId,
    Expression<String>? json,
    Expression<int>? dueDate,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (teamId != null) 'team_id': teamId,
      if (json != null) 'json': json,
      if (dueDate != null) 'due_date': dueDate,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedTasksCompanion copyWith({
    Value<String>? taskId,
    Value<String>? teamId,
    Value<String>? json,
    Value<int?>? dueDate,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedTasksCompanion(
      taskId: taskId ?? this.taskId,
      teamId: teamId ?? this.teamId,
      json: json ?? this.json,
      dueDate: dueDate ?? this.dueDate,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<int>(dueDate.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedTasksCompanion(')
          ..write('taskId: $taskId, ')
          ..write('teamId: $teamId, ')
          ..write('json: $json, ')
          ..write('dueDate: $dueDate, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QueuedActionsTable extends QueuedActions
    with TableInfo<$QueuedActionsTable, QueuedAction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueuedActionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, taskId, payload, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'queued_actions';
  @override
  VerificationContext validateIntegrity(
    Insertable<QueuedAction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QueuedAction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QueuedAction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $QueuedActionsTable createAlias(String alias) {
    return $QueuedActionsTable(attachedDatabase, alias);
  }
}

class QueuedAction extends DataClass implements Insertable<QueuedAction> {
  final int id;
  final String type;
  final String taskId;
  final String payload;
  final DateTime createdAt;
  const QueuedAction({
    required this.id,
    required this.type,
    required this.taskId,
    required this.payload,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['task_id'] = Variable<String>(taskId);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QueuedActionsCompanion toCompanion(bool nullToAbsent) {
    return QueuedActionsCompanion(
      id: Value(id),
      type: Value(type),
      taskId: Value(taskId),
      payload: Value(payload),
      createdAt: Value(createdAt),
    );
  }

  factory QueuedAction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QueuedAction(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      taskId: serializer.fromJson<String>(json['taskId']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'taskId': serializer.toJson<String>(taskId),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  QueuedAction copyWith({
    int? id,
    String? type,
    String? taskId,
    String? payload,
    DateTime? createdAt,
  }) => QueuedAction(
    id: id ?? this.id,
    type: type ?? this.type,
    taskId: taskId ?? this.taskId,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
  );
  QueuedAction copyWithCompanion(QueuedActionsCompanion data) {
    return QueuedAction(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QueuedAction(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('taskId: $taskId, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, taskId, payload, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QueuedAction &&
          other.id == this.id &&
          other.type == this.type &&
          other.taskId == this.taskId &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt);
}

class QueuedActionsCompanion extends UpdateCompanion<QueuedAction> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> taskId;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  const QueuedActionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.taskId = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  QueuedActionsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String taskId,
    required String payload,
    required DateTime createdAt,
  }) : type = Value(type),
       taskId = Value(taskId),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<QueuedAction> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? taskId,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (taskId != null) 'task_id': taskId,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  QueuedActionsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? taskId,
    Value<String>? payload,
    Value<DateTime>? createdAt,
  }) {
    return QueuedActionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      taskId: taskId ?? this.taskId,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueuedActionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('taskId: $taskId, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedTasksTable cachedTasks = $CachedTasksTable(this);
  late final $QueuedActionsTable queuedActions = $QueuedActionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedTasks,
    queuedActions,
  ];
}

typedef $$CachedTasksTableCreateCompanionBuilder =
    CachedTasksCompanion Function({
      required String taskId,
      required String teamId,
      required String json,
      Value<int?> dueDate,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedTasksTableUpdateCompanionBuilder =
    CachedTasksCompanion Function({
      Value<String> taskId,
      Value<String> teamId,
      Value<String> json,
      Value<int?> dueDate,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$CachedTasksTableFilterComposer
    extends Composer<_$AppDatabase, $CachedTasksTable> {
  $$CachedTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedTasksTable> {
  $$CachedTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedTasksTable> {
  $$CachedTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => column);

  GeneratedColumn<int> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedTasksTable,
          CachedTask,
          $$CachedTasksTableFilterComposer,
          $$CachedTasksTableOrderingComposer,
          $$CachedTasksTableAnnotationComposer,
          $$CachedTasksTableCreateCompanionBuilder,
          $$CachedTasksTableUpdateCompanionBuilder,
          (
            CachedTask,
            BaseReferences<_$AppDatabase, $CachedTasksTable, CachedTask>,
          ),
          CachedTask,
          PrefetchHooks Function()
        > {
  $$CachedTasksTableTableManager(_$AppDatabase db, $CachedTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> taskId = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<int?> dueDate = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedTasksCompanion(
                taskId: taskId,
                teamId: teamId,
                json: json,
                dueDate: dueDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String taskId,
                required String teamId,
                required String json,
                Value<int?> dueDate = const Value.absent(),
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedTasksCompanion.insert(
                taskId: taskId,
                teamId: teamId,
                json: json,
                dueDate: dueDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedTasksTable,
      CachedTask,
      $$CachedTasksTableFilterComposer,
      $$CachedTasksTableOrderingComposer,
      $$CachedTasksTableAnnotationComposer,
      $$CachedTasksTableCreateCompanionBuilder,
      $$CachedTasksTableUpdateCompanionBuilder,
      (
        CachedTask,
        BaseReferences<_$AppDatabase, $CachedTasksTable, CachedTask>,
      ),
      CachedTask,
      PrefetchHooks Function()
    >;
typedef $$QueuedActionsTableCreateCompanionBuilder =
    QueuedActionsCompanion Function({
      Value<int> id,
      required String type,
      required String taskId,
      required String payload,
      required DateTime createdAt,
    });
typedef $$QueuedActionsTableUpdateCompanionBuilder =
    QueuedActionsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> taskId,
      Value<String> payload,
      Value<DateTime> createdAt,
    });

class $$QueuedActionsTableFilterComposer
    extends Composer<_$AppDatabase, $QueuedActionsTable> {
  $$QueuedActionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QueuedActionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QueuedActionsTable> {
  $$QueuedActionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QueuedActionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QueuedActionsTable> {
  $$QueuedActionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$QueuedActionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QueuedActionsTable,
          QueuedAction,
          $$QueuedActionsTableFilterComposer,
          $$QueuedActionsTableOrderingComposer,
          $$QueuedActionsTableAnnotationComposer,
          $$QueuedActionsTableCreateCompanionBuilder,
          $$QueuedActionsTableUpdateCompanionBuilder,
          (
            QueuedAction,
            BaseReferences<_$AppDatabase, $QueuedActionsTable, QueuedAction>,
          ),
          QueuedAction,
          PrefetchHooks Function()
        > {
  $$QueuedActionsTableTableManager(_$AppDatabase db, $QueuedActionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QueuedActionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QueuedActionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QueuedActionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> taskId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => QueuedActionsCompanion(
                id: id,
                type: type,
                taskId: taskId,
                payload: payload,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String taskId,
                required String payload,
                required DateTime createdAt,
              }) => QueuedActionsCompanion.insert(
                id: id,
                type: type,
                taskId: taskId,
                payload: payload,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QueuedActionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QueuedActionsTable,
      QueuedAction,
      $$QueuedActionsTableFilterComposer,
      $$QueuedActionsTableOrderingComposer,
      $$QueuedActionsTableAnnotationComposer,
      $$QueuedActionsTableCreateCompanionBuilder,
      $$QueuedActionsTableUpdateCompanionBuilder,
      (
        QueuedAction,
        BaseReferences<_$AppDatabase, $QueuedActionsTable, QueuedAction>,
      ),
      QueuedAction,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedTasksTableTableManager get cachedTasks =>
      $$CachedTasksTableTableManager(_db, _db.cachedTasks);
  $$QueuedActionsTableTableManager get queuedActions =>
      $$QueuedActionsTableTableManager(_db, _db.queuedActions);
}
