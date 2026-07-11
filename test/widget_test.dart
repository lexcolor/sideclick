import 'package:flutter_test/flutter_test.dart';
import 'package:sideclick/core/api/endpoints.dart';
import 'package:sideclick/utils/urgency.dart';
import 'package:sideclick/repositories/comment_repository.dart';
import 'package:sideclick/models/user.dart';

void main() {
  group('urgencyForDueDate', () {
    final now = DateTime(2026, 7, 10, 12, 0);

    test('null due date -> none (blue)', () {
      expect(urgencyForDueDate(null, now: now), Urgency.none);
    });

    test('past due date -> overdue (red)', () {
      final past = now.subtract(const Duration(days: 1));
      expect(urgencyForDueDate(past.millisecondsSinceEpoch, now: now),
          Urgency.overdue);
    });

    test('due within 7 days -> soon (yellow)', () {
      final soon = now.add(const Duration(days: 3));
      expect(urgencyForDueDate(soon.millisecondsSinceEpoch, now: now),
          Urgency.soon);
    });

    test('boundary at exactly 7 days -> soon', () {
      final boundary = now.add(const Duration(days: 7));
      expect(urgencyForDueDate(boundary.millisecondsSinceEpoch, now: now),
          Urgency.soon);
    });

    test('more than 7 days out -> later (green)', () {
      final later = now.add(const Duration(days: 10));
      expect(urgencyForDueDate(later.millisecondsSinceEpoch, now: now),
          Urgency.later);
    });
  });

  group('endpoints', () {
    test('teams endpoint is /team (not the deprecated /user/team)', () {
      // The older /user/team path now returns 404; regression guard.
      expect(Endpoints.teams, '/team');
    });
  });

  group('buildCommentArray', () {
    test('interleaves text and mention tags', () {
      final tokens = <CommentToken>[
        const TextToken('Hey '),
        MentionToken(const ClickUpUser(id: 42, username: 'lex')),
        const TextToken(' please review'),
      ];
      final array = CommentRepository.buildCommentArray(tokens);
      expect(array, [
        {'text': 'Hey '},
        {
          'type': 'tag',
          'user': {'id': 42}
        },
        {'text': ' please review'},
      ]);
    });

    test('drops empty text fragments', () {
      final array = CommentRepository.buildCommentArray([const TextToken('')]);
      expect(array, isEmpty);
    });
  });
}
