import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/db/app_database.dart';
import '../core/result.dart';
import '../models/task.dart';
import '../utils/urgency.dart';
import 'auth_provider.dart';
import 'core_providers.dart';

enum TaskSort { dueDateAsc, dueDateDesc, priority, name }

class TaskFilter {
  final bool includeClosed;
  final bool onlyOverdue;
  final bool onlyDueThisWeek;
  final bool groupByList;
  final TaskSort sort;

  /// Status names (lower-cased) to show. An empty set means "show all statuses".
  final Set<String> selectedStatuses;

  const TaskFilter({
    this.includeClosed = false,
    this.onlyOverdue = false,
    this.onlyDueThisWeek = false,
    this.groupByList = false,
    this.sort = TaskSort.dueDateAsc,
    this.selectedStatuses = const {},
  });

  TaskFilter copyWith({
    bool? includeClosed,
    bool? onlyOverdue,
    bool? onlyDueThisWeek,
    bool? groupByList,
    TaskSort? sort,
    Set<String>? selectedStatuses,
  }) =>
      TaskFilter(
        includeClosed: includeClosed ?? this.includeClosed,
        onlyOverdue: onlyOverdue ?? this.onlyOverdue,
        onlyDueThisWeek: onlyDueThisWeek ?? this.onlyDueThisWeek,
        groupByList: groupByList ?? this.groupByList,
        sort: sort ?? this.sort,
        selectedStatuses: selectedStatuses ?? this.selectedStatuses,
      );
}

/// Holds the active task filter and persists the (non-secret) status selection
/// so it survives app restarts.
class TaskFilterController extends StateNotifier<TaskFilter> {
  final Ref _ref;

  TaskFilterController(this._ref) : super(const TaskFilter()) {
    _hydrate();
  }

  Future<void> _hydrate() async {
    final statuses = await _ref.read(secureStoreProvider).readStatusFilter();
    if (statuses.isNotEmpty) {
      state = state.copyWith(selectedStatuses: statuses);
    }
  }

  /// Completes when the most recent persistence write has flushed. Exposed so
  /// tests can await it deterministically instead of racing a timer.
  Future<void> get settled => _lastWrite ?? Future<void>.value();
  Future<void>? _lastWrite;

  /// Replaces the whole filter (used by the filter bar).
  void set(TaskFilter filter) {
    final statusesChanged =
        !_setEquals(filter.selectedStatuses, state.selectedStatuses);
    state = filter;
    if (statusesChanged) {
      _lastWrite = _ref
          .read(secureStoreProvider)
          .writeStatusFilter(filter.selectedStatuses);
    }
  }

  bool _setEquals(Set<String> a, Set<String> b) =>
      a.length == b.length && a.containsAll(b);
}

final taskFilterProvider =
    StateNotifierProvider<TaskFilterController, TaskFilter>(
  (ref) => TaskFilterController(ref),
);

class TasksState {
  final bool loading;
  final List<Task> tasks;
  final AppError? error;
  final DateTime? lastLoaded;

  /// True when the currently shown tasks came from the local cache and a network
  /// refresh has not yet succeeded (used to show an "offline" banner).
  final bool fromCache;

  const TasksState({
    this.loading = false,
    this.tasks = const [],
    this.error,
    this.lastLoaded,
    this.fromCache = false,
  });

  TasksState copyWith({
    bool? loading,
    List<Task>? tasks,
    AppError? error,
    DateTime? lastLoaded,
    bool? fromCache,
    bool clearError = false,
  }) =>
      TasksState(
        loading: loading ?? this.loading,
        tasks: tasks ?? this.tasks,
        error: clearError ? null : (error ?? this.error),
        lastLoaded: lastLoaded ?? this.lastLoaded,
        fromCache: fromCache ?? this.fromCache,
      );
}

class TasksController extends StateNotifier<TasksState> {
  final Ref _ref;

  TasksController(this._ref) : super(const TasksState());

  /// Loads cached tasks for the selected team (instant, offline-friendly), then
  /// triggers a network refresh (stale-while-revalidate).
  Future<void> load() async {
    final teamId = _ref.read(authControllerProvider).selectedTeamId;
    if (teamId == null) return;
    final db = _ref.read(appDatabaseProvider);
    final cached = await db.tasksForTeam(teamId);
    if (cached.isNotEmpty) {
      final tasks = cached
          .map((row) =>
              Task.fromJson(jsonDecode(row.json) as Map<String, dynamic>))
          .toList();
      state = state.copyWith(tasks: tasks, fromCache: true);
    }
    await refresh();
  }

  Future<void> refresh() async {
    final auth = _ref.read(authControllerProvider);
    final teamId = auth.selectedTeamId;
    final userId = auth.user?.id;
    if (teamId == null || userId == null) return;

    state = state.copyWith(loading: true, clearError: true);
    final filter = _ref.read(taskFilterProvider);
    final repo = _ref.read(taskRepositoryProvider);
    final res = await repo.myTasks(
      teamId: teamId,
      userId: userId,
      includeClosed: filter.includeClosed,
    );
    await res.when(
      success: (tasks) async {
        state = state.copyWith(
          loading: false,
          tasks: tasks,
          lastLoaded: DateTime.now(),
          fromCache: false,
        );
        await _cacheTasks(teamId, tasks);
      },
      failure: (err) async {
        // Keep any cached tasks visible; just surface the error.
        state = state.copyWith(loading: false, error: err);
      },
    );
  }

