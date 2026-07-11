import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/tasks_provider.dart';

/// A horizontal row of quick filter chips + a sort menu.
class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(taskFilterProvider);
    final notifier = ref.read(taskFilterProvider.notifier);

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          FilterChip(
            label: const Text('Overdue'),
            selected: filter.onlyOverdue,
            onSelected: (v) => notifier
                .set(filter.copyWith(onlyOverdue: v, onlyDueThisWeek: false)),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Due this week'),
            selected: filter.onlyDueThisWeek,
            onSelected: (v) => notifier
                .set(filter.copyWith(onlyDueThisWeek: v, onlyOverdue: false)),
          ),
          const SizedBox(width: 8),
          FilterChip(
            label: const Text('Include closed'),
            selected: filter.includeClosed,
            onSelected: (v) {
              notifier.set(filter.copyWith(includeClosed: v));
              // Closed tasks require a re-fetch (server-side filter).
              ref.read(tasksControllerProvider.notifier).refresh();
            },
          ),
          const SizedBox(width: 8),
          Center(
            child: FilterChip(
              avatar: const Icon(Icons.filter_list, size: 16),
              label: Text(filter.selectedStatuses.isEmpty
                  ? 'Status'
                  : 'Status (${filter.selectedStatuses.length})'),
              selected: filter.selectedStatuses.isNotEmpty,
              onSelected: (_) => _showStatusPicker(context, ref),
            ),
          ),
          const SizedBox(width: 8),
          Center(
            child: PopupMenuButton<TaskSort>(
              initialValue: filter.sort,
              onSelected: (s) => notifier.set(filter.copyWith(sort: s)),
              itemBuilder: (_) => const [
                PopupMenuItem(
                    value: TaskSort.dueDateAsc, child: Text('Due date ↑')),
                PopupMenuItem(
                    value: TaskSort.dueDateDesc, child: Text('Due date ↓')),
                PopupMenuItem(
                    value: TaskSort.priority, child: Text('Priority')),
                PopupMenuItem(value: TaskSort.name, child: Text('Name')),
              ],
              child: Chip(
                avatar: const Icon(Icons.sort, size: 16),
                label: Text(_sortLabel(filter.sort)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _sortLabel(TaskSort sort) => switch (sort) {
        TaskSort.dueDateAsc => 'Due ↑',
        TaskSort.dueDateDesc => 'Due ↓',
        TaskSort.priority => 'Priority',
        TaskSort.name => 'Name',
      };

  Future<void> _showStatusPicker(BuildContext context, WidgetRef ref) async {
    final options = ref.read(availableStatusesProvider);
    if (options.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No statuses to filter yet.')),
      );
      return;
    }
    final current = ref.read(taskFilterProvider).selectedStatuses;
    final result = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _StatusPickerSheet(
        options: options,
        initiallySelected: current,
      ),
    );
    if (result != null) {
      final notifier = ref.read(taskFilterProvider.notifier);
      notifier
          .set(ref.read(taskFilterProvider).copyWith(selectedStatuses: result));
    }
  }
}

/// Multi-select status filter sheet. Returns the chosen set (empty = show all).
class _StatusPickerSheet extends StatefulWidget {
  final List<StatusOption> options;
  final Set<String> initiallySelected;

  const _StatusPickerSheet({
    required this.options,
    required this.initiallySelected,
  });

  @override
  State<_StatusPickerSheet> createState() => _StatusPickerSheetState();
}

class _StatusPickerSheetState extends State<_StatusPickerSheet> {
  late final Set<String> _selected = {...widget.initiallySelected};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 4),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Filter by status',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed:
                      _selected.isEmpty ? null : () => setState(_selected.clear),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final o in widget.options)
                  CheckboxListTile(
                    value: _selected.contains(o.key),
                    onChanged: (v) => setState(() {
                      if (v == true) {
                        _selected.add(o.key);
                      } else {
                        _selected.remove(o.key);
                      }
                    }),
                    secondary: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: _parseColor(o.color) ??
                            Theme.of(context).colorScheme.outline,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(o.label),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(_selected),
                    child: Text(_selected.isEmpty
                        ? 'Show all'
                        : 'Apply (${_selected.length})'),
                  ),
                ),
              ],
            ),
          ),
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
