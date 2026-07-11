import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../providers/auth_provider.dart';
import '../../repositories/comment_repository.dart';

/// A comment composer that supports @mentions. Inserted mentions are rendered
/// as chips above the text field and included in the emitted [CommentToken]
/// list so tagged users get notified.
///
/// The composition model is simple and predictable: any pending text is a
/// [TextToken], and each inserted mention is a [MentionToken] placed in the
/// order it was added. On send it emits `[text?, mention, text?, mention, …]`.
class MentionField extends ConsumerStatefulWidget {
  final String hintText;
  final bool sending;
  final void Function(List<CommentToken> tokens, bool notifyAll) onSend;

  const MentionField({
    super.key,
    required this.onSend,
    this.hintText = 'Write a comment…',
    this.sending = false,
  });

  @override
  ConsumerState<MentionField> createState() => _MentionFieldState();
}

class _MentionFieldState extends ConsumerState<MentionField> {
  final _controller = TextEditingController();
  final _tokens = <CommentToken>[];
  bool _notifyAll = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flushText() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      _tokens.add(TextToken(text));
      _controller.clear();
    }
  }

  void _addMention(ClickUpUser user) {
    _flushText();
    setState(() => _tokens.add(MentionToken(user)));
  }

  void _removeToken(int index) {
    setState(() => _tokens.removeAt(index));
  }

  void _send() {
    _flushText();
    if (_tokens.isEmpty) return;
    widget.onSend(List.of(_tokens), _notifyAll);
    setState(() {
      _tokens.clear();
      _controller.clear();
    });
  }

  Future<void> _pickMention() async {
    final members = _members();
    if (members.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No members available to mention.')),
      );
      return;
    }
    final user = await showModalBottomSheet<ClickUpUser>(
      context: context,
      builder: (_) => _MemberPicker(members: members),
    );
    if (user != null) _addMention(user);
  }

  List<ClickUpUser> _members() {
    final ws = ref.read(authControllerProvider).selectedWorkspace;
    if (ws == null) return const [];
    return ws.members.map((m) => m.user).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_tokens.whereType<MentionToken>().isNotEmpty)
            Wrap(
              spacing: 6,
              children: [
                for (var i = 0; i < _tokens.length; i++)
                  if (_tokens[i] is MentionToken)
                    Chip(
                      avatar: const Icon(Icons.alternate_email, size: 16),
                      label: Text(
                        (_tokens[i] as MentionToken).user.username ??
                            'user ${(_tokens[i] as MentionToken).user.id}',
                      ),
                      onDeleted: () => _removeToken(i),
                    ),
              ],
            ),
          Row(
            children: [
              IconButton(
                tooltip: 'Mention someone',
                icon: const Icon(Icons.alternate_email),
                onPressed: widget.sending ? null : _pickMention,
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton.filled(
                onPressed: widget.sending ? null : _send,
                icon: widget.sending
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _notifyAll,
                onChanged: (v) => setState(() => _notifyAll = v ?? false),
              ),
              const Text('Notify all watchers'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MemberPicker extends StatelessWidget {
  final List<ClickUpUser> members;
  const _MemberPicker({required this.members});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          const ListTile(
            title: Text('Mention someone',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          for (final user in members)
            ListTile(
              leading: CircleAvatar(
                child: Text(
                  (user.username ?? user.email ?? '?')
                      .characters
                      .first
                      .toUpperCase(),
                ),
              ),
              title: Text(user.username ?? user.email ?? 'user ${user.id}'),
              subtitle: user.email != null ? Text(user.email!) : null,
              onTap: () => Navigator.of(context).pop(user),
            ),
        ],
      ),
    );
  }
}
