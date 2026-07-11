import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'workspace.freezed.dart';
part 'workspace.g.dart';

/// A ClickUp workspace (called a "team" in the API). Members are used to seed
/// the mention picker.
@freezed
class Workspace with _$Workspace {
  const factory Workspace({
    required String id,
    required String name,
    String? color,
    String? avatar,
    @Default(<WorkspaceMember>[]) List<WorkspaceMember> members,
  }) = _Workspace;

  factory Workspace.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceFromJson(json);
}

@freezed
class WorkspaceMember with _$WorkspaceMember {
  const factory WorkspaceMember({required ClickUpUser user}) = _WorkspaceMember;

  factory WorkspaceMember.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceMemberFromJson(json);
}
