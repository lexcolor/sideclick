import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';

import '../../models/attachment.dart';
import '../../providers/core_providers.dart';
import '../../providers/detail_providers.dart';

class AttachmentsTab extends ConsumerStatefulWidget {
  final String taskId;
  const AttachmentsTab({super.key, required this.taskId});

  @override
  ConsumerState<AttachmentsTab> createState() => _AttachmentsTabState();
}

class _AttachmentsTabState extends ConsumerState<AttachmentsTab> {
  bool _uploading = false;

  /// Ids of attachments currently downloading (for a per-row spinner).
  final Set<String> _downloading = {};

  Future<void> _upload() async {
    final picked = await FilePicker.platform.pickFiles();
    final path = picked?.files.single.path;
    if (path == null) return;

    setState(() => _uploading = true);
    final res =
        await ref.read(attachmentRepositoryProvider).upload(widget.taskId, path);
    if (!mounted) return;
    setState(() => _uploading = false);
    res.when(
      success: (_) {
        ref.invalidate(taskAttachmentsProvider(widget.taskId));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Uploaded.')),
        );
      },
      failure: (err) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.message))),
    );
  }

  /// Downloads the attachment locally, then hands it to the OS default app.
  Future<void> _open(Attachment a) async {
    if (_downloading.contains(a.id)) return;
    setState(() => _downloading.add(a.id));

    final res = await ref.read(attachmentRepositoryProvider).download(a);
    if (!mounted) return;
    setState(() => _downloading.remove(a.id));

    await res.when(
      success: (path) async {
        final result = await OpenFilex.open(path);
        if (result.type != ResultType.done && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open file: ${result.message}')),
          );
        }
      },
      failure: (err) async {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(err.message)));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final attachments = ref.watch(taskAttachmentsProvider(widget.taskId));

    return Scaffold(
      body: attachments.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('No attachments.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: list.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final a = list[i];
              final busy = _downloading.contains(a.id);
              return ListTile(
                leading: _thumb(a),
                title: Text(a.title ?? 'Attachment',
                    overflow: TextOverflow.ellipsis),
                subtitle: Text(_sizeLabel(a.size)),
                trailing: busy
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download_for_offline_outlined),
                onTap: busy ? null : () => _open(a),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _uploading ? null : _upload,
        icon: _uploading
            ? const SizedBox(
                height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
            : const Icon(Icons.upload_file),
        label: const Text('Upload'),
      ),
    );
  }

  Widget _thumb(Attachment a) {
    if (a.thumbnailSmall != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(a.thumbnailSmall!,
            width: 40, height: 40, fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const Icon(Icons.insert_drive_file)),
      );
    }
    return const Icon(Icons.insert_drive_file, size: 36);
  }

  String _sizeLabel(int? bytes) {
    if (bytes == null) return '';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
