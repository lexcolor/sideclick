// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      commentText: json['comment_text'] as String?,
      fragments:
          (json['comment'] as List<dynamic>?)
              ?.map((e) => CommentFragment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CommentFragment>[],
      user: json['user'] == null
          ? null
          : ClickUpUser.fromJson(json['user'] as Map<String, dynamic>),
      resolved: json['resolved'] as bool? ?? false,
      replyCount: json['reply_count'] == null
          ? 0
          : _intFromJson(json['reply_count']),
      date: _epochFromJson(json['date']),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment_text': instance.commentText,
      'comment': instance.fragments,
      'user': instance.user,
      'resolved': instance.resolved,
      'reply_count': instance.replyCount,
      'date': instance.date,
    };

_$CommentFragmentImpl _$$CommentFragmentImplFromJson(
  Map<String, dynamic> json,
) => _$CommentFragmentImpl(
  text: json['text'] as String? ?? '',
  type: json['type'] as String?,
  user: json['user'] == null
      ? null
      : ClickUpUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CommentFragmentImplToJson(
  _$CommentFragmentImpl instance,
) => <String, dynamic>{
  'text': instance.text,
  'type': instance.type,
  'user': instance.user,
};
