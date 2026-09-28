import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Customer Notifications Screen (`notif` — Concept 02: Cell 64).
/// Organizes notifications chronologically (Today / Earlier), provides category filtering,
/// unread status pills, and links directly to notification settings.
class CustomerNotificationsPage extends StatefulWidget {
  const CustomerNotificationsPage({super.key});

  @override
  State<CustomerNotificationsPage> createState() => _CustomerNotificationsPageState();
}

class _CustomerNotificationsPageState extends State<CustomerNotificationsPage> {
  String _selectedCategory = 'all'; // 'all', 'orders', 'promo', 'system'

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
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: AppColors.textPrimary),
            onPressed: () {
              unawaited(context.push(AppRoutes.customerNotificationSettings));
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips Row
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                _buildFilterChip('all', context.l10n.notificationsTabAll),
                const SizedBox(width: AppSpacing.xs),
                _buildFilterChip('orders', context.l10n.notificationsTabOrders),
                const SizedBox(width: AppSpacing.xs),
                _buildFilterChip('promo', context.l10n.notificationsTabPromo),
                const SizedBox(width: AppSpacing.xs),
                _buildFilterChip('system', context.l10n.notificationsTabSystem),
              ],
            ),
          ),
          Container(color: AppColors.border, height: 1),

          // Notifications Feed
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // Today Section
                Text(
                  context.l10n.notificationsSectionToday,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildNotificationTile(
                  icon: Icons.navigation_outlined,
                  iconColor: AppColors.primary,
                  iconBg: AppColors.secondarySurface,
                  title: 'Thợ đang di chuyển đến nhà bạn',
                  body: 'Nguyễn Văn Hùng đang trên đường đến (ETA 8 phút). Mã đơn #HS-2026-0012.',
                  time: '13:50',
                  isUnread: true,
                  onTap: () {
                    unawaited(context.push('${AppRoutes.customerTracking}?code=HS-2026-0012'));
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildNotificationTile(
                  icon: Icons.card_giftcard_outlined,
                  iconColor: AppColors.warning,
                  iconBg: const Color(0xFFFEF3C7),
                  title: 'Tặng bạn mã ưu đãi giảm 15%',
                  body: 'Sử dụng mã NHAMOICHI15 cho dịch vụ Vệ sinh & Bảo dưỡng máy lạnh trong tuần này.',
                  time: '09:00',
                  isUnread: true,
                  onTap: () {},
                ),

                const SizedBox(height: AppSpacing.xl),

                // Earlier Section
                Text(
                  context.l10n.notificationsSectionEarlier,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildNotificationTile(
                  icon: Icons.shield_outlined,
                  iconColor: AppColors.primary,
                  iconBg: AppColors.secondarySurface,
                  title: 'Bảo hành điện tử 0đ đã kích hoạt',
                  body: 'Đơn #HS-2026-0008 đã được kích hoạt chế độ bảo hành 30 ngày tự động.',
                  time: '20/09/2026',
                  isUnread: false,
                  onTap: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildNotificationTile(
                  icon: Icons.check_circle_outline_rounded,
                  iconColor: AppColors.success,
                  iconBg: const Color(0xFFE8F5E9),
                  title: 'Thanh toán đơn hàng thành công',
                  body: 'Đã hoàn tất thanh toán 400.000đ cho đơn #HS-2026-0008. Tích lũy +40 điểm Eco-Clean.',
                  time: '20/09/2026',
                  isUnread: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, String label) {
    final isSelected = _selectedCategory == key;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedCategory = key),
        borderRadius: BorderRadius.circular(AppRadius.chip),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.chip),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile({
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
