// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeEntryImpl _$$TimeEntryImplFromJson(Map<String, dynamic> json) =>
    _$TimeEntryImpl(
      id: json['id'] as String?,
      task: json['task'] == null
          ? null
          : TimeEntryTask.fromJson(json['task'] as Map<String, dynamic>),
      start: _epochFromJson(json['start']),
      end: _epochFromJson(json['end']),
      duration: _epochFromJson(json['duration']),
      user: json['user'] == null
          ? null
          : ClickUpUser.fromJson(json['user'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TimeEntryImplToJson(_$TimeEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
      'start': instance.start,
      'end': instance.end,
      'duration': instance.duration,
      'user': instance.user,
      'description': instance.description,
    };

_$TimeEntryTaskImpl _$$TimeEntryTaskImplFromJson(Map<String, dynamic> json) =>
    _$TimeEntryTaskImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$TimeEntryTaskImplToJson(_$TimeEntryTaskImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
