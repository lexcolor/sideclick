import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Cached tasks, stored as raw JSON keyed by (teamId, taskId) so the list can
/// render instantly and offline.
class CachedTasks extends Table {
  TextColumn get taskId => text()();
  TextColumn get teamId => text()();
  TextColumn get json => text()();
  IntColumn get dueDate => integer().nullable()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {taskId};
}

/// Offline mutations awaiting sync. `payload` is JSON specific to [type].
class QueuedActions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()(); // e.g. 'status', 'comment', 'time_start'
  TextColumn get taskId => text()();
  TextColumn get payload => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [CachedTasks, QueuedActions])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  @override
  int get schemaVersion => 1;

  Future<List<CachedTask>> tasksForTeam(String teamId) {
    return (select(cachedTasks)..where((t) => t.teamId.equals(teamId))).get();
  }

  Future<void> replaceTeamTasks(
      String teamId, List<CachedTasksCompanion> rows) async {
    await transaction(() async {
      await (delete(cachedTasks)..where((t) => t.teamId.equals(teamId))).go();
      await batch((b) => b.insertAll(cachedTasks, rows));
    });
  }

  Future<int> enqueue(QueuedActionsCompanion action) =>
      into(queuedActions).insert(action);

  Future<List<QueuedAction>> pendingActions() =>
      (select(queuedActions)..orderBy([(a) => OrderingTerm(expression: a.id)]))
          .get();

  Future<void> removeAction(int id) =>
      (delete(queuedActions)..where((a) => a.id.equals(id))).go();
}

LazyDatabase _open() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'sideclick.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
