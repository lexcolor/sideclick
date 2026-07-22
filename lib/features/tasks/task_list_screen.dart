import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../providers/detail_providers.dart';
import '../../providers/tasks_provider.dart';
import '../../providers/theme_provider.dart';
import '../../sync/sync_service.dart';
import '../task_detail/live_timer_text.dart';
import '../task_detail/task_detail_screen.dart';
import 'filter_bar.dart';
import 'status_sheet.dart';
import 'task_card.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start connectivity-driven sync and load cache-then-network.
      ref.read(syncServiceProvider);
      ref.read(tasksControllerProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final tasksState = ref.watch(tasksControllerProvider);
    final visible = ref.watch(visibleTasksProvider);

    // Re-fetch when the workspace changes.
    ref.listen(authControllerProvider.select((s) => s.selectedTeamId),
        (prev, next) {
      if (prev != next && next != null) {
        ref.read(tasksControllerProvider.notifier).load();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: _WorkspaceSelector(auth: auth),
        actions: [
          const _TimerBadge(),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: tasksState.loading
                ? null
                : () => ref.read(tasksControllerProvider.notifier).refresh(),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              switch (v) {
                case 'signout':
                  ref.read(authControllerProvider.notifier).signOut();
                case 'theme_system':
                  ref.read(themeModeProvider.notifier).set(ThemeMode.system);
                case 'theme_light':
                  ref.read(themeModeProvider.notifier).set(ThemeMode.light);
                case 'theme_dark':
                  ref.read(themeModeProvider.notifier).set(ThemeMode.dark);
              }
            },
            itemBuilder: (_) {
              final mode = ref.read(themeModeProvider);
              Widget themeItem(String label, IconData icon, ThemeMode m) => Row(
                    children: [
                      Icon(icon, size: 18),
                      const SizedBox(width: 12),
                      Expanded(child: Text(label)),
                      if (mode == m)
                        const Icon(Icons.check, size: 18),
                    ],
                  );
              return [
                PopupMenuItem(
                  value: 'user',
                  enabled: false,
                  child: Text(auth.user?.username ?? auth.user?.email ?? 'Me'),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'theme_system',
                  child: themeItem(
                      'System theme', Icons.brightness_auto, ThemeMode.system),
                ),
                PopupMenuItem(
                  value: 'theme_light',
                  child: themeItem(
                      'Light theme', Icons.light_mode, ThemeMode.light),
                ),
                PopupMenuItem(
                  value: 'theme_dark',
                  child:
                      themeItem('Dark theme', Icons.dark_mode, ThemeMode.dark),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(value: 'signout', child: Text('Sign out')),
              ];
            },
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: FilterBar(),
        ),
      ),
      body: Column(
        children: [
          if (tasksState.fromCache && tasksState.error != null)
            _OfflineBanner(message: tasksState.error!.message),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.read(tasksControllerProvider.notifier).refresh(),
              child: _body(context, tasksState, visible),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(
    BuildContext context,
    TasksState state,
    List visible,
  ) {
    if (state.loading && state.tasks.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null && state.tasks.isEmpty) {
      return _ErrorView(
        message: state.error!.message,
        onRetry: () => ref.read(tasksControllerProvider.notifier).refresh(),
      );
    }
    if (visible.isEmpty) {
      return ListView(
        // Needs to be scrollable so pull-to-refresh works when empty.
        children: [
          const SizedBox(height: 120),
          Icon(Icons.task_alt,
              size: 64, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 12),
          Center(
            child: Text('No tasks match your filters.',
                style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 24),
      itemCount: visible.length,
      itemBuilder: (context, i) {
        final task = visible[i];
        return TaskCard(
          task: task,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TaskDetailScreen(taskId: task.id),
            ),
          ),
          onChangeStatus: () => showStatusSheet(context, ref, task),
        );
      },
    );
  }
}

class _WorkspaceSelector extends ConsumerWidget {
  final AuthState auth;
  const _WorkspaceSelector({required this.auth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (auth.workspaces.length <= 1) {
      return Text(auth.selectedWorkspace?.name ?? 'SideClick');
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: auth.selectedTeamId,
        isDense: true,
        style: Theme.of(context).textTheme.titleLarge,
        items: [
          for (final w in auth.workspaces)
            DropdownMenuItem(value: w.id, child: Text(w.name)),
        ],
        onChanged: (id) {
          if (id != null) {
            ref.read(authControllerProvider.notifier).selectWorkspace(id);
          }
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

/// A thin banner shown when displaying cached data because the network failed.
class _OfflineBanner extends StatelessWidget {
  final String message;
  const _OfflineBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.cloud_off,
                size: 16, color: theme.colorScheme.onErrorContainer),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Offline — showing cached tasks. $message',
                  style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onErrorContainer)),
            ),
          ],
        ),
      ),
    );
  }
}

/// App-bar badge showing the currently running timer (if any). Tapping it opens
/// the task the timer is running on.
class _TimerBadge extends ConsumerWidget {
  const _TimerBadge();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final running = ref.watch(runningTimerProvider);
    return running.maybeWhen(
      data: (entry) {
        if (entry == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ActionChip(
            avatar: const Icon(Icons.fiber_manual_record,
                size: 12, color: Color(0xFFE5484D)),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(entry.task?.name != null
                    ? _short(entry.task!.name!)
                    : 'Tracking'),
                if (entry.start != null) ...[
                  const SizedBox(width: 6),
                  LiveTimerText(
                    startEpochMs: entry.start!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ],
            ),
            onPressed: entry.task == null
                ? null
                : () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            TaskDetailScreen(taskId: entry.task!.id),
                      ),
                    ),
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  String _short(String s) => s.length > 16 ? '${s.substring(0, 16)}…' : s;
}
