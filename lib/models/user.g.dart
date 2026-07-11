// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClickUpUserImpl _$$ClickUpUserImplFromJson(Map<String, dynamic> json) =>
    _$ClickUpUserImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      color: json['color'] as String?,
      profilePicture: json['profilePicture'] as String?,
      initials: json['initials'] as String?,
    );

Map<String, dynamic> _$$ClickUpUserImplToJson(_$ClickUpUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'color': instance.color,
      'profilePicture': instance.profilePicture,
      'initials': instance.initials,
    };
