import 'package:flutter/material.dart';

/// Urgency levels derived from a task's due date, used to color the swatch
/// on the left of each task card.
enum Urgency {
  /// Due date is in the past.
  overdue,

  /// Due within the next 7 days (inclusive).
  soon,

  /// Due more than 7 days out.
  later,

  /// No due date set.
  none,
}

extension UrgencyColor on Urgency {
  Color get color {
    switch (this) {
      case Urgency.overdue:
        return const Color(0xFFE5484D); // red
      case Urgency.soon:
        return const Color(0xFFF5B217); // yellow/amber
      case Urgency.later:
        return const Color(0xFF30A46C); // green
      case Urgency.none:
        return const Color(0xFF3B82F6); // blue
    }
  }

  String get label {
    switch (this) {
      case Urgency.overdue:
        return 'Overdue';
      case Urgency.soon:
        return 'Due soon';
      case Urgency.later:
        return 'Upcoming';
      case Urgency.none:
        return 'No due date';
    }
  }
}

/// Computes urgency from a ClickUp `due_date` (Unix epoch milliseconds, or null).
///
/// [now] is injectable for deterministic tests.
Urgency urgencyForDueDate(int? dueDateMs, {DateTime? now}) {
  if (dueDateMs == null) return Urgency.none;
  final current = now ?? DateTime.now();
  final due = DateTime.fromMillisecondsSinceEpoch(dueDateMs);

  if (due.isBefore(current)) return Urgency.overdue;

  final sevenDaysOut = current.add(const Duration(days: 7));
  // Due within the next 7 days (inclusive of the boundary).
  if (!due.isAfter(sevenDaysOut)) return Urgency.soon;

  return Urgency.later;
}
