import '../core/api/clickup_client.dart';
import '../core/api/endpoints.dart';
import '../core/result.dart';
import '../models/comment.dart';
import '../models/user.dart';

/// A token in a comment being composed: either literal text or a user mention.
sealed class CommentToken {
  const CommentToken();
}

class TextToken extends CommentToken {
  final String text;
  const TextToken(this.text);
}

class MentionToken extends CommentToken {
  final ClickUpUser user;
  const MentionToken(this.user);
}

/// Reads comments and posts new comments/replies, including @mentions that
/// notify the tagged user.
class CommentRepository {
  final ClickUpClient _client;

  CommentRepository(this._client);

  Future<Result<List<Comment>>> comments(String taskId) async {
    final res = await _client.get(Endpoints.taskComments(taskId));
    return res.when(
      success: (data) {
        final list = ((data as Map)['comments'] as List)
            .map((c) => Comment.fromJson(c as Map<String, dynamic>))
            .toList();
        return Success(list);
      },
      failure: (err) => Failure(err),
    );
  }

  Future<Result<List<Comment>>> thread(String commentId) async {
    final res = await _client.get(Endpoints.commentThread(commentId));
    return res.when(
      success: (data) {
        final list = ((data as Map)['comments'] as List)
            .map((c) => Comment.fromJson(c as Map<String, dynamic>))
            .toList();
        return Success(list);
      },
      failure: (err) => Failure(err),
    );
  }

  /// Builds the rich `comment` array ClickUp expects, converting mention tokens
  /// into `{"type":"tag","user":{"id":...}}` blocks that notify the user.
  static List<Map<String, dynamic>> buildCommentArray(
      List<CommentToken> tokens) {
    final result = <Map<String, dynamic>>[];
    for (final token in tokens) {
      switch (token) {
        case TextToken(:final text):
          if (text.isNotEmpty) result.add({'text': text});
        case MentionToken(:final user):
          result.add({
            'type': 'tag',
            'user': {'id': user.id},
          });
      }
    }
    return result;
  }

  /// Posts a new comment. The create endpoint returns only a loose echo (id,
  /// hist_id, date) — not a full comment — so we don't parse it into a
  /// [Comment]; callers re-fetch the thread. Parsing that partial payload was
  /// the cause of a swallowed exception that left the send button spinning.
  Future<Result<void>> createComment(
    String taskId,
    List<CommentToken> tokens, {
    bool notifyAll = false,
  }) async {
    final res = await _client.post(
      Endpoints.taskComments(taskId),
      data: {
        'comment': buildCommentArray(tokens),
        'notify_all': notifyAll,
      },
    );
    return res.when(
      success: (_) => const Success(null),
      failure: (err) => Failure(err),
    );
  }

  Future<Result<void>> reply(
    String commentId,
    List<CommentToken> tokens, {
    bool notifyAll = false,
  }) async {
    final res = await _client.post(
      Endpoints.commentThread(commentId),
      data: {
        'comment': buildCommentArray(tokens),
        'notify_all': notifyAll,
      },
    );
    return res.when(
      success: (_) => const Success(null),
      failure: (err) => Failure(err),
    );
  }
}
