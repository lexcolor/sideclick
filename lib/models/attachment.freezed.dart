// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return _Attachment.fromJson(json);
}

/// @nodoc
mixin _$Attachment {
  String get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'extension')
  String? get fileExtension => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail_small')
  String? get thumbnailSmall => throw _privateConstructorUsedError;
  @JsonKey(name: 'mimetype')
  String? get mimeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'size')
  int? get size => throw _privateConstructorUsedError;

  /// Serializes this Attachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
    Attachment value,
    $Res Function(Attachment) then,
  ) = _$AttachmentCopyWithImpl<$Res, Attachment>;
  @useResult
  $Res call({
    String id,
    String? title,
    @JsonKey(name: 'extension') String? fileExtension,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'thumbnail_small') String? thumbnailSmall,
    @JsonKey(name: 'mimetype') String? mimeType,
    @JsonKey(name: 'size') int? size,
  });
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res, $Val extends Attachment>
    implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? fileExtension = freezed,
    Object? url = freezed,
    Object? thumbnailSmall = freezed,
    Object? mimeType = freezed,
    Object? size = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileExtension: freezed == fileExtension
                ? _value.fileExtension
                : fileExtension // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbnailSmall: freezed == thumbnailSmall
                ? _value.thumbnailSmall
                : thumbnailSmall // ignore: cast_nullable_to_non_nullable
                      as String?,
            mimeType: freezed == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            size: freezed == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttachmentImplCopyWith<$Res>
    implements $AttachmentCopyWith<$Res> {
  factory _$$AttachmentImplCopyWith(
    _$AttachmentImpl value,
    $Res Function(_$AttachmentImpl) then,
  ) = __$$AttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? title,
    @JsonKey(name: 'extension') String? fileExtension,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'thumbnail_small') String? thumbnailSmall,
    @JsonKey(name: 'mimetype') String? mimeType,
    @JsonKey(name: 'size') int? size,
  });
}

/// @nodoc
class __$$AttachmentImplCopyWithImpl<$Res>
    extends _$AttachmentCopyWithImpl<$Res, _$AttachmentImpl>
    implements _$$AttachmentImplCopyWith<$Res> {
  __$$AttachmentImplCopyWithImpl(
    _$AttachmentImpl _value,
    $Res Function(_$AttachmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? fileExtension = freezed,
    Object? url = freezed,
    Object? thumbnailSmall = freezed,
    Object? mimeType = freezed,
    Object? size = freezed,
  }) {
    return _then(
      _$AttachmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileExtension: freezed == fileExtension
            ? _value.fileExtension
            : fileExtension // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbnailSmall: freezed == thumbnailSmall
            ? _value.thumbnailSmall
            : thumbnailSmall // ignore: cast_nullable_to_non_nullable
                  as String?,
        mimeType: freezed == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        size: freezed == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentImpl implements _Attachment {
  const _$AttachmentImpl({
    required this.id,
    this.title,
    @JsonKey(name: 'extension') this.fileExtension,
    @JsonKey(name: 'url') this.url,
    @JsonKey(name: 'thumbnail_small') this.thumbnailSmall,
    @JsonKey(name: 'mimetype') this.mimeType,
    @JsonKey(name: 'size') this.size,
  });

  factory _$AttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentImplFromJson(json);

  @override
  final String id;
  @override
  final String? title;
  @override
  @JsonKey(name: 'extension')
  final String? fileExtension;
  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'thumbnail_small')
  final String? thumbnailSmall;
  @override
  @JsonKey(name: 'mimetype')
  final String? mimeType;
  @override
  @JsonKey(name: 'size')
  final int? size;

  @override
  String toString() {
    return 'Attachment(id: $id, title: $title, fileExtension: $fileExtension, url: $url, thumbnailSmall: $thumbnailSmall, mimeType: $mimeType, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.fileExtension, fileExtension) ||
                other.fileExtension == fileExtension) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailSmall, thumbnailSmall) ||
                other.thumbnailSmall == thumbnailSmall) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    fileExtension,
    url,
    thumbnailSmall,
    mimeType,
    size,
  );

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      __$$AttachmentImplCopyWithImpl<_$AttachmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentImplToJson(this);
  }
}

abstract class _Attachment implements Attachment {
  const factory _Attachment({
    required final String id,
    final String? title,
    @JsonKey(name: 'extension') final String? fileExtension,
    @JsonKey(name: 'url') final String? url,
    @JsonKey(name: 'thumbnail_small') final String? thumbnailSmall,
    @JsonKey(name: 'mimetype') final String? mimeType,
    @JsonKey(name: 'size') final int? size,
  }) = _$AttachmentImpl;

  factory _Attachment.fromJson(Map<String, dynamic> json) =
      _$AttachmentImpl.fromJson;

  @override
  String get id;
  @override
  String? get title;
  @override
  @JsonKey(name: 'extension')
  String? get fileExtension;
  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'thumbnail_small')
  String? get thumbnailSmall;
  @override
  @JsonKey(name: 'mimetype')
  String? get mimeType;
  @override
  @JsonKey(name: 'size')
  int? get size;

  /// Create a copy of Attachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
