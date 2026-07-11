import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/result.dart';
import '../models/attachment.dart';
import '../models/comment.dart';
import '../models/task.dart';
import '../models/time_entry.dart';
import 'auth_provider.dart';
import 'core_providers.dart';

/// Full task detail (re-fetched fresh so we get description, etc.).
final taskDetailProvider =
    FutureProvider.family<Task, String>((ref, taskId) async {
  final res = await ref.watch(taskRepositoryProvider).task(taskId);
  return res.when(
    success: (t) => t,
    failure: (e) => throw e,
  );
});

final taskCommentsProvider =
    FutureProvider.family<List<Comment>, String>((ref, taskId) async {
  final res = await ref.watch(commentRepositoryProvider).comments(taskId);
  return res.when(success: (c) => c, failure: (e) => throw e);
});

final taskAttachmentsProvider =
    FutureProvider.family<List<Attachment>, String>((ref, taskId) async {
  final res = await ref.watch(attachmentRepositoryProvider).attachments(taskId);
  return res.when(success: (a) => a, failure: (e) => throw e);
});

final taskTimeEntriesProvider =
    FutureProvider.family<List<TimeEntry>, String>((ref, taskId) async {
  final teamId = ref.watch(authControllerProvider).selectedTeamId;
  if (teamId == null) return const [];
  final res =
      await ref.watch(timeRepositoryProvider).entriesForTask(teamId, taskId);
  return res.when(success: (e) => e, failure: (e) => throw e);
});

/// The currently running timer across the app (null if none). Polls on demand.
class RunningTimerController extends StateNotifier<AsyncValue<TimeEntry?>> {
  final Ref _ref;
  RunningTimerController(this._ref) : super(const AsyncValue.data(null)) {
    refresh();
  }

  Future<void> refresh() async {
    final teamId = _ref.read(authControllerProvider).selectedTeamId;
    if (teamId == null) {
      state = const AsyncValue.data(null);
      return;
    }
    final res = await _ref.read(timeRepositoryProvider).current(teamId);
    res.when(
      success: (entry) => state = AsyncValue.data(entry),
      failure: (err) => state = AsyncValue.error(err, StackTrace.current),
    );
  }

  Future<Result<TimeEntry>> start(String taskId) async {
    final teamId = _ref.read(authControllerProvider).selectedTeamId!;
    final res =
        await _ref.read(timeRepositoryProvider).start(teamId, taskId);
    res.when(
      success: (entry) => state = AsyncValue.data(entry),
      failure: (_) {},
    );
    return res;
  }

  Future<Result<TimeEntry?>> stop() async {
    final teamId = _ref.read(authControllerProvider).selectedTeamId!;
    final res = await _ref.read(timeRepositoryProvider).stop(teamId);
    res.when(
      success: (_) => state = const AsyncValue.data(null),
      failure: (_) {},
    );
    return res;
  }
}

final runningTimerProvider =
    StateNotifierProvider<RunningTimerController, AsyncValue<TimeEntry?>>(
  (ref) => RunningTimerController(ref),
);
