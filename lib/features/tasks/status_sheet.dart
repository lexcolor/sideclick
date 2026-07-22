import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/task.dart';
import '../../providers/tasks_provider.dart';

/// Common ClickUp defaults, used only when a List's real statuses can't be
/// fetched (offline, missing list id, etc.) so the sheet is never empty.
const _fallbackStatuses = ['to do', 'in progress', 'review', 'complete', 'closed'];

/// Opens the "Change status" sheet for [task], populated with the real
/// statuses configured on the task's List (including custom ones — ClickUp
/// defines statuses per List, not globally), applies the selection, and
/// surfaces a SnackBar if the update is hard-rejected by the API.
Future<void> showStatusSheet(
  BuildContext context,
  WidgetRef ref,
  Task task,
) async {
  final listId = task.list?.id;
  var statuses = <TaskStatus>[];
  if (listId != null) {
    try {
      statuses = await ref.read(listStatusesProvider(listId).future);
    } catch (_) {
      // Fetch failed; fall back to the generic set below.
    }
  }
  if (statuses.isEmpty) {
    statuses = [for (final s in _fallbackStatuses) TaskStatus(status: s)];
  }
  if (!context.mounted) return;

  final selected = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(ctx).size.height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Change status',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final s in statuses)
                    ListTile(
                      leading: Icon(Icons.circle,
                          size: 14, color: _statusColor(s.color)),
                      title: Text(s.status),
                      selected: s.status.toLowerCase() ==
                          task.status?.status.toLowerCase(),
                      onTap: () => Navigator.of(ctx).pop(s.status),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  if (selected == null || !context.mounted) return;

  final err =
      await ref.read(tasksControllerProvider.notifier).changeStatus(task, selected);
  if (err != null && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not change status: ${err.message}')),
    );
  }
}

Color? _statusColor(String? hex) {
  if (hex == null) return null;
  var value = hex.replaceAll('#', '');
  if (value.length == 6) value = 'FF$value';
  final parsed = int.tryParse(value, radix: 16);
  return parsed == null ? null : Color(parsed);
}
