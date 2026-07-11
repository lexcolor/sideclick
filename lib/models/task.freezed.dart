// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'text_content')
  String? get textContent => throw _privateConstructorUsedError;
  TaskStatus? get status => throw _privateConstructorUsedError;
  TaskPriority? get priority => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date', fromJson: _epochFromJson)
  int? get dueDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date', fromJson: _epochFromJson)
  int? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_created', fromJson: _epochFromJson)
  int? get dateCreated => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_updated', fromJson: _epochFromJson)
  int? get dateUpdated => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_estimate')
  int? get timeEstimate => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_spent')
  int? get timeSpent => throw _privateConstructorUsedError;
  List<ClickUpUser> get assignees => throw _privateConstructorUsedError;
  TaskList? get list => throw _privateConstructorUsedError;
  TaskSpace? get space => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    @JsonKey(name: 'text_content') String? textContent,
    TaskStatus? status,
    TaskPriority? priority,
    @JsonKey(name: 'due_date', fromJson: _epochFromJson) int? dueDate,
    @JsonKey(name: 'start_date', fromJson: _epochFromJson) int? startDate,
    @JsonKey(name: 'date_created', fromJson: _epochFromJson) int? dateCreated,
    @JsonKey(name: 'date_updated', fromJson: _epochFromJson) int? dateUpdated,
    @JsonKey(name: 'time_estimate') int? timeEstimate,
    @JsonKey(name: 'time_spent') int? timeSpent,
    List<ClickUpUser> assignees,
    TaskList? list,
    TaskSpace? space,
    String? url,
  });

  $TaskStatusCopyWith<$Res>? get status;
  $TaskPriorityCopyWith<$Res>? get priority;
  $TaskListCopyWith<$Res>? get list;
  $TaskSpaceCopyWith<$Res>? get space;
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? textContent = freezed,
    Object? status = freezed,
    Object? priority = freezed,
    Object? dueDate = freezed,
    Object? startDate = freezed,
    Object? dateCreated = freezed,
    Object? dateUpdated = freezed,
    Object? timeEstimate = freezed,
    Object? timeSpent = freezed,
    Object? assignees = null,
    Object? list = freezed,
    Object? space = freezed,
    Object? url = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            textContent: freezed == textContent
                ? _value.textContent
                : textContent // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TaskStatus?,
            priority: freezed == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as TaskPriority?,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as int?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as int?,
            dateCreated: freezed == dateCreated
                ? _value.dateCreated
                : dateCreated // ignore: cast_nullable_to_non_nullable
                      as int?,
            dateUpdated: freezed == dateUpdated
                ? _value.dateUpdated
                : dateUpdated // ignore: cast_nullable_to_non_nullable
                      as int?,
            timeEstimate: freezed == timeEstimate
                ? _value.timeEstimate
                : timeEstimate // ignore: cast_nullable_to_non_nullable
                      as int?,
            timeSpent: freezed == timeSpent
                ? _value.timeSpent
                : timeSpent // ignore: cast_nullable_to_non_nullable
                      as int?,
            assignees: null == assignees
                ? _value.assignees
                : assignees // ignore: cast_nullable_to_non_nullable
                      as List<ClickUpUser>,
            list: freezed == list
                ? _value.list
                : list // ignore: cast_nullable_to_non_nullable
                      as TaskList?,
            space: freezed == space
                ? _value.space
                : space // ignore: cast_nullable_to_non_nullable
                      as TaskSpace?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskStatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $TaskStatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskPriorityCopyWith<$Res>? get priority {
    if (_value.priority == null) {
      return null;
    }

    return $TaskPriorityCopyWith<$Res>(_value.priority!, (value) {
      return _then(_value.copyWith(priority: value) as $Val);
    });
  }

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskListCopyWith<$Res>? get list {
    if (_value.list == null) {
      return null;
    }

    return $TaskListCopyWith<$Res>(_value.list!, (value) {
      return _then(_value.copyWith(list: value) as $Val);
    });
  }

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskSpaceCopyWith<$Res>? get space {
    if (_value.space == null) {
      return null;
    }

    return $TaskSpaceCopyWith<$Res>(_value.space!, (value) {
      return _then(_value.copyWith(space: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
    _$TaskImpl value,
    $Res Function(_$TaskImpl) then,
  ) = __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    @JsonKey(name: 'text_content') String? textContent,
    TaskStatus? status,
    TaskPriority? priority,
    @JsonKey(name: 'due_date', fromJson: _epochFromJson) int? dueDate,
    @JsonKey(name: 'start_date', fromJson: _epochFromJson) int? startDate,
    @JsonKey(name: 'date_created', fromJson: _epochFromJson) int? dateCreated,
    @JsonKey(name: 'date_updated', fromJson: _epochFromJson) int? dateUpdated,
    @JsonKey(name: 'time_estimate') int? timeEstimate,
    @JsonKey(name: 'time_spent') int? timeSpent,
    List<ClickUpUser> assignees,
    TaskList? list,
    TaskSpace? space,
    String? url,
  });

  @override
  $TaskStatusCopyWith<$Res>? get status;
  @override
  $TaskPriorityCopyWith<$Res>? get priority;
  @override
  $TaskListCopyWith<$Res>? get list;
  @override
  $TaskSpaceCopyWith<$Res>? get space;
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
    : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? textContent = freezed,
    Object? status = freezed,
    Object? priority = freezed,
    Object? dueDate = freezed,
    Object? startDate = freezed,
    Object? dateCreated = freezed,
    Object? dateUpdated = freezed,
    Object? timeEstimate = freezed,
    Object? timeSpent = freezed,
    Object? assignees = null,
    Object? list = freezed,
    Object? space = freezed,
    Object? url = freezed,
  }) {
    return _then(
      _$TaskImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        textContent: freezed == textContent
            ? _value.textContent
            : textContent // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TaskStatus?,
        priority: freezed == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as TaskPriority?,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as int?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as int?,
        dateCreated: freezed == dateCreated
            ? _value.dateCreated
            : dateCreated // ignore: cast_nullable_to_non_nullable
                  as int?,
        dateUpdated: freezed == dateUpdated
            ? _value.dateUpdated
            : dateUpdated // ignore: cast_nullable_to_non_nullable
                  as int?,
        timeEstimate: freezed == timeEstimate
            ? _value.timeEstimate
            : timeEstimate // ignore: cast_nullable_to_non_nullable
                  as int?,
        timeSpent: freezed == timeSpent
            ? _value.timeSpent
            : timeSpent // ignore: cast_nullable_to_non_nullable
                  as int?,
        assignees: null == assignees
            ? _value._assignees
            : assignees // ignore: cast_nullable_to_non_nullable
                  as List<ClickUpUser>,
        list: freezed == list
            ? _value.list
            : list // ignore: cast_nullable_to_non_nullable
                  as TaskList?,
        space: freezed == space
            ? _value.space
            : space // ignore: cast_nullable_to_non_nullable
                  as TaskSpace?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  const _$TaskImpl({
    required this.id,
    required this.name,
    this.description,
    @JsonKey(name: 'text_content') this.textContent,
    this.status,
    this.priority,
    @JsonKey(name: 'due_date', fromJson: _epochFromJson) this.dueDate,
    @JsonKey(name: 'start_date', fromJson: _epochFromJson) this.startDate,
    @JsonKey(name: 'date_created', fromJson: _epochFromJson) this.dateCreated,
    @JsonKey(name: 'date_updated', fromJson: _epochFromJson) this.dateUpdated,
    @JsonKey(name: 'time_estimate') this.timeEstimate,
    @JsonKey(name: 'time_spent') this.timeSpent,
    final List<ClickUpUser> assignees = const <ClickUpUser>[],
    this.list,
    this.space,
    this.url,
  }) : _assignees = assignees;

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'text_content')
  final String? textContent;
  @override
  final TaskStatus? status;
  @override
  final TaskPriority? priority;
  @override
  @JsonKey(name: 'due_date', fromJson: _epochFromJson)
  final int? dueDate;
  @override
  @JsonKey(name: 'start_date', fromJson: _epochFromJson)
  final int? startDate;
  @override
  @JsonKey(name: 'date_created', fromJson: _epochFromJson)
  final int? dateCreated;
  @override
  @JsonKey(name: 'date_updated', fromJson: _epochFromJson)
  final int? dateUpdated;
  @override
  @JsonKey(name: 'time_estimate')
  final int? timeEstimate;
  @override
  @JsonKey(name: 'time_spent')
  final int? timeSpent;
  final List<ClickUpUser> _assignees;
  @override
  @JsonKey()
  List<ClickUpUser> get assignees {
    if (_assignees is EqualUnmodifiableListView) return _assignees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignees);
  }

  @override
  final TaskList? list;
  @override
  final TaskSpace? space;
  @override
  final String? url;

  @override
  String toString() {
    return 'Task(id: $id, name: $name, description: $description, textContent: $textContent, status: $status, priority: $priority, dueDate: $dueDate, startDate: $startDate, dateCreated: $dateCreated, dateUpdated: $dateUpdated, timeEstimate: $timeEstimate, timeSpent: $timeSpent, assignees: $assignees, list: $list, space: $space, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.textContent, textContent) ||
                other.textContent == textContent) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated) &&
            (identical(other.dateUpdated, dateUpdated) ||
                other.dateUpdated == dateUpdated) &&
            (identical(other.timeEstimate, timeEstimate) ||
                other.timeEstimate == timeEstimate) &&
            (identical(other.timeSpent, timeSpent) ||
                other.timeSpent == timeSpent) &&
            const DeepCollectionEquality().equals(
              other._assignees,
              _assignees,
            ) &&
            (identical(other.list, list) || other.list == list) &&
            (identical(other.space, space) || other.space == space) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    textContent,
    status,
    priority,
    dueDate,
    startDate,
    dateCreated,
    dateUpdated,
    timeEstimate,
    timeSpent,
    const DeepCollectionEquality().hash(_assignees),
    list,
    space,
    url,
  );

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(this);
  }
}

