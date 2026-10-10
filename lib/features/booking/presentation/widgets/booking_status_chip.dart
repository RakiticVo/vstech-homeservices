import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';

/// Booking status as Icon + Label + Color together (never colour alone).
class BookingStatusChip extends StatelessWidget {
  const BookingStatusChip({required this.status, super.key});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, label, color) = switch (status) {
      BookingStatus.pending => (Icons.radar_rounded, l10n.bookingStatusPending, AppColors.warning),
      BookingStatus.accepted => (Icons.how_to_reg_outlined, l10n.bookingStatusAccepted, AppColors.primary),
      BookingStatus.inProgress => (Icons.handyman_outlined, l10n.bookingStatusInProgress, AppColors.primary),
      BookingStatus.completed => (Icons.check_circle_outline, l10n.bookingStatusCompleted, AppColors.successDark),
      BookingStatus.cancelled => (Icons.cancel_outlined, l10n.bookingStatusCancelled, AppColors.textSecondary),
      BookingStatus.dispute => (Icons.gavel_outlined, l10n.bookingStatusDispute, AppColors.error),
      BookingStatus.dispatchFailed => (Icons.person_search_outlined, l10n.bookingStatusDispatchFailed, AppColors.error),
      BookingStatus.unknown => (Icons.help_outline, l10n.bookingStatusUnknown, AppColors.textSecondary),
    };
    return Container(
      key: Key('booking_status_${status.name}'),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
