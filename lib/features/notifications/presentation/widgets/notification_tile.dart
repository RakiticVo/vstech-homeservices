import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';

/// One notification: neutral type icon + type label, title, body, local time. Unread items get a
/// primary hairline, bold title and an "Unread" dot + label (never colour alone).
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final unread = !notification.isRead;
    final (IconData icon, String typeLabel) = switch (notification.type) {
      NotificationType.booking => (
        Icons.assignment_outlined,
        l10n.notificationsTabOrders,
      ),
      NotificationType.promo => (
        Icons.local_offer_outlined,
        l10n.notificationsTabPromo,
      ),
      NotificationType.system => (
        Icons.info_outline_rounded,
        l10n.notificationsTabSystem,
      ),
      NotificationType.unknown => (
        Icons.notifications_none_rounded,
        l10n.notificationsTypeOther,
      ),
    };
    final createdAt = notification.createdAt?.toLocal();
    final now = DateTime.now();
    final time = createdAt == null
        ? null
        : (createdAt.year == now.year &&
              createdAt.month == now.month &&
              createdAt.day == now.day)
        ? DateFormat('HH:mm').format(createdAt)
        : DateFormat('dd/MM/yyyy HH:mm').format(createdAt);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: unread ? AppColors.primary : AppColors.border,
              width: unread ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 22, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: unread ? FontWeight.w700 : FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (notification.body.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        notification.body,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          typeLabel,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        if (time != null)
                          Text(
                            time,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        if (unread)
                          Row(
                            key: const Key('notification_unread_badge'),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                l10n.notificationsUnread,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primaryPressed,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
