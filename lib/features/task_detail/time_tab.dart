import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/task.dart';
import '../../models/time_entry.dart';
import '../../providers/detail_providers.dart';

class TimeTab extends ConsumerWidget {
  final Task task;
  const TimeTab({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(taskTimeEntriesProvider(task.id));
    final running = ref.watch(runningTimerProvider);

    final isRunningThisTask = running.maybeWhen(
      data: (e) => e != null && e.task?.id == task.id,
      orElse: () => false,
    );

    return Column(
      children: [
        _TimerControl(
          task: task,
          isRunningThisTask: isRunningThisTask,
          running: running,
        ),
        const Divider(height: 1),
        Expanded(
          child: entries.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (list) {
              final total = list.fold<int>(
                  0, (sum, e) => sum + (e.duration ?? 0).abs());
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.timelapse, size: 18),
                        const SizedBox(width: 8),
                        Text('Total tracked: ${_fmtDuration(total)}',
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                  ),
                  Expanded(
                    child: list.isEmpty
                        ? const Center(child: Text('No time entries yet.'))
                        : ListView.separated(
                            itemCount: list.length,
                            separatorBuilder: (_, _) =>
                                const Divider(height: 1),
                            itemBuilder: (_, i) =>
                                _EntryTile(entry: list[i]),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TimerControl extends ConsumerStatefulWidget {
  final Task task;
  final bool isRunningThisTask;
  final AsyncValue<TimeEntry?> running;

  const _TimerControl({
    required this.task,
    required this.isRunningThisTask,
    required this.running,
  });

  @override
  ConsumerState<_TimerControl> createState() => _TimerControlState();
}

class _TimerControlState extends ConsumerState<_TimerControl> {
  bool _busy = false;

  Future<void> _toggle() async {
    setState(() => _busy = true);
    final controller = ref.read(runningTimerProvider.notifier);
    final res = widget.isRunningThisTask
        ? await controller.stop()
        : await controller.start(widget.task.id);
    if (!mounted) return;
    setState(() => _busy = false);
    res.when(
      success: (_) => ref.invalidate(taskTimeEntriesProvider(widget.task.id)),
      failure: (err) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.message))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final runningOther = widget.running.maybeWhen(
      data: (e) => e != null && e.task?.id != widget.task.id,
      orElse: () => false,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            widget.isRunningThisTask
                ? Icons.radio_button_checked
                : Icons.timer_outlined,
            color: widget.isRunningThisTask
                ? const Color(0xFFE5484D)
                : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.isRunningThisTask
                  ? 'Timer running for this task'
                  : runningOther
                      ? 'A timer is running on another task'
                      : 'No timer running',
            ),
          ),
          FilledButton.icon(
            onPressed: _busy ? null : _toggle,
            icon: Icon(widget.isRunningThisTask
                ? Icons.stop
                : Icons.play_arrow),
            label: Text(widget.isRunningThisTask ? 'Stop' : 'Start'),
          ),
        ],
      ),
    );
  }
}

class _EntryTile extends StatelessWidget {
  final TimeEntry entry;
  const _EntryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final start = entry.start != null
        ? DateFormat.yMMMd().add_jm().format(
            DateTime.fromMillisecondsSinceEpoch(entry.start!))
        : '—';
    return ListTile(
      dense: true,
      leading: const Icon(Icons.schedule, size: 20),
      title: Text(_fmtDuration((entry.duration ?? 0).abs())),
      subtitle: Text(
        [start, if (entry.user?.username != null) entry.user!.username!]
            .join(' · '),
      ),
    );
  }
}

String _fmtDuration(int ms) {
  final d = Duration(milliseconds: ms);
  final h = d.inHours;
  final m = d.inMinutes % 60;
  final s = d.inSeconds % 60;
  if (h > 0) return '${h}h ${m}m';
  if (m > 0) return '${m}m ${s}s';
  return '${s}s';
}