abstract class _Task implements Task {
  const factory _Task({
    required final String id,
    required final String name,
    final String? description,
    @JsonKey(name: 'text_content') final String? textContent,
    final TaskStatus? status,
    final TaskPriority? priority,
    @JsonKey(name: 'due_date', fromJson: _epochFromJson) final int? dueDate,
    @JsonKey(name: 'start_date', fromJson: _epochFromJson) final int? startDate,
    @JsonKey(name: 'date_created', fromJson: _epochFromJson)
    final int? dateCreated,
    @JsonKey(name: 'date_updated', fromJson: _epochFromJson)
    final int? dateUpdated,
    @JsonKey(name: 'time_estimate') final int? timeEstimate,
    @JsonKey(name: 'time_spent') final int? timeSpent,
    final List<ClickUpUser> assignees,
    final TaskList? list,
    final TaskSpace? space,
    final String? url,
  }) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'text_content')
  String? get textContent;
  @override
  TaskStatus? get status;
  @override
  TaskPriority? get priority;
  @override
  @JsonKey(name: 'due_date', fromJson: _epochFromJson)
  int? get dueDate;
  @override
  @JsonKey(name: 'start_date', fromJson: _epochFromJson)
  int? get startDate;
  @override
  @JsonKey(name: 'date_created', fromJson: _epochFromJson)
  int? get dateCreated;
  @override
  @JsonKey(name: 'date_updated', fromJson: _epochFromJson)
  int? get dateUpdated;
  @override
  @JsonKey(name: 'time_estimate')
  int? get timeEstimate;
  @override
  @JsonKey(name: 'time_spent')
  int? get timeSpent;
  @override
  List<ClickUpUser> get assignees;
  @override
  TaskList? get list;
  @override
  TaskSpace? get space;
  @override
  String? get url;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskStatus _$TaskStatusFromJson(Map<String, dynamic> json) {
  return _TaskStatus.fromJson(json);
}

