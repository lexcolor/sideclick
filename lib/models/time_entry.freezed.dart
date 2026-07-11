// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimeEntry _$TimeEntryFromJson(Map<String, dynamic> json) {
  return _TimeEntry.fromJson(json);
}

/// @nodoc
mixin _$TimeEntry {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'task')
  TimeEntryTask? get task => throw _privateConstructorUsedError;
  @JsonKey(name: 'start', fromJson: _epochFromJson)
  int? get start => throw _privateConstructorUsedError;
  @JsonKey(name: 'end', fromJson: _epochFromJson)
  int? get end => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration', fromJson: _epochFromJson)
  int? get duration => throw _privateConstructorUsedError;
  ClickUpUser? get user => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this TimeEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeEntryCopyWith<TimeEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeEntryCopyWith<$Res> {
  factory $TimeEntryCopyWith(TimeEntry value, $Res Function(TimeEntry) then) =
      _$TimeEntryCopyWithImpl<$Res, TimeEntry>;
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'task') TimeEntryTask? task,
    @JsonKey(name: 'start', fromJson: _epochFromJson) int? start,
    @JsonKey(name: 'end', fromJson: _epochFromJson) int? end,
    @JsonKey(name: 'duration', fromJson: _epochFromJson) int? duration,
    ClickUpUser? user,
    String? description,
  });

  $TimeEntryTaskCopyWith<$Res>? get task;
  $ClickUpUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$TimeEntryCopyWithImpl<$Res, $Val extends TimeEntry>
    implements $TimeEntryCopyWith<$Res> {
  _$TimeEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? task = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? duration = freezed,
    Object? user = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            task: freezed == task
                ? _value.task
                : task // ignore: cast_nullable_to_non_nullable
                      as TimeEntryTask?,
            start: freezed == start
                ? _value.start
                : start // ignore: cast_nullable_to_non_nullable
                      as int?,
            end: freezed == end
                ? _value.end
                : end // ignore: cast_nullable_to_non_nullable
                      as int?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int?,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as ClickUpUser?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimeEntryTaskCopyWith<$Res>? get task {
    if (_value.task == null) {
      return null;
    }

    return $TimeEntryTaskCopyWith<$Res>(_value.task!, (value) {
      return _then(_value.copyWith(task: value) as $Val);
    });
  }

  /// Create a copy of TimeEntry
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
abstract class _$$TimeEntryImplCopyWith<$Res>
    implements $TimeEntryCopyWith<$Res> {
  factory _$$TimeEntryImplCopyWith(
    _$TimeEntryImpl value,
    $Res Function(_$TimeEntryImpl) then,
  ) = __$$TimeEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @JsonKey(name: 'task') TimeEntryTask? task,
    @JsonKey(name: 'start', fromJson: _epochFromJson) int? start,
    @JsonKey(name: 'end', fromJson: _epochFromJson) int? end,
    @JsonKey(name: 'duration', fromJson: _epochFromJson) int? duration,
    ClickUpUser? user,
    String? description,
  });

  @override
  $TimeEntryTaskCopyWith<$Res>? get task;
  @override
  $ClickUpUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$TimeEntryImplCopyWithImpl<$Res>
    extends _$TimeEntryCopyWithImpl<$Res, _$TimeEntryImpl>
    implements _$$TimeEntryImplCopyWith<$Res> {
  __$$TimeEntryImplCopyWithImpl(
    _$TimeEntryImpl _value,
    $Res Function(_$TimeEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? task = freezed,
    Object? start = freezed,
    Object? end = freezed,
    Object? duration = freezed,
    Object? user = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$TimeEntryImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        task: freezed == task
            ? _value.task
            : task // ignore: cast_nullable_to_non_nullable
                  as TimeEntryTask?,
        start: freezed == start
            ? _value.start
            : start // ignore: cast_nullable_to_non_nullable
                  as int?,
        end: freezed == end
            ? _value.end
            : end // ignore: cast_nullable_to_non_nullable
                  as int?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int?,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as ClickUpUser?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeEntryImpl implements _TimeEntry {
  const _$TimeEntryImpl({
    this.id,
    @JsonKey(name: 'task') this.task,
    @JsonKey(name: 'start', fromJson: _epochFromJson) this.start,
    @JsonKey(name: 'end', fromJson: _epochFromJson) this.end,
    @JsonKey(name: 'duration', fromJson: _epochFromJson) this.duration,
    this.user,
    this.description,
  });

  factory _$TimeEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeEntryImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey(name: 'task')
  final TimeEntryTask? task;
  @override
  @JsonKey(name: 'start', fromJson: _epochFromJson)
  final int? start;
  @override
  @JsonKey(name: 'end', fromJson: _epochFromJson)
  final int? end;
  @override
  @JsonKey(name: 'duration', fromJson: _epochFromJson)
  final int? duration;
  @override
  final ClickUpUser? user;
  @override
  final String? description;

  @override
  String toString() {
    return 'TimeEntry(id: $id, task: $task, start: $start, end: $end, duration: $duration, user: $user, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    task,
    start,
    end,
    duration,
    user,
    description,
  );

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeEntryImplCopyWith<_$TimeEntryImpl> get copyWith =>
      __$$TimeEntryImplCopyWithImpl<_$TimeEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeEntryImplToJson(this);
  }
}

abstract class _TimeEntry implements TimeEntry {
  const factory _TimeEntry({
    final String? id,
    @JsonKey(name: 'task') final TimeEntryTask? task,
    @JsonKey(name: 'start', fromJson: _epochFromJson) final int? start,
    @JsonKey(name: 'end', fromJson: _epochFromJson) final int? end,
    @JsonKey(name: 'duration', fromJson: _epochFromJson) final int? duration,
    final ClickUpUser? user,
    final String? description,
  }) = _$TimeEntryImpl;

  factory _TimeEntry.fromJson(Map<String, dynamic> json) =
      _$TimeEntryImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(name: 'task')
  TimeEntryTask? get task;
  @override
  @JsonKey(name: 'start', fromJson: _epochFromJson)
  int? get start;
  @override
  @JsonKey(name: 'end', fromJson: _epochFromJson)
  int? get end;
  @override
  @JsonKey(name: 'duration', fromJson: _epochFromJson)
  int? get duration;
  @override
  ClickUpUser? get user;
  @override
  String? get description;

  /// Create a copy of TimeEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeEntryImplCopyWith<_$TimeEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeEntryTask _$TimeEntryTaskFromJson(Map<String, dynamic> json) {
  return _TimeEntryTask.fromJson(json);
}

/// @nodoc
mixin _$TimeEntryTask {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this TimeEntryTask to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeEntryTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeEntryTaskCopyWith<TimeEntryTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeEntryTaskCopyWith<$Res> {
  factory $TimeEntryTaskCopyWith(
    TimeEntryTask value,
    $Res Function(TimeEntryTask) then,
  ) = _$TimeEntryTaskCopyWithImpl<$Res, TimeEntryTask>;
  @useResult
  $Res call({String id, String? name});
}

/// @nodoc
class _$TimeEntryTaskCopyWithImpl<$Res, $Val extends TimeEntryTask>
    implements $TimeEntryTaskCopyWith<$Res> {
  _$TimeEntryTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeEntryTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = freezed}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimeEntryTaskImplCopyWith<$Res>
    implements $TimeEntryTaskCopyWith<$Res> {
  factory _$$TimeEntryTaskImplCopyWith(
    _$TimeEntryTaskImpl value,
    $Res Function(_$TimeEntryTaskImpl) then,
  ) = __$$TimeEntryTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? name});
}

/// @nodoc
class __$$TimeEntryTaskImplCopyWithImpl<$Res>
    extends _$TimeEntryTaskCopyWithImpl<$Res, _$TimeEntryTaskImpl>
    implements _$$TimeEntryTaskImplCopyWith<$Res> {
  __$$TimeEntryTaskImplCopyWithImpl(
    _$TimeEntryTaskImpl _value,
    $Res Function(_$TimeEntryTaskImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeEntryTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = freezed}) {
    return _then(
      _$TimeEntryTaskImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeEntryTaskImpl implements _TimeEntryTask {
  const _$TimeEntryTaskImpl({required this.id, this.name});

  factory _$TimeEntryTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeEntryTaskImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;

  @override
  String toString() {
    return 'TimeEntryTask(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeEntryTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of TimeEntryTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeEntryTaskImplCopyWith<_$TimeEntryTaskImpl> get copyWith =>
      __$$TimeEntryTaskImplCopyWithImpl<_$TimeEntryTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeEntryTaskImplToJson(this);
  }
}

abstract class _TimeEntryTask implements TimeEntryTask {
  const factory _TimeEntryTask({required final String id, final String? name}) =
      _$TimeEntryTaskImpl;

  factory _TimeEntryTask.fromJson(Map<String, dynamic> json) =
      _$TimeEntryTaskImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;

  /// Create a copy of TimeEntryTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeEntryTaskImplCopyWith<_$TimeEntryTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
