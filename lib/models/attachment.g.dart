// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttachmentImpl _$$AttachmentImplFromJson(Map<String, dynamic> json) =>
    _$AttachmentImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      fileExtension: json['extension'] as String?,
      url: json['url'] as String?,
      thumbnailSmall: json['thumbnail_small'] as String?,
      mimeType: json['mimetype'] as String?,
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AttachmentImplToJson(_$AttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'extension': instance.fileExtension,
      'url': instance.url,
      'thumbnail_small': instance.thumbnailSmall,
      'mimetype': instance.mimeType,
      'size': instance.size,
    };
