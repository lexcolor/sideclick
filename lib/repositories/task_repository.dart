import '../core/api/clickup_client.dart';
import '../core/api/endpoints.dart';
import '../core/result.dart';
import '../models/task.dart';

/// Fetches the authenticated user's assigned tasks across a workspace, and
/// performs task mutations (status change).
class TaskRepository {
  final ClickUpClient _client;

  TaskRepository(this._client);

  /// Fetches all tasks assigned to [userId] in [teamId], paging until the API
  /// returns an incomplete page. [includeClosed] controls whether closed tasks
  /// are returned.
  /// Cache of space id -> name, so we only fetch the team's spaces once per
  /// team rather than on every refresh.
  final Map<String, Map<String, String>> _spaceNamesByTeam = {};

  Future<Result<List<Task>>> myTasks({
    required String teamId,
    required int userId,
    bool includeClosed = false,
    bool subtasks = true,
  }) async {
    final spaceNames = await _spaceNames(teamId);
    final all = <Task>[];
    var page = 0;
    while (true) {
      final res = await _client.get(
        Endpoints.teamTasks(teamId),
        query: {
          'assignees[]': [userId.toString()],
          'include_closed': includeClosed,
          'subtasks': subtasks,
          'order_by': 'due_date',
          'page': page,
        },
      );

      final pageResult = res.when(
        success: (data) {
          final tasks = ((data as Map)['tasks'] as List)
              .map((t) => Task.fromJson(t as Map<String, dynamic>))
              .toList();
          return Success<List<Task>>(tasks);
        },
        failure: (err) => Failure<List<Task>>(err),
      );

      if (pageResult is Failure<List<Task>>) {
        // If we already have some pages, return what we have; else surface error.
        if (all.isNotEmpty) break;
        return pageResult;
      }

      final tasks = (pageResult as Success<List<Task>>).value;
      all.addAll(tasks);
      // ClickUp returns up to 100 per page; a short page means we're done.
      if (tasks.length < 100) break;
      page++;
      // Safety cap to avoid runaway paging.
      if (page > 50) break;
    }

    // The task-list endpoint only gives space ids; resolve names for display.
    final resolved = [
      for (final t in all)
        if (t.space != null && spaceNames.containsKey(t.space!.id))
          t.copyWith(
              space: t.space!.copyWith(name: spaceNames[t.space!.id]))
        else
          t
    ];
    return Success(resolved);
  }

  /// Returns a map of space id -> name for [teamId], fetched once and cached.
  /// On failure, returns an empty map (tasks simply show no project label).
  Future<Map<String, String>> _spaceNames(String teamId) async {
    final cached = _spaceNamesByTeam[teamId];
    if (cached != null) return cached;

    final res = await _client.get(
      Endpoints.teamSpaces(teamId),
      query: {'archived': false},
    );
    final map = res.when(
      success: (data) {
        final spaces = (data as Map)['spaces'];
        final out = <String, String>{};
        if (spaces is List) {
          for (final s in spaces) {
            final id = s['id']?.toString();
            final name = s['name']?.toString();
            if (id != null && name != null) out[id] = name;
          }
        }
        return out;
      },
      failure: (_) => <String, String>{},
    );
    if (map.isNotEmpty) _spaceNamesByTeam[teamId] = map;
    return map;
  }

  Future<Result<Task>> task(String taskId) async {
    final res = await _client.get(Endpoints.task(taskId));
    return res.when(
      success: (data) =>
          Success(Task.fromJson(data as Map<String, dynamic>)),
      failure: (err) => Failure(err),
    );
  }

  /// Fetches the ordered set of statuses configured on [listId], including any
  /// workspace-specific custom statuses (ClickUp defines statuses per List, not
  /// globally). Falling back to a generic set is the caller's responsibility.
  Future<Result<List<TaskStatus>>> listStatuses(String listId) async {
    final res = await _client.get(Endpoints.list(listId));
    return res.when(
      success: (data) {
        final statuses = (data as Map)['statuses'];
        if (statuses is! List) return const Success(<TaskStatus>[]);
        final list = statuses
            .map((s) => TaskStatus.fromJson(s as Map<String, dynamic>))
            .toList()
          ..sort((a, b) {
            final ai = a.orderIndex;
            final bi = b.orderIndex;
            if (ai is num && bi is num) return ai.compareTo(bi);
            return 0;
          });
        return Success(list);
      },
      failure: (err) => Failure(err),
    );
  }

  /// Updates a task's status by its status name (as ClickUp expects).
  Future<Result<Task>> updateStatus(String taskId, String status) async {
    final res = await _client.put(
      Endpoints.task(taskId),
      data: {'status': status},
    );
    return res.when(
      success: (data) =>
          Success(Task.fromJson(data as Map<String, dynamic>)),
      failure: (err) => Failure(err),
    );
  }
}
