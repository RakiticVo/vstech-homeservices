import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker Notifications Screen (`wnotif` — Concept 02: Cell 66).
/// Tailored alerts for dispatch assignments, wallet credits, ratings, and labor safety.
class WorkerNotificationsPage extends StatelessWidget {
  const WorkerNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          context.l10n.notificationsTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.notificationsMarkAllRead)),
              );
            },
            child: Text(
              context.l10n.notificationsMarkAllRead,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Today
          Text(
            context.l10n.notificationsSectionToday,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildWorkerNotifTile(
            context: context,
            icon: Icons.assignment_outlined,
            iconColor: AppColors.primary,
            iconBg: AppColors.secondarySurface,
            title: 'Yêu cầu công việc mới điều phối',
            body: 'Bạn có 1 yêu cầu tại Flora Novia, TP. Thủ Đức (+340.000đ). Vui lòng phản hồi sớm.',
            time: '13:45',
            isUnread: true,
            onTap: () {
              unawaited(context.push(AppRoutes.workerJobDetail));
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildWorkerNotifTile(
            context: context,
            icon: Icons.account_balance_wallet_outlined,
            iconColor: AppColors.success,
            iconBg: const Color(0xFFE8F5E9),
            title: 'Tiền đã cộng vào ví thu nhập',
            body: '+340.000đ đã được cộng vào ví của bạn sau khi khách hàng thanh toán.',
            time: '11:20',
            isUnread: true,
            onTap: () {},
          ),

          const SizedBox(height: AppSpacing.xl),

          // Earlier
          Text(
            context.l10n.notificationsSectionEarlier,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildWorkerNotifTile(
            context: context,
            icon: Icons.star_outline_rounded,
            iconColor: AppColors.warning,
            iconBg: const Color(0xFFFEF3C7),
            title: 'Khách hàng vừa đánh giá 5★',
            body: '"Thợ nhiệt tình, làm sạch sẽ, đúng giờ." Đơn hàng #HS-2026-0008.',
            time: '20/09/2026',
            isUnread: false,
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildWorkerNotifTile(
            context: context,
            icon: Icons.shield_outlined,
            iconColor: AppColors.primary,
            iconBg: AppColors.secondarySurface,
            title: 'Nhắc nhở an toàn lao động',
            body: 'Luôn ngắt cầu dao tổng và mang găng tay bảo hộ cách điện khi thi công điện nước.',
            time: '18/09/2026',
            isUnread: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildWorkerNotifTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String body,
    required String time,
    required bool isUnread,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isUnread ? AppColors.surface : AppColors.surface.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(
            color: isUnread ? AppColors.primary.withValues(alpha: 0.3) : AppColors.border,
            width: isUnread ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.labelMedium.copyWith(
                            fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    time,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
