import 'package:flutter/material.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';

/// Top greeting and address header for Customer Home screen.
class HomeTopHeader extends StatelessWidget {
  const HomeTopHeader({
    super.key,
    this.userName = 'Mai',
    this.address,
    this.unreadNotificationsCount = 2,
    this.onAddressTap,
    this.onNotificationTap,
  });

  final String userName;
  final String? address;
  final int unreadNotificationsCount;
  final VoidCallback? onAddressTap;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    final displayAddress = address ?? context.l10n.homeDefaultAddress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row: Address selector & Notification bell
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Address selector pill
            InkWell(
              onTap: onAddressTap,
              borderRadius: BorderRadius.circular(AppRadius.control),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        displayAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),

            // Notification Bell with unread badge dot
            InkWell(
              onTap: onNotificationTap,
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_none_outlined,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                    if (unreadNotificationsCount > 0)
                      Positioned(
                        top: 8,
                        right: 9,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.warning,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // Personal Greeting Text
        Text(
          '${context.l10n.homeGreeting} $userName 👋',
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          context.l10n.homeGreetingSubtitle,
          style: AppTextStyles.bodyMd.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
