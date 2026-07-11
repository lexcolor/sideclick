import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/task.dart';
import '../../utils/urgency.dart';

/// A single task card: colored urgency swatch on the left, title, list name,
/// due date, and a priority chip. Tapping opens the detail screen.
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onChangeStatus;

  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onChangeStatus,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final urgency = urgencyForDueDate(task.dueDate);
    final swatch = urgency.color;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: InkWell(
        onTap: onTap,
        onLongPress: onChangeStatus,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Urgency swatch.
              Container(width: 6, color: swatch),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (task.space?.name != null) ...[
                        Row(
                          children: [
                            Icon(Icons.folder_outlined,
                                size: 13, color: theme.colorScheme.primary),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                task.space!.name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          if (task.priority?.priority != null)
                            _PriorityChip(priority: task.priority!.priority!),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          InkWell(
                            onTap: onChangeStatus,
                            borderRadius: BorderRadius.circular(4),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _StatusDot(status: task.status),
                                  const SizedBox(width: 6),
                                  Text(
                                    task.status?.status.toUpperCase() ??
                                        'NO STATUS',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                        color: theme.colorScheme.outline),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (onChangeStatus != null)
                                    Icon(Icons.arrow_drop_down,
                                        size: 16,
                                        color: theme.colorScheme.outline),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.event,
                              size: 14, color: swatch),
                          const SizedBox(width: 4),
                          Text(
                            _dueLabel(task.dueDate),
                            style: theme.textTheme.labelSmall
                                ?.copyWith(color: swatch),
                          ),
                        ],
                      ),
                      // Show the List name only when it's meaningful — many
                      // workspaces use the generic placeholder "List", which
                      // adds no information beyond the Space (project) shown above.
                      if (_meaningfulListName(task) != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _meaningfulListName(task)!,
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: theme.colorScheme.outline),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The List name, unless it's absent, the generic ClickUp placeholder
  /// "List", or identical to the Space name shown above.
  String? _meaningfulListName(Task task) {
    final name = task.list?.name?.trim();
    if (name == null || name.isEmpty) return null;
    if (name.toLowerCase() == 'list') return null;
    if (name == task.space?.name) return null;
    return name;
  }

  String _dueLabel(int? dueDateMs) {
    if (dueDateMs == null) return 'No due date';
    final due = DateTime.fromMillisecondsSinceEpoch(dueDateMs);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(due.year, due.month, due.day);
    final diff = dueDay.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff == -1) return 'Yesterday';
    if (diff < 0) return '${-diff}d overdue';
    if (diff <= 7) return 'In ${diff}d';
    return DateFormat.MMMd().format(due);
  }
}

class _StatusDot extends StatelessWidget {
  final TaskStatus? status;
  const _StatusDot({this.status});

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(status?.color) ??
        Theme.of(context).colorScheme.outline;
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final String priority;
  const _PriorityChip({required this.priority});

  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (priority) {
      'urgent' => (const Color(0xFFE5484D), Icons.keyboard_double_arrow_up),
      'high' => (const Color(0xFFF5A623), Icons.keyboard_arrow_up),
      'normal' => (const Color(0xFF3B82F6), Icons.remove),
      'low' => (const Color(0xFF9AA0A6), Icons.keyboard_arrow_down),
      _ => (const Color(0xFF9AA0A6), Icons.flag),
    };
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(priority,
              style: TextStyle(
                  fontSize: 10, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

Color? _parseColor(String? hex) {
  if (hex == null) return null;
  var value = hex.replaceAll('#', '');
  if (value.length == 6) value = 'FF$value';
  final parsed = int.tryParse(value, radix: 16);
  return parsed == null ? null : Color(parsed);
}
