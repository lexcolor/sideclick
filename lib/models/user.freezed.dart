// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClickUpUser _$ClickUpUserFromJson(Map<String, dynamic> json) {
  return _ClickUpUser.fromJson(json);
}

/// @nodoc
mixin _$ClickUpUser {
  int get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'profilePicture')
  String? get profilePicture => throw _privateConstructorUsedError;
  String? get initials => throw _privateConstructorUsedError;

  /// Serializes this ClickUpUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClickUpUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClickUpUserCopyWith<ClickUpUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClickUpUserCopyWith<$Res> {
  factory $ClickUpUserCopyWith(
    ClickUpUser value,
    $Res Function(ClickUpUser) then,
  ) = _$ClickUpUserCopyWithImpl<$Res, ClickUpUser>;
  @useResult
  $Res call({
    int id,
    String? username,
    String? email,
    String? color,
    @JsonKey(name: 'profilePicture') String? profilePicture,
    String? initials,
  });
}

/// @nodoc
class _$ClickUpUserCopyWithImpl<$Res, $Val extends ClickUpUser>
    implements $ClickUpUserCopyWith<$Res> {
  _$ClickUpUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClickUpUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? color = freezed,
    Object? profilePicture = freezed,
    Object? initials = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            profilePicture: freezed == profilePicture
                ? _value.profilePicture
                : profilePicture // ignore: cast_nullable_to_non_nullable
                      as String?,
            initials: freezed == initials
                ? _value.initials
                : initials // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClickUpUserImplCopyWith<$Res>
    implements $ClickUpUserCopyWith<$Res> {
  factory _$$ClickUpUserImplCopyWith(
    _$ClickUpUserImpl value,
    $Res Function(_$ClickUpUserImpl) then,
  ) = __$$ClickUpUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String? username,
    String? email,
    String? color,
    @JsonKey(name: 'profilePicture') String? profilePicture,
    String? initials,
  });
}

/// @nodoc
class __$$ClickUpUserImplCopyWithImpl<$Res>
    extends _$ClickUpUserCopyWithImpl<$Res, _$ClickUpUserImpl>
    implements _$$ClickUpUserImplCopyWith<$Res> {
  __$$ClickUpUserImplCopyWithImpl(
    _$ClickUpUserImpl _value,
    $Res Function(_$ClickUpUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClickUpUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? color = freezed,
    Object? profilePicture = freezed,
    Object? initials = freezed,
  }) {
    return _then(
      _$ClickUpUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        profilePicture: freezed == profilePicture
            ? _value.profilePicture
            : profilePicture // ignore: cast_nullable_to_non_nullable
                  as String?,
        initials: freezed == initials
            ? _value.initials
            : initials // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClickUpUserImpl implements _ClickUpUser {
  const _$ClickUpUserImpl({
    required this.id,
    this.username,
    this.email,
    this.color,
    @JsonKey(name: 'profilePicture') this.profilePicture,
    this.initials,
  });

  factory _$ClickUpUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClickUpUserImplFromJson(json);

  @override
  final int id;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? color;
  @override
  @JsonKey(name: 'profilePicture')
  final String? profilePicture;
  @override
  final String? initials;

  @override
  String toString() {
    return 'ClickUpUser(id: $id, username: $username, email: $email, color: $color, profilePicture: $profilePicture, initials: $initials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClickUpUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.initials, initials) ||
                other.initials == initials));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    email,
    color,
    profilePicture,
    initials,
  );

  /// Create a copy of ClickUpUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClickUpUserImplCopyWith<_$ClickUpUserImpl> get copyWith =>
      __$$ClickUpUserImplCopyWithImpl<_$ClickUpUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClickUpUserImplToJson(this);
  }
}

abstract class _ClickUpUser implements ClickUpUser {
  const factory _ClickUpUser({
    required final int id,
    final String? username,
    final String? email,
    final String? color,
    @JsonKey(name: 'profilePicture') final String? profilePicture,
    final String? initials,
  }) = _$ClickUpUserImpl;

  factory _ClickUpUser.fromJson(Map<String, dynamic> json) =
      _$ClickUpUserImpl.fromJson;

  @override
  int get id;
  @override
  String? get username;
  @override
  String? get email;
  @override
  String? get color;
  @override
  @JsonKey(name: 'profilePicture')
  String? get profilePicture;
  @override
  String? get initials;

  /// Create a copy of ClickUpUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClickUpUserImplCopyWith<_$ClickUpUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
