import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/detail_providers.dart';
import '../../providers/tasks_provider.dart';
import '../../utils/urgency.dart';
import '../tasks/status_sheet.dart';
import 'attachments_tab.dart';
import 'comments_tab.dart';
import 'time_tab.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;
  const TaskDetailScreen({super.key, required this.taskId});

  Future<void> _openInClickUp(BuildContext context, WidgetRef ref) async {
    // Prefer the canonical url from the task; fall back to the standard task URL.
    final task = ref.read(taskDetailProvider(taskId)).value;
    final url = task?.url ?? 'https://app.clickup.com/t/$taskId';
    final ok =
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open ClickUp.')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(taskDetailProvider(taskId));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: detail.when(
            data: (t) => Text(t.name, overflow: TextOverflow.ellipsis),
            loading: () => const Text('Loading…'),
            error: (_, _) => const Text('Task'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.open_in_new),
              tooltip: 'Open in ClickUp',
              onPressed: () => _openInClickUp(context, ref),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.comment_outlined), text: 'Comments'),
              Tab(icon: Icon(Icons.attach_file), text: 'Files'),
              Tab(icon: Icon(Icons.timer_outlined), text: 'Time'),
            ],
          ),
        ),
        body: detail.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('$e')),
          data: (detailTask) {
            // The tasks list applies status changes optimistically; overlay its
            // status here so a change made from either screen shows up
            // immediately without needing a fresh network fetch.
            final listTask = ref.watch(tasksControllerProvider.select(
              (s) => s.tasks.where((t) => t.id == taskId).firstOrNull,
            ));
            final task = listTask != null
                ? detailTask.copyWith(status: listTask.status)
                : detailTask;

            final urgency = urgencyForDueDate(task.dueDate);
            final description = (task.textContent?.trim().isNotEmpty ?? false)
                ? task.textContent!.trim()
                : (task.description?.trim().isNotEmpty ?? false)
                    ? task.description!.trim()
                    : null;

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  color: urgency.color.withValues(alpha: 0.12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: urgency.color, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Text(urgency.label,
                          style: TextStyle(
                              color: urgency.color,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () => showStatusSheet(context, ref, task),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                task.status?.status.toUpperCase() ??
                                    'NO STATUS',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Icon(Icons.arrow_drop_down,
                                  size: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.color),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (description != null) _DescriptionPanel(text: description),
                Expanded(
                  child: TabBarView(
                    children: [
                      CommentsTab(taskId: taskId),
                      AttachmentsTab(taskId: taskId),
                      TimeTab(task: task),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// The task description, pinned above the tab content so it stays visible
/// while switching between Comments, Files, and Time — collapsible so a long
/// description doesn't crowd out the active tab.
class _DescriptionPanel extends StatefulWidget {
  final String text;
  const _DescriptionPanel({required this.text});

  @override
  State<_DescriptionPanel> createState() => _DescriptionPanelState();
}

class _DescriptionPanelState extends State<_DescriptionPanel> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              children: [
                Text('Description',
                    style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.outline,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5)),
                const Spacer(),
                Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                    size: 18, color: theme.colorScheme.outline),
              ],
            ),
          ),
          if (_expanded) ...[
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 140),
              child: SingleChildScrollView(
                child: SelectableText(widget.text,
                    style: theme.textTheme.bodyMedium),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
