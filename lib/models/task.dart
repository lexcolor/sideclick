import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'task.freezed.dart';
part 'task.g.dart';

/// ClickUp returns numeric epoch timestamps as strings; this converts them to
/// nullable int milliseconds.
int? _epochFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'text_content') String? textContent,
    TaskStatus? status,
    TaskPriority? priority,
    @JsonKey(name: 'due_date', fromJson: _epochFromJson) int? dueDate,
    @JsonKey(name: 'start_date', fromJson: _epochFromJson) int? startDate,
    @JsonKey(name: 'date_created', fromJson: _epochFromJson) int? dateCreated,
    @JsonKey(name: 'date_updated', fromJson: _epochFromJson) int? dateUpdated,
    @JsonKey(name: 'time_estimate') int? timeEstimate,
    @JsonKey(name: 'time_spent') int? timeSpent,
    @Default(<ClickUpUser>[]) List<ClickUpUser> assignees,
    TaskList? list,
    TaskSpace? space,
    String? url,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

@freezed
class TaskStatus with _$TaskStatus {
  const factory TaskStatus({
    required String status,
    String? color,
    String? type, // e.g. "open", "closed", "done", "custom"
    @JsonKey(name: 'orderindex') dynamic orderIndex,
  }) = _TaskStatus;

  factory TaskStatus.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusFromJson(json);
}

@freezed
class TaskPriority with _$TaskPriority {
  const factory TaskPriority({
    String? id,
    String? priority, // "urgent" | "high" | "normal" | "low"
    String? color,
  }) = _TaskPriority;

  factory TaskPriority.fromJson(Map<String, dynamic> json) =>
      _$TaskPriorityFromJson(json);
}

@freezed
class TaskList with _$TaskList {
  const factory TaskList({
    required String id,
    String? name,
  }) = _TaskList;

  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);
}

/// The Space a task belongs to — this is the "project" grouping shown in the
/// ClickUp header. The filtered-team-tasks endpoint only returns the space id,
/// so the [name] is resolved separately from `GET /team/{id}/space`.
@freezed
class TaskSpace with _$TaskSpace {
  const factory TaskSpace({
    required String id,
    String? name,
  }) = _TaskSpace;

  factory TaskSpace.fromJson(Map<String, dynamic> json) =>
      _$TaskSpaceFromJson(json);
}
