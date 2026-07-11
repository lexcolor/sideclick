import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

int? _epochFromJson(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String id,
    // ClickUp returns `comment` as a rich array and `comment_text` as flattened text.
    @JsonKey(name: 'comment_text') String? commentText,
    @JsonKey(name: 'comment') @Default(<CommentFragment>[]) List<CommentFragment> fragments,
    ClickUpUser? user,
    @JsonKey(name: 'resolved') @Default(false) bool resolved,
    @JsonKey(name: 'reply_count', fromJson: _intFromJson) @Default(0) int replyCount,
    @JsonKey(name: 'date', fromJson: _epochFromJson) int? date,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

int _intFromJson(dynamic value) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

/// One fragment of a rich comment (either plain [text] or a mention tag).
@freezed
class CommentFragment with _$CommentFragment {
  const factory CommentFragment({
    @Default('') String text,
    String? type, // "tag" for mentions
    ClickUpUser? user,
  }) = _CommentFragment;

  factory CommentFragment.fromJson(Map<String, dynamic> json) =>
      _$CommentFragmentFromJson(json);
}
