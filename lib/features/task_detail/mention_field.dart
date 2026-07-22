import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';
import '../../providers/auth_provider.dart';
import '../../repositories/comment_repository.dart';

/// A comment composer that supports @mentions. Inserted mentions are rendered
/// as chips above the text field and included in the emitted [CommentToken]
/// list so tagged users get notified.
///
/// Typing "@" starts an inline mention search — matching members appear in a
/// list right above the field and narrow as you keep typing, same as the
/// ClickUp web app. The @ button opens the same searchable list as a sheet,
/// for picking a mention without typing a name.
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

  /// Text typed after an active "@" trigger, or null when not searching.
  String? _mentionQuery;
  int? _mentionStart;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _controller.text;
    final cursor = _controller.selection.baseOffset;
    if (cursor < 0) {
      if (_mentionQuery != null) setState(() => _mentionQuery = null);
      return;
    }

    var i = cursor - 1;
    while (i >= 0 && text[i] != '@' && text[i] != ' ' && text[i] != '\n') {
      i--;
    }
    final atStart = i >= 0 &&
        text[i] == '@' &&
        (i == 0 || text[i - 1] == ' ' || text[i - 1] == '\n');
    if (atStart) {
      setState(() {
        _mentionQuery = text.substring(i + 1, cursor);
        _mentionStart = i;
      });
    } else if (_mentionQuery != null) {
      setState(() {
        _mentionQuery = null;
        _mentionStart = null;
      });
    }
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

  /// Replaces the in-progress "@query" with a mention token, keeping any text
  /// typed before the "@" and after the cursor.
  void _selectMentionSuggestion(ClickUpUser user) {
    final start = _mentionStart;
    if (start == null) {
      _addMention(user);
      return;
    }
    final text = _controller.text;
    final cursor = _controller.selection.baseOffset;
    final end = cursor < 0 ? text.length : cursor;
    final before = text.substring(0, start);
    final after = text.substring(end);

    if (before.isNotEmpty) _tokens.add(TextToken(before));
    setState(() {
      _tokens.add(MentionToken(user));
      _mentionQuery = null;
      _mentionStart = null;
    });
    _controller.text = after;
    _controller.selection = const TextSelection.collapsed(offset: 0);
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
      isScrollControlled: true,
      builder: (_) => _MemberPicker(members: members),
    );
    if (user != null) _addMention(user);
  }

  List<ClickUpUser> _members() {
    final ws = ref.read(authControllerProvider).selectedWorkspace;
    if (ws == null) return const [];
    return ws.members.map((m) => m.user).toList();
  }

  List<ClickUpUser> _filteredMembers(String query) {
    final members = _members();
    if (query.isEmpty) return members;
    final q = query.toLowerCase();
    return members
        .where((m) =>
            (m.username?.toLowerCase().contains(q) ?? false) ||
            (m.email?.toLowerCase().contains(q) ?? false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = _mentionQuery;
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
          if (query != null)
            _MentionSuggestions(
              members: _filteredMembers(query),
              onSelect: _selectMentionSuggestion,
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

/// Live-filtering member list shown above the text field while an "@query" is
/// being typed.
class _MentionSuggestions extends StatelessWidget {
  final List<ClickUpUser> members;
  final void Function(ClickUpUser user) onSelect;

  const _MentionSuggestions({required this.members, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(maxHeight: 176),
      margin: const EdgeInsets.only(bottom: 6),
      // ListTile paints its ink/background on the nearest Material ancestor,
      // so the rounded background+border live on this Material's own shape
      // rather than a DecoratedBox wrapper (which would hide that painting).
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: theme.dividerColor),
        ),
        child: members.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: Text('No matching members'),
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: members.length,
                itemBuilder: (_, i) {
                  final user = members[i];
                  return _MemberTile(user: user, onTap: () => onSelect(user));
                },
              ),
      ),
    );
  }
}

class _MemberPicker extends StatefulWidget {
  final List<ClickUpUser> members;
  const _MemberPicker({required this.members});

  @override
  State<_MemberPicker> createState() => _MemberPickerState();
}

class _MemberPickerState extends State<_MemberPicker> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ClickUpUser> get _filtered {
    if (_query.isEmpty) return widget.members;
    final q = _query.toLowerCase();
    return widget.members
        .where((m) =>
            (m.username?.toLowerCase().contains(q) ?? false) ||
            (m.email?.toLowerCase().contains(q) ?? false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Mention someone',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search members…',
                  prefixIcon: Icon(Icons.search),
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: filtered.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('No matching members'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final user = filtered[i];
                        return _MemberTile(
                          user: user,
                          onTap: () => Navigator.of(context).pop(user),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final ClickUpUser user;
  final VoidCallback onTap;
  const _MemberTile({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: CircleAvatar(
        child: Text(
          (user.username ?? user.email ?? '?').characters.first.toUpperCase(),
        ),
      ),
      title: Text(user.username ?? user.email ?? 'user ${user.id}'),
      subtitle: user.email != null ? Text(user.email!) : null,
      onTap: onTap,
    );
  }
}
