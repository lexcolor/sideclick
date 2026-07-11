// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  String get id =>
      throw _privateConstructorUsedError; // ClickUp returns `comment` as a rich array and `comment_text` as flattened text.
  @JsonKey(name: 'comment_text')
  String? get commentText => throw _privateConstructorUsedError;
  @JsonKey(name: 'comment')
  List<CommentFragment> get fragments => throw _privateConstructorUsedError;
  ClickUpUser? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'resolved')
  bool get resolved => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_count', fromJson: _intFromJson)
  int get replyCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'date', fromJson: _epochFromJson)
  int? get date => throw _privateConstructorUsedError;

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'comment_text') String? commentText,
    @JsonKey(name: 'comment') List<CommentFragment> fragments,
    ClickUpUser? user,
    @JsonKey(name: 'resolved') bool resolved,
    @JsonKey(name: 'reply_count', fromJson: _intFromJson) int replyCount,
    @JsonKey(name: 'date', fromJson: _epochFromJson) int? date,
  });

  $ClickUpUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? commentText = freezed,
    Object? fragments = null,
    Object? user = freezed,
    Object? resolved = null,
    Object? replyCount = null,
    Object? date = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            commentText: freezed == commentText
                ? _value.commentText
                : commentText // ignore: cast_nullable_to_non_nullable
                      as String?,
            fragments: null == fragments
                ? _value.fragments
                : fragments // ignore: cast_nullable_to_non_nullable
                      as List<CommentFragment>,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as ClickUpUser?,
            resolved: null == resolved
                ? _value.resolved
                : resolved // ignore: cast_nullable_to_non_nullable
                      as bool,
            replyCount: null == replyCount
                ? _value.replyCount
                : replyCount // ignore: cast_nullable_to_non_nullable
                      as int,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClickUpUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $ClickUpUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
    _$CommentImpl value,
    $Res Function(_$CommentImpl) then,
  ) = __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'comment_text') String? commentText,
    @JsonKey(name: 'comment') List<CommentFragment> fragments,
    ClickUpUser? user,
    @JsonKey(name: 'resolved') bool resolved,
    @JsonKey(name: 'reply_count', fromJson: _intFromJson) int replyCount,
    @JsonKey(name: 'date', fromJson: _epochFromJson) int? date,
  });

  @override
  $ClickUpUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
    _$CommentImpl _value,
    $Res Function(_$CommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? commentText = freezed,
    Object? fragments = null,
    Object? user = freezed,
    Object? resolved = null,
    Object? replyCount = null,
    Object? date = freezed,
  }) {
    return _then(
      _$CommentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        commentText: freezed == commentText
            ? _value.commentText
            : commentText // ignore: cast_nullable_to_non_nullable
                  as String?,
        fragments: null == fragments
            ? _value._fragments
            : fragments // ignore: cast_nullable_to_non_nullable
                  as List<CommentFragment>,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as ClickUpUser?,
        resolved: null == resolved
            ? _value.resolved
            : resolved // ignore: cast_nullable_to_non_nullable
                  as bool,
        replyCount: null == replyCount
            ? _value.replyCount
            : replyCount // ignore: cast_nullable_to_non_nullable
                  as int,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl implements _Comment {
  const _$CommentImpl({
    required this.id,
    @JsonKey(name: 'comment_text') this.commentText,
    @JsonKey(name: 'comment')
    final List<CommentFragment> fragments = const <CommentFragment>[],
    this.user,
    @JsonKey(name: 'resolved') this.resolved = false,
    @JsonKey(name: 'reply_count', fromJson: _intFromJson) this.replyCount = 0,
    @JsonKey(name: 'date', fromJson: _epochFromJson) this.date,
  }) : _fragments = fragments;

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  final String id;
  // ClickUp returns `comment` as a rich array and `comment_text` as flattened text.
  @override
  @JsonKey(name: 'comment_text')
  final String? commentText;
  final List<CommentFragment> _fragments;
  @override
  @JsonKey(name: 'comment')
  List<CommentFragment> get fragments {
    if (_fragments is EqualUnmodifiableListView) return _fragments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fragments);
  }

  @override
  final ClickUpUser? user;
  @override
  @JsonKey(name: 'resolved')
  final bool resolved;
  @override
  @JsonKey(name: 'reply_count', fromJson: _intFromJson)
  final int replyCount;
  @override
  @JsonKey(name: 'date', fromJson: _epochFromJson)
  final int? date;

  @override
  String toString() {
    return 'Comment(id: $id, commentText: $commentText, fragments: $fragments, user: $user, resolved: $resolved, replyCount: $replyCount, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.commentText, commentText) ||
                other.commentText == commentText) &&
            const DeepCollectionEquality().equals(
              other._fragments,
              _fragments,
            ) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.resolved, resolved) ||
                other.resolved == resolved) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    commentText,
    const DeepCollectionEquality().hash(_fragments),
    user,
    resolved,
    replyCount,
    date,
  );

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(this);
  }
}

