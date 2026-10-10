import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// "Hôm nay • 14:00 - 16:00" for a UTC slot start, shown in local time. Slots are 2 hours long.
String bookingScheduleLabel(BuildContext context, DateTime scheduledUtc, {DateTime? now}) {
  final local = scheduledUtc.toLocal();
  final current = now ?? DateTime.now();
  final today = DateTime(current.year, current.month, current.day);
  final day = DateTime(local.year, local.month, local.day);
  final dayLabel = switch (day.difference(today).inDays) {
    0 => context.l10n.bookingScheduleToday,
    1 => context.l10n.bookingScheduleTomorrow,
    _ => DateFormat('dd/MM/yyyy').format(local),
  };
  final time = DateFormat('HH:mm');
  return '$dayLabel • ${time.format(local)} - ${time.format(local.add(const Duration(hours: 2)))}';
}
