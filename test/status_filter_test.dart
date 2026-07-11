import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sideclick/core/storage/secure_store.dart';
import 'package:sideclick/models/task.dart';
import 'package:sideclick/providers/core_providers.dart';
import 'package:sideclick/providers/tasks_provider.dart';

/// Builds a container with a temp-backed SecureStore (so the filter controller
/// can hydrate without path_provider) and a fixed task list.
ProviderContainer _containerWith(List<Task> tasks, Directory dir) {
  final container = ProviderContainer(overrides: [
    secureStoreProvider.overrideWithValue(SecureStore(directory: dir)),
  ]);
  container.read(tasksControllerProvider.notifier).state =
      TasksState(tasks: tasks);
  return container;
}

Task _task(String id, String status, {String? color}) => Task(
      id: id,
      name: 'Task $id',
      status: TaskStatus(status: status, color: color),
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final tasks = [
    _task('1', 'To Do', color: '#d3d3d3'),
    _task('2', 'in progress', color: '#4194f6'),
    _task('3', 'In Progress'), // same key as #2, different casing
    _task('4', 'Complete', color: '#6bc950'),
  ];

  late Directory dir;
  setUp(() async {
    dir = await Directory.systemTemp.createTemp('sideclick_filter');
  });
  tearDown(() async {
    if (await dir.exists()) await dir.delete(recursive: true);
  });

  test('availableStatuses is distinct (case-insensitive) and sorted', () {
    final c = _containerWith(tasks, dir);
    addTearDown(c.dispose);
    final options = c.read(availableStatusesProvider);
    expect(options.map((o) => o.key).toList(),
        ['complete', 'in progress', 'to do']);
    final inProgress = options.firstWhere((o) => o.key == 'in progress');
    expect(inProgress.color, '#4194f6');
  });

  test('empty selection shows all tasks', () {
    final c = _containerWith(tasks, dir);
    addTearDown(c.dispose);
    expect(c.read(visibleTasksProvider).length, 4);
  });

  test('selecting statuses filters case-insensitively', () async {
    final c = _containerWith(tasks, dir);
    addTearDown(c.dispose);
    final notifier = c.read(taskFilterProvider.notifier);
    notifier.set(const TaskFilter(selectedStatuses: {'in progress'}));
    final visible = c.read(visibleTasksProvider);
    expect(visible.map((t) => t.id).toSet(), {'2', '3'});
    // Await the persistence write before tearDown removes the temp dir.
    await notifier.settled;
  });

  test('multi-selection unions the chosen statuses', () async {
    final c = _containerWith(tasks, dir);
    addTearDown(c.dispose);
    final notifier = c.read(taskFilterProvider.notifier);
    notifier.set(const TaskFilter(selectedStatuses: {'to do', 'complete'}));
    final visible = c.read(visibleTasksProvider);
    expect(visible.map((t) => t.id).toSet(), {'1', '4'});
    await notifier.settled;
  });

  test('selected statuses are persisted to the store', () async {
    final c = _containerWith(tasks, dir);
    addTearDown(c.dispose);
    final notifier = c.read(taskFilterProvider.notifier);
    notifier.set(const TaskFilter(selectedStatuses: {'complete'}));
    await notifier.settled;
    final persisted = await SecureStore(directory: dir).readStatusFilter();
    expect(persisted, {'complete'});
  });
}
