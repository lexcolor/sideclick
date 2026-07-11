// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  textContent: json['text_content'] as String?,
  status: json['status'] == null
      ? null
      : TaskStatus.fromJson(json['status'] as Map<String, dynamic>),
  priority: json['priority'] == null
      ? null
      : TaskPriority.fromJson(json['priority'] as Map<String, dynamic>),
  dueDate: _epochFromJson(json['due_date']),
  startDate: _epochFromJson(json['start_date']),
  dateCreated: _epochFromJson(json['date_created']),
  dateUpdated: _epochFromJson(json['date_updated']),
  timeEstimate: (json['time_estimate'] as num?)?.toInt(),
  timeSpent: (json['time_spent'] as num?)?.toInt(),
  assignees:
      (json['assignees'] as List<dynamic>?)
          ?.map((e) => ClickUpUser.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ClickUpUser>[],
  list: json['list'] == null
      ? null
      : TaskList.fromJson(json['list'] as Map<String, dynamic>),
  space: json['space'] == null
      ? null
      : TaskSpace.fromJson(json['space'] as Map<String, dynamic>),
  url: json['url'] as String?,
);

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'text_content': instance.textContent,
      'status': instance.status,
      'priority': instance.priority,
      'due_date': instance.dueDate,
      'start_date': instance.startDate,
      'date_created': instance.dateCreated,
      'date_updated': instance.dateUpdated,
      'time_estimate': instance.timeEstimate,
      'time_spent': instance.timeSpent,
      'assignees': instance.assignees,
      'list': instance.list,
      'space': instance.space,
      'url': instance.url,
    };

_$TaskStatusImpl _$$TaskStatusImplFromJson(Map<String, dynamic> json) =>
    _$TaskStatusImpl(
      status: json['status'] as String,
      color: json['color'] as String?,
      type: json['type'] as String?,
      orderIndex: json['orderindex'],
    );

Map<String, dynamic> _$$TaskStatusImplToJson(_$TaskStatusImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'color': instance.color,
      'type': instance.type,
      'orderindex': instance.orderIndex,
    };

_$TaskPriorityImpl _$$TaskPriorityImplFromJson(Map<String, dynamic> json) =>
    _$TaskPriorityImpl(
      id: json['id'] as String?,
      priority: json['priority'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$TaskPriorityImplToJson(_$TaskPriorityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'priority': instance.priority,
      'color': instance.color,
    };

_$TaskListImpl _$$TaskListImplFromJson(Map<String, dynamic> json) =>
    _$TaskListImpl(id: json['id'] as String, name: json['name'] as String?);

Map<String, dynamic> _$$TaskListImplToJson(_$TaskListImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$TaskSpaceImpl _$$TaskSpaceImplFromJson(Map<String, dynamic> json) =>
    _$TaskSpaceImpl(id: json['id'] as String, name: json['name'] as String?);

Map<String, dynamic> _$$TaskSpaceImplToJson(_$TaskSpaceImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