abstract class _Comment implements Comment {
  const factory _Comment({
    required final String id,
    @JsonKey(name: 'comment_text') final String? commentText,
    @JsonKey(name: 'comment') final List<CommentFragment> fragments,
    final ClickUpUser? user,
    @JsonKey(name: 'resolved') final bool resolved,
    @JsonKey(name: 'reply_count', fromJson: _intFromJson) final int replyCount,
    @JsonKey(name: 'date', fromJson: _epochFromJson) final int? date,
  }) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  String get id; // ClickUp returns `comment` as a rich array and `comment_text` as flattened text.
  @override
  @JsonKey(name: 'comment_text')
  String? get commentText;
  @override
  @JsonKey(name: 'comment')
  List<CommentFragment> get fragments;
  @override
  ClickUpUser? get user;
  @override
  @JsonKey(name: 'resolved')
  bool get resolved;
  @override
  @JsonKey(name: 'reply_count', fromJson: _intFromJson)
  int get replyCount;
  @override
  @JsonKey(name: 'date', fromJson: _epochFromJson)
  int? get date;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentFragment _$CommentFragmentFromJson(Map<String, dynamic> json) {
  return _CommentFragment.fromJson(json);
}

/// @nodoc
mixin _$CommentFragment {
  String get text => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError; // "tag" for mentions
  ClickUpUser? get user => throw _privateConstructorUsedError;

  /// Serializes this CommentFragment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentFragment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentFragmentCopyWith<CommentFragment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentFragmentCopyWith<$Res> {
  factory $CommentFragmentCopyWith(
    CommentFragment value,
    $Res Function(CommentFragment) then,
  ) = _$CommentFragmentCopyWithImpl<$Res, CommentFragment>;
  @useResult
  $Res call({String text, String? type, ClickUpUser? user});

  $ClickUpUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CommentFragmentCopyWithImpl<$Res, $Val extends CommentFragment>
    implements $CommentFragmentCopyWith<$Res> {
  _$CommentFragmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentFragment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? type = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as ClickUpUser?,
          )
          as $Val,
    );
  }

  /// Create a copy of CommentFragment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClickUpUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $ClickUpUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommentFragmentImplCopyWith<$Res>
    implements $CommentFragmentCopyWith<$Res> {
  factory _$$CommentFragmentImplCopyWith(
    _$CommentFragmentImpl value,
    $Res Function(_$CommentFragmentImpl) then,
  ) = __$$CommentFragmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? type, ClickUpUser? user});

  @override
  $ClickUpUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$CommentFragmentImplCopyWithImpl<$Res>
    extends _$CommentFragmentCopyWithImpl<$Res, _$CommentFragmentImpl>
    implements _$$CommentFragmentImplCopyWith<$Res> {
  __$$CommentFragmentImplCopyWithImpl(
    _$CommentFragmentImpl _value,
    $Res Function(_$CommentFragmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentFragment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? type = freezed,
    Object? user = freezed,
  }) {
    return _then(
      _$CommentFragmentImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as ClickUpUser?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentFragmentImpl implements _CommentFragment {
  const _$CommentFragmentImpl({this.text = '', this.type, this.user});

  factory _$CommentFragmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentFragmentImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  @override
  final String? type;
  // "tag" for mentions
  @override
  final ClickUpUser? user;

  @override
  String toString() {
    return 'CommentFragment(text: $text, type: $type, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentFragmentImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, type, user);

  /// Create a copy of CommentFragment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentFragmentImplCopyWith<_$CommentFragmentImpl> get copyWith =>
      __$$CommentFragmentImplCopyWithImpl<_$CommentFragmentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentFragmentImplToJson(this);
  }
}

abstract class _CommentFragment implements CommentFragment {
  const factory _CommentFragment({
    final String text,
    final String? type,
    final ClickUpUser? user,
  }) = _$CommentFragmentImpl;

  factory _CommentFragment.fromJson(Map<String, dynamic> json) =
      _$CommentFragmentImpl.fromJson;

  @override
  String get text;
  @override
  String? get type; // "tag" for mentions
  @override
  ClickUpUser? get user;

  /// Create a copy of CommentFragment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentFragmentImplCopyWith<_$CommentFragmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
