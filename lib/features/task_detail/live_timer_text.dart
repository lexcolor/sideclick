import 'dart:async';

import 'package:flutter/material.dart';

/// Shows the elapsed time of a running timer, ticking once per second.
///
/// [startEpochMs] is the timer's start time (epoch milliseconds). The widget
/// derives elapsed time from the wall clock, so it stays accurate across
/// rebuilds and while the app is backgrounded.
class LiveTimerText extends StatefulWidget {
  final int startEpochMs;
  final TextStyle? style;

  const LiveTimerText({super.key, required this.startEpochMs, this.style});

  @override
  State<LiveTimerText> createState() => _LiveTimerTextState();
}

class _LiveTimerTextState extends State<LiveTimerText> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(
        const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = DateTime.now().millisecondsSinceEpoch - widget.startEpochMs;
    return Text(_fmtClock(elapsed < 0 ? 0 : elapsed), style: widget.style);
  }
}

/// Formats a duration as a running clock: `H:MM:SS` (or `MM:SS` under an hour).
String _fmtClock(int ms) {
  final d = Duration(milliseconds: ms);
  final h = d.inHours;
  final m = d.inMinutes % 60;
  final s = d.inSeconds % 60;
  final mm = m.toString().padLeft(2, '0');
  final ss = s.toString().padLeft(2, '0');
  return h > 0 ? '$h:$mm:$ss' : '$mm:$ss';
}