/// @nodoc
mixin _$TaskStatus {
  String get status => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get type =>
      throw _privateConstructorUsedError; // e.g. "open", "closed", "done", "custom"
  @JsonKey(name: 'orderindex')
  dynamic get orderIndex => throw _privateConstructorUsedError;

  /// Serializes this TaskStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskStatusCopyWith<TaskStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStatusCopyWith<$Res> {
  factory $TaskStatusCopyWith(
    TaskStatus value,
    $Res Function(TaskStatus) then,
  ) = _$TaskStatusCopyWithImpl<$Res, TaskStatus>;
  @useResult
  $Res call({
    String status,
    String? color,
    String? type,
    @JsonKey(name: 'orderindex') dynamic orderIndex,
  });
}

/// @nodoc
class _$TaskStatusCopyWithImpl<$Res, $Val extends TaskStatus>
    implements $TaskStatusCopyWith<$Res> {
  _$TaskStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? color = freezed,
    Object? type = freezed,
    Object? orderIndex = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            orderIndex: freezed == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskStatusImplCopyWith<$Res>
    implements $TaskStatusCopyWith<$Res> {
  factory _$$TaskStatusImplCopyWith(
    _$TaskStatusImpl value,
    $Res Function(_$TaskStatusImpl) then,
  ) = __$$TaskStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String status,
    String? color,
    String? type,
    @JsonKey(name: 'orderindex') dynamic orderIndex,
  });
}

