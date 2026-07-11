import '../core/api/clickup_client.dart';
import '../core/api/endpoints.dart';
import '../core/result.dart';
import '../models/time_entry.dart';

/// Wraps ClickUp time tracking: start/stop the timer, read the running entry,
/// and list/aggregate entries for a task.
class TimeRepository {
  final ClickUpClient _client;

  TimeRepository(this._client);

  /// Returns the currently running time entry, or null if none is running.
  Future<Result<TimeEntry?>> current(String teamId) async {
    final res = await _client.get(Endpoints.currentTimer(teamId));
    return res.when(
      success: (data) {
        final entry = (data as Map)['data'];
        if (entry == null || (entry is Map && entry.isEmpty)) {
          return const Success<TimeEntry?>(null);
        }
        return Success<TimeEntry?>(
            TimeEntry.fromJson(entry as Map<String, dynamic>));
      },
      failure: (err) => Failure(err),
    );
  }

  Future<Result<TimeEntry>> start(String teamId, String taskId,
      {String? description}) async {
    final res = await _client.post(
      Endpoints.startTimer(teamId),
      data: {
        'tid': taskId,
        'description': ?description,
      },
    );
    return res.when(
      success: (data) => Success(
          TimeEntry.fromJson((data as Map)['data'] as Map<String, dynamic>)),
      failure: (err) => Failure(err),
    );
  }

  Future<Result<TimeEntry?>> stop(String teamId) async {
    final res = await _client.post(Endpoints.stopTimer(teamId));
    return res.when(
      success: (data) {
        final entry = (data as Map)['data'];
        if (entry == null) return const Success<TimeEntry?>(null);
        return Success<TimeEntry?>(
            TimeEntry.fromJson(entry as Map<String, dynamic>));
      },
      failure: (err) => Failure(err),
    );
  }

  /// Total tracked milliseconds for a task, summed from its time entries.
  Future<Result<List<TimeEntry>>> entriesForTask(
      String teamId, String taskId) async {
    final res = await _client.get(
      Endpoints.timeEntries(teamId),
      query: {'task_id': taskId},
    );
    return res.when(
      success: (data) {
        final list = ((data as Map)['data'] as List? ?? [])
            .map((e) => TimeEntry.fromJson(e as Map<String, dynamic>))
            .toList();
        return Success(list);
      },
      failure: (err) => Failure(err),
    );
  }
}
