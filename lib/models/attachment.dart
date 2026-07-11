import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';
part 'attachment.g.dart';

@freezed
class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    String? title,
    @JsonKey(name: 'extension') String? fileExtension,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'thumbnail_small') String? thumbnailSmall,
    @JsonKey(name: 'mimetype') String? mimeType,
    @JsonKey(name: 'size') int? size,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}
