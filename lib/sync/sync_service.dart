import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/core_providers.dart';
import '../providers/tasks_provider.dart';

/// Flushes queued offline mutations when connectivity returns, and exposes the
/// current online/offline state.
class SyncService {
  final Ref _ref;
  StreamSubscription? _sub;
  bool _online = true;

  SyncService(this._ref);

  bool get online => _online;

  void start() {
    _sub = Connectivity().onConnectivityChanged.listen((results) {
      final nowOnline =
          results.any((r) => r != ConnectivityResult.none);
      final cameOnline = nowOnline && !_online;
      _online = nowOnline;
      if (cameOnline) {
        flush();
      }
    });
  }

  void dispose() {
    _sub?.cancel();
  }

  /// Attempts to replay every queued action against the API. Successfully
  /// synced actions are removed; failures are left for the next attempt.
  Future<void> flush() async {
    final db = _ref.read(appDatabaseProvider);
    final taskRepo = _ref.read(taskRepositoryProvider);
    final actions = await db.pendingActions();
    if (actions.isEmpty) return;

    for (final action in actions) {
      final payload = jsonDecode(action.payload) as Map<String, dynamic>;
      var ok = false;
      switch (action.type) {
        case 'status':
          final res = await taskRepo.updateStatus(
              action.taskId, payload['status'] as String);
          ok = res.when(success: (_) => true, failure: (_) => false);
        default:
          // Unknown action type — drop it so it doesn't block the queue.
          ok = true;
      }
      if (ok) {
        await db.removeAction(action.id);
      } else {
        // Stop on first failure to preserve ordering; retry next time.
        break;
      }
    }

    // Refresh task list to reflect synced state.
    await _ref.read(tasksControllerProvider.notifier).refresh();
  }
}

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(ref);
  service.start();
  ref.onDispose(service.dispose);
  return service;
});