/// @nodoc
class __$$TaskStatusImplCopyWithImpl<$Res>
    extends _$TaskStatusCopyWithImpl<$Res, _$TaskStatusImpl>
    implements _$$TaskStatusImplCopyWith<$Res> {
  __$$TaskStatusImplCopyWithImpl(
    _$TaskStatusImpl _value,
    $Res Function(_$TaskStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? color = freezed,
    Object? type = freezed,
    Object? orderIndex = freezed,
  }) {
    return _then(
      _$TaskStatusImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        orderIndex: freezed == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as dynamic,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskStatusImpl implements _TaskStatus {
  const _$TaskStatusImpl({
    required this.status,
    this.color,
    this.type,
    @JsonKey(name: 'orderindex') this.orderIndex,
  });

  factory _$TaskStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskStatusImplFromJson(json);

  @override
  final String status;
  @override
  final String? color;
  @override
  final String? type;
  // e.g. "open", "closed", "done", "custom"
  @override
  @JsonKey(name: 'orderindex')
  final dynamic orderIndex;

  @override
  String toString() {
    return 'TaskStatus(status: $status, color: $color, type: $type, orderIndex: $orderIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskStatusImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other.orderIndex,
              orderIndex,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    color,
    type,
    const DeepCollectionEquality().hash(orderIndex),
  );

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskStatusImplCopyWith<_$TaskStatusImpl> get copyWith =>
      __$$TaskStatusImplCopyWithImpl<_$TaskStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskStatusImplToJson(this);
  }
}

abstract class _TaskStatus implements TaskStatus {
  const factory _TaskStatus({
    required final String status,
    final String? color,
    final String? type,
    @JsonKey(name: 'orderindex') final dynamic orderIndex,
  }) = _$TaskStatusImpl;

  factory _TaskStatus.fromJson(Map<String, dynamic> json) =
      _$TaskStatusImpl.fromJson;

  @override
  String get status;
  @override
  String? get color;
  @override
  String? get type; // e.g. "open", "closed", "done", "custom"
  @override
  @JsonKey(name: 'orderindex')
  dynamic get orderIndex;

  /// Create a copy of TaskStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskStatusImplCopyWith<_$TaskStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskPriority _$TaskPriorityFromJson(Map<String, dynamic> json) {
  return _TaskPriority.fromJson(json);
}

/// @nodoc
mixin _$TaskPriority {
  String? get id => throw _privateConstructorUsedError;
  String? get priority =>
      throw _privateConstructorUsedError; // "urgent" | "high" | "normal" | "low"
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this TaskPriority to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskPriority
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskPriorityCopyWith<TaskPriority> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskPriorityCopyWith<$Res> {
  factory $TaskPriorityCopyWith(
    TaskPriority value,
    $Res Function(TaskPriority) then,
  ) = _$TaskPriorityCopyWithImpl<$Res, TaskPriority>;
  @useResult
  $Res call({String? id, String? priority, String? color});
}

/// @nodoc
class _$TaskPriorityCopyWithImpl<$Res, $Val extends TaskPriority>
    implements $TaskPriorityCopyWith<$Res> {
  _$TaskPriorityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskPriority
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? priority = freezed,
    Object? color = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            priority: freezed == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskPriorityImplCopyWith<$Res>
    implements $TaskPriorityCopyWith<$Res> {
  factory _$$TaskPriorityImplCopyWith(
    _$TaskPriorityImpl value,
    $Res Function(_$TaskPriorityImpl) then,
  ) = __$$TaskPriorityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? priority, String? color});
}

/// @nodoc
class __$$TaskPriorityImplCopyWithImpl<$Res>
    extends _$TaskPriorityCopyWithImpl<$Res, _$TaskPriorityImpl>
    implements _$$TaskPriorityImplCopyWith<$Res> {
  __$$TaskPriorityImplCopyWithImpl(
    _$TaskPriorityImpl _value,
    $Res Function(_$TaskPriorityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskPriority
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? priority = freezed,
    Object? color = freezed,
  }) {
    return _then(
      _$TaskPriorityImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        priority: freezed == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskPriorityImpl implements _TaskPriority {
  const _$TaskPriorityImpl({this.id, this.priority, this.color});

  factory _$TaskPriorityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskPriorityImplFromJson(json);

  @override
  final String? id;
  @override
  final String? priority;
  // "urgent" | "high" | "normal" | "low"
  @override
  final String? color;

  @override
  String toString() {
    return 'TaskPriority(id: $id, priority: $priority, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskPriorityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, priority, color);

  /// Create a copy of TaskPriority
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskPriorityImplCopyWith<_$TaskPriorityImpl> get copyWith =>
      __$$TaskPriorityImplCopyWithImpl<_$TaskPriorityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskPriorityImplToJson(this);
  }
}

abstract class _TaskPriority implements TaskPriority {
  const factory _TaskPriority({
    final String? id,
    final String? priority,
    final String? color,
  }) = _$TaskPriorityImpl;

  factory _TaskPriority.fromJson(Map<String, dynamic> json) =
      _$TaskPriorityImpl.fromJson;

  @override
  String? get id;
  @override
  String? get priority; // "urgent" | "high" | "normal" | "low"
  @override
  String? get color;

  /// Create a copy of TaskPriority
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskPriorityImplCopyWith<_$TaskPriorityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskList _$TaskListFromJson(Map<String, dynamic> json) {
  return _TaskList.fromJson(json);
}

/// @nodoc
mixin _$TaskList {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this TaskList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskListCopyWith<TaskList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskListCopyWith<$Res> {
  factory $TaskListCopyWith(TaskList value, $Res Function(TaskList) then) =
      _$TaskListCopyWithImpl<$Res, TaskList>;
  @useResult
  $Res call({String id, String? name});
}

/// @nodoc
class _$TaskListCopyWithImpl<$Res, $Val extends TaskList>
    implements $TaskListCopyWith<$Res> {
  _$TaskListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskList
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
abstract class _$$TaskListImplCopyWith<$Res>
    implements $TaskListCopyWith<$Res> {
  factory _$$TaskListImplCopyWith(
    _$TaskListImpl value,
    $Res Function(_$TaskListImpl) then,
  ) = __$$TaskListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? name});
}

/// @nodoc
class __$$TaskListImplCopyWithImpl<$Res>
    extends _$TaskListCopyWithImpl<$Res, _$TaskListImpl>
    implements _$$TaskListImplCopyWith<$Res> {
  __$$TaskListImplCopyWithImpl(
    _$TaskListImpl _value,
    $Res Function(_$TaskListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = freezed}) {
    return _then(
      _$TaskListImpl(
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
class _$TaskListImpl implements _TaskList {
  const _$TaskListImpl({required this.id, this.name});

  factory _$TaskListImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskListImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;

  @override
  String toString() {
    return 'TaskList(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of TaskList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskListImplCopyWith<_$TaskListImpl> get copyWith =>
      __$$TaskListImplCopyWithImpl<_$TaskListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskListImplToJson(this);
  }
}

abstract class _TaskList implements TaskList {
  const factory _TaskList({required final String id, final String? name}) =
      _$TaskListImpl;

  factory _TaskList.fromJson(Map<String, dynamic> json) =
      _$TaskListImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;

  /// Create a copy of TaskList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskListImplCopyWith<_$TaskListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskSpace _$TaskSpaceFromJson(Map<String, dynamic> json) {
  return _TaskSpace.fromJson(json);
}

/// @nodoc
mixin _$TaskSpace {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this TaskSpace to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskSpace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskSpaceCopyWith<TaskSpace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskSpaceCopyWith<$Res> {
  factory $TaskSpaceCopyWith(TaskSpace value, $Res Function(TaskSpace) then) =
      _$TaskSpaceCopyWithImpl<$Res, TaskSpace>;
  @useResult
  $Res call({String id, String? name});
}

/// @nodoc
class _$TaskSpaceCopyWithImpl<$Res, $Val extends TaskSpace>
    implements $TaskSpaceCopyWith<$Res> {
  _$TaskSpaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskSpace
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
abstract class _$$TaskSpaceImplCopyWith<$Res>
    implements $TaskSpaceCopyWith<$Res> {
  factory _$$TaskSpaceImplCopyWith(
    _$TaskSpaceImpl value,
    $Res Function(_$TaskSpaceImpl) then,
  ) = __$$TaskSpaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? name});
}

/// @nodoc
class __$$TaskSpaceImplCopyWithImpl<$Res>
    extends _$TaskSpaceCopyWithImpl<$Res, _$TaskSpaceImpl>
    implements _$$TaskSpaceImplCopyWith<$Res> {
  __$$TaskSpaceImplCopyWithImpl(
    _$TaskSpaceImpl _value,
    $Res Function(_$TaskSpaceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskSpace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = freezed}) {
    return _then(
      _$TaskSpaceImpl(
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
class _$TaskSpaceImpl implements _TaskSpace {
  const _$TaskSpaceImpl({required this.id, this.name});

  factory _$TaskSpaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskSpaceImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;

  @override
  String toString() {
    return 'TaskSpace(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskSpaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of TaskSpace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskSpaceImplCopyWith<_$TaskSpaceImpl> get copyWith =>
      __$$TaskSpaceImplCopyWithImpl<_$TaskSpaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskSpaceImplToJson(this);
  }
}

abstract class _TaskSpace implements TaskSpace {
  const factory _TaskSpace({required final String id, final String? name}) =
      _$TaskSpaceImpl;

  factory _TaskSpace.fromJson(Map<String, dynamic> json) =
      _$TaskSpaceImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;

  /// Create a copy of TaskSpace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskSpaceImplCopyWith<_$TaskSpaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
