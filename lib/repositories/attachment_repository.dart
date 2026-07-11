import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/api/clickup_client.dart';
import '../core/api/endpoints.dart';
import '../core/result.dart';
import '../models/attachment.dart';

/// Lists and uploads task attachments. ClickUp does not expose a GET list of
/// attachments separate from the task, so [attachments] reads them from the
/// task payload's `attachments` field.
class AttachmentRepository {
  final ClickUpClient _client;

  AttachmentRepository(this._client);

  Future<Result<List<Attachment>>> attachments(String taskId) async {
    // The task detail endpoint includes an `attachments` array.
    final res = await _client.get(Endpoints.task(taskId),
        query: {'include_subtasks': false});
    return res.when(
      success: (data) {
        final raw = (data as Map)['attachments'];
        final list = (raw is List)
            ? raw
                .map((a) => Attachment.fromJson(a as Map<String, dynamic>))
                .toList()
            : <Attachment>[];
        return Success(list);
      },
      failure: (err) => Failure(err),
    );
  }

  /// Downloads an attachment to a local cache file and returns its path, ready
  /// to be handed to the OS default app. Uses a fresh Dio (no base URL / auth
  /// header) since ClickUp attachment URLs are absolute and often pre-signed.
  Future<Result<String>> download(Attachment attachment) async {
    final url = attachment.url;
    if (url == null || url.isEmpty) {
      return const Failure(
          AppError(AppErrorKind.notFound, 'This attachment has no URL.'));
    }
    try {
      final dir = await getTemporaryDirectory();
      final cacheDir = Directory(p.join(dir.path, 'attachments'));
      if (!await cacheDir.exists()) await cacheDir.create(recursive: true);

      final fileName = _safeFileName(attachment);
      final filePath = p.join(cacheDir.path, '${attachment.id}_$fileName');

      final dio = Dio();
      await dio.download(url, filePath);
      return Success(filePath);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      return Failure(AppError(
        AppErrorKind.network,
        'Download failed: ${e.message}',
        statusCode: status,
      ));
    } catch (e) {
      return Failure(AppError(AppErrorKind.unknown, 'Download failed: $e'));
    }
  }

  /// Builds a filesystem-safe filename, preserving the extension so the OS can
  /// pick the right app.
  String _safeFileName(Attachment a) {
    var name = a.title?.trim();
    if (name == null || name.isEmpty) {
      name = 'attachment';
    }
    // Ensure an extension is present.
    final ext = a.fileExtension;
    if (ext != null && ext.isNotEmpty && !name.toLowerCase().endsWith('.$ext'.toLowerCase())) {
      name = '$name.$ext';
    }
    // Strip characters that are illegal on common filesystems.
    return name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  /// Uploads a local file to the task as an attachment (multipart/form-data).
  Future<Result<Attachment>> upload(String taskId, String filePath) async {
    try {
      final fileName = p.basename(filePath);
      final form = FormData.fromMap({
        'attachment': await MultipartFile.fromFile(filePath, filename: fileName),
      });
      final res = await _client.raw.post(
        Endpoints.taskAttachments(taskId),
        data: form,
      );
      return Success(Attachment.fromJson(res.data as Map<String, dynamic>));
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      return Failure(AppError(
        status == 401 || status == 403
            ? AppErrorKind.unauthorized
            : AppErrorKind.unknown,
        'Upload failed: ${e.message}',
        statusCode: status,
      ));
    } catch (e) {
      return Failure(AppError(AppErrorKind.unknown, 'Upload failed: $e'));
    }
  }
}
