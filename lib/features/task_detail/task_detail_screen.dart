import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/detail_providers.dart';
import '../../utils/urgency.dart';
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
          data: (task) {
            final urgency = urgencyForDueDate(task.dueDate);
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
                      if (task.status != null)
                        Text(task.status!.status.toUpperCase(),
                            style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
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
