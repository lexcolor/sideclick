import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/comment.dart';
import '../../providers/core_providers.dart';
import '../../providers/detail_providers.dart';
import '../../repositories/comment_repository.dart';
import 'mention_field.dart';

class CommentsTab extends ConsumerStatefulWidget {
  final String taskId;
  const CommentsTab({super.key, required this.taskId});

  @override
  ConsumerState<CommentsTab> createState() => _CommentsTabState();
}

class _CommentsTabState extends ConsumerState<CommentsTab> {
  bool _sending = false;

  Future<void> _send(List<CommentToken> tokens, bool notifyAll) async {
    setState(() => _sending = true);
    final repo = ref.read(commentRepositoryProvider);
    try {
      final res =
          await repo.createComment(widget.taskId, tokens, notifyAll: notifyAll);
      if (!mounted) return;
      res.when(
        success: (_) {
          ref.invalidate(taskCommentsProvider(widget.taskId));
        },
        failure: (err) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.message)),
          );
        },
      );
    } finally {
      // Always clear the spinner — otherwise a failure (or an unexpected
      // parse error while reading the create response) strands the send
      // button spinning even though the comment was posted server-side.
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(taskCommentsProvider(widget.taskId));

    return Column(
      children: [
        Expanded(
          child: comments.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => _RetryView(
              message: '$e',
              onRetry: () =>
                  ref.invalidate(taskCommentsProvider(widget.taskId)),
            ),
            data: (list) {
              return RefreshIndicator(
                onRefresh: () async =>
                    ref.invalidate(taskCommentsProvider(widget.taskId)),
                child: list.isEmpty
                    ? ListView(
                        // Needs to be scrollable so pull-to-refresh works.
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(child: Text('No comments yet.')),
                          ),
                        ],
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: list.length,
                        itemBuilder: (_, i) => _CommentBubble(comment: list[i]),
                      ),
              );
            },
          ),
        ),
        MentionField(onSend: _send, sending: _sending),
      ],
    );
  }
}

class _CommentBubble extends StatelessWidget {
  final Comment comment;
  const _CommentBubble({required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final author = comment.user?.username ?? comment.user?.email ?? 'Unknown';
    final when = comment.date != null
        ? DateFormat.yMMMd().add_jm().format(
            DateTime.fromMillisecondsSinceEpoch(comment.date!))
        : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                child: Text(author.characters.first.toUpperCase(),
                    style: const TextStyle(fontSize: 11)),
              ),
              const SizedBox(width: 8),
              Text(author,
                  style: theme.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(when,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: theme.colorScheme.outline)),
            ],
          ),
          const SizedBox(height: 6),
          _CommentBody(comment: comment),
          if (comment.replyCount > 0) ...[
            const SizedBox(height: 6),
            Text('${comment.replyCount} repl${comment.replyCount == 1 ? 'y' : 'ies'}',
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: theme.colorScheme.primary)),
          ],
        ],
      ),
    );
  }
}

/// Renders a comment as rich text, styling @mentions distinctly. Falls back to
/// the flattened `comment_text` when no fragments are present.
class _CommentBody extends StatelessWidget {
  final Comment comment;
  const _CommentBody({required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (comment.fragments.isEmpty) {
      return Text(comment.commentText ?? '');
    }
    return Text.rich(
      TextSpan(
        style: theme.textTheme.bodyMedium,
        children: [
          for (final f in comment.fragments)
            if (f.type == 'tag' && f.user != null)
              TextSpan(
                text: '@${f.user!.username ?? f.user!.id}',
                style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600),
              )
            else
              TextSpan(text: f.text),
        ],
      ),
    );
  }
}

class _RetryView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _RetryView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 8),
          FilledButton.tonal(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
