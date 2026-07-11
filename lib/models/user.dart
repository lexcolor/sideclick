import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// A ClickUp user — used both for the authenticated user and for members
/// (assignees, mention candidates).
@freezed
class ClickUpUser with _$ClickUpUser {
  const factory ClickUpUser({
    required int id,
    String? username,
    String? email,
    String? color,
    @JsonKey(name: 'profilePicture') String? profilePicture,
    String? initials,
  }) = _ClickUpUser;

  factory ClickUpUser.fromJson(Map<String, dynamic> json) =>
      _$ClickUpUserFromJson(json);
}
