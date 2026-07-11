import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'time_entry.freezed.dart';
part 'time_entry.g.dart';

int? _epochFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}

/// A time tracking entry. For a running timer, [end] is null and [duration] is
/// reported as a negative value by ClickUp; consumers should compute elapsed
/// time from [start] when [end] is null.
@freezed
class TimeEntry with _$TimeEntry {
  const factory TimeEntry({
    String? id,
    @JsonKey(name: 'task') TimeEntryTask? task,
    @JsonKey(name: 'start', fromJson: _epochFromJson) int? start,
    @JsonKey(name: 'end', fromJson: _epochFromJson) int? end,
    @JsonKey(name: 'duration', fromJson: _epochFromJson) int? duration,
    ClickUpUser? user,
    String? description,
  }) = _TimeEntry;

  factory TimeEntry.fromJson(Map<String, dynamic> json) =>
      _$TimeEntryFromJson(json);
}

@freezed
class TimeEntryTask with _$TimeEntryTask {
  const factory TimeEntryTask({
    required String id,
    String? name,
  }) = _TimeEntryTask;

  factory TimeEntryTask.fromJson(Map<String, dynamic> json) =>
      _$TimeEntryTaskFromJson(json);
}
