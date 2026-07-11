// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkspaceImpl _$$WorkspaceImplFromJson(Map<String, dynamic> json) =>
    _$WorkspaceImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String?,
      avatar: json['avatar'] as String?,
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => WorkspaceMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WorkspaceMember>[],
    );

Map<String, dynamic> _$$WorkspaceImplToJson(_$WorkspaceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'avatar': instance.avatar,
      'members': instance.members,
    };

_$WorkspaceMemberImpl _$$WorkspaceMemberImplFromJson(
  Map<String, dynamic> json,
) => _$WorkspaceMemberImpl(
  user: ClickUpUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$WorkspaceMemberImplToJson(
  _$WorkspaceMemberImpl instance,
) => <String, dynamic>{'user': instance.user};