  Future<void> _cacheTasks(String teamId, List<Task> tasks) async {
    final db = _ref.read(appDatabaseProvider);
    final now = DateTime.now();
    final rows = [
      for (final t in tasks)
        CachedTasksCompanion.insert(
          taskId: t.id,
          teamId: teamId,
          json: jsonEncode(t.toJson()),
          dueDate: Value(t.dueDate),
          cachedAt: now,
        ),
    ];
    await db.replaceTeamTasks(teamId, rows);
  }

  /// Optimistically applies a status change, then confirms with the API.
  ///
  /// Returns the [AppError] if the change was hard-rejected (and rolled back)
  /// so the caller can surface it — otherwise null, whether the update was
  /// confirmed by the server or just queued for later sync while offline.
  Future<AppError?> changeStatus(Task task, String newStatus) async {
    final updated = [
      for (final t in state.tasks)
        if (t.id == task.id)
          t.copyWith(status: TaskStatus(status: newStatus))
        else
          t
    ];
    state = state.copyWith(tasks: updated);

    final repo = _ref.read(taskRepositoryProvider);
    final res = await repo.updateStatus(task.id, newStatus);
    return await res.when(
      success: (serverTask) async {
        state = state.copyWith(tasks: [
          for (final t in state.tasks)
            if (t.id == serverTask.id) serverTask else t
        ]);
        return null;
      },
      failure: (err) async {
        if (err.kind == AppErrorKind.network) {
          // Offline: keep the optimistic change and queue it for later sync.
          final db = _ref.read(appDatabaseProvider);
          await db.enqueue(QueuedActionsCompanion.insert(
            type: 'status',
            taskId: task.id,
            payload: jsonEncode({'status': newStatus}),
            createdAt: DateTime.now(),
          ));
          return null;
        }
        // Hard failure: roll back the optimistic change.
        state = state.copyWith(tasks: [
          for (final t in state.tasks) if (t.id == task.id) task else t
        ], error: err);
        return err;
      },
    );
  }
}

final tasksControllerProvider =
    StateNotifierProvider<TasksController, TasksState>(
  (ref) => TasksController(ref),
);

/// The real, ordered status set configured on a List (including any
/// workspace-specific custom statuses), used to populate the status-change
/// sheet instead of a hardcoded guess.
final listStatusesProvider =
    FutureProvider.family<List<TaskStatus>, String>((ref, listId) async {
  final res = await ref.watch(taskRepositoryProvider).listStatuses(listId);
  return res.when(success: (s) => s, failure: (e) => throw e);
});

/// Applies the active filter + sort to the loaded tasks for display.
final visibleTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksControllerProvider).tasks;
  final filter = ref.watch(taskFilterProvider);
  final now = DateTime.now();

  var list = tasks.where((t) {
    final u = urgencyForDueDate(t.dueDate, now: now);
    if (filter.onlyOverdue && u != Urgency.overdue) return false;
    if (filter.onlyDueThisWeek &&
        !(u == Urgency.soon || u == Urgency.overdue)) {
      return false;
    }
    if (filter.selectedStatuses.isNotEmpty) {
      final s = t.status?.status.toLowerCase();
      if (s == null || !filter.selectedStatuses.contains(s)) return false;
    }
    return true;
  }).toList();

  int priorityRank(Task t) {
    switch (t.priority?.priority) {
      case 'urgent':
        return 0;
      case 'high':
        return 1;
      case 'normal':
        return 2;
      case 'low':
        return 3;
      default:
        return 4;
    }
  }

  int dueCompare(Task a, Task b, {bool asc = true}) {
    final ad = a.dueDate;
    final bd = b.dueDate;
    // Nulls last.
    if (ad == null && bd == null) return 0;
    if (ad == null) return 1;
    if (bd == null) return -1;
    return asc ? ad.compareTo(bd) : bd.compareTo(ad);
  }

  switch (filter.sort) {
    case TaskSort.dueDateAsc:
      list.sort((a, b) => dueCompare(a, b, asc: true));
      break;
    case TaskSort.dueDateDesc:
      list.sort((a, b) => dueCompare(a, b, asc: false));
      break;
    case TaskSort.priority:
      list.sort((a, b) => priorityRank(a).compareTo(priorityRank(b)));
      break;
    case TaskSort.name:
      list.sort((a, b) =>
          a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      break;
  }

  return list;
});

/// A status option available for filtering, derived from the loaded tasks.
class StatusOption {
  /// Lower-cased status key used for matching/selection.
  final String key;

  /// Display label (original casing from ClickUp).
  final String label;

  /// Hex color string from ClickUp (e.g. "#d3d3d3"), if any.
  final String? color;

  const StatusOption(this.key, this.label, this.color);
}

/// The distinct set of statuses present in the currently loaded tasks, sorted
/// by label. Used to populate the multi-select status filter.
final availableStatusesProvider = Provider<List<StatusOption>>((ref) {
  final tasks = ref.watch(tasksControllerProvider).tasks;
  final byKey = <String, StatusOption>{};
  for (final t in tasks) {
    final s = t.status;
    if (s == null) continue;
    final key = s.status.toLowerCase();
    byKey.putIfAbsent(key, () => StatusOption(key, s.status, s.color));
  }
  final options = byKey.values.toList()
    ..sort((a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()));
  return options;
});
