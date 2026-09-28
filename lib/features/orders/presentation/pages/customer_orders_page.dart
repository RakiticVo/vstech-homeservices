import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/customer_floating_dock.dart';

/// Customer Orders Hub Screen (`orders` — Concept 02: Cells 36–39).
/// Features 3 distinct tabs: Active (Đang làm), Scheduled (Đang chờ), Completed (Hoàn thành),
/// with empty state handling and fixed floating capsule bottom dock.
class CustomerOrdersPage extends StatefulWidget {
  const CustomerOrdersPage({
    super.key,
    this.initialTab = 0,
  });

  final int initialTab;

  @override
  State<CustomerOrdersPage> createState() => _CustomerOrdersPageState();
}

class _CustomerOrdersPageState extends State<CustomerOrdersPage> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  String _formatPrice(int amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  void _onDockTabSelected(int index) {
    if (index == 1) return; // already here
    if (index == 0) {
      unawaited(context.push(AppRoutes.customerHome));
    } else if (index == 3) {
      unawaited(context.push(AppRoutes.customerNotifications));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          context.l10n.ordersTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Segmented Tabs Filter (3 Tabs)
              Container(
                color: AppColors.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    _buildFilterTab(0, context.l10n.ordersTabActive),
                    const SizedBox(width: AppSpacing.sm),
                    _buildFilterTab(1, context.l10n.ordersTabScheduled),
                    const SizedBox(width: AppSpacing.sm),
                    _buildFilterTab(2, context.l10n.ordersTabCompleted),
                  ],
                ),
              ),
              Container(color: AppColors.border, height: 1),

              // Tab Content Body
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.dockClearanceMax,
                  ),
                  children: [
                    if (_selectedTab == 0) ...[
                      // Active Orders (Cell 36, 37)
                      _buildActiveOrderCard(
                        code: 'HS-2026-0012',
                        serviceName: 'Dọn dẹp căn hộ tiêu chuẩn',
                        schedule: 'Hôm nay · 14:00 - 16:00',
                        workerName: 'Nguyễn Văn Hùng',
                        workerRating: '4.9 ★',
                        stageText: context.l10n.trackingStageEnRoute,
                        price: 400000,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // Warranty Active Job (Cell 91)
                      _buildActiveWarrantyOrderCard(
                        code: '#BH20250425-0087',
                        serviceName: context.l10n.ordersActiveWarrantyTitle,
                        schedule: 'Mai 26/04 · 08:00 - 10:00',
                        workerName: 'Trần Văn Hùng',
                        workerRating: '5.0 ★',
                        stageText: context.l10n.warrantyStepAccepted,
                      ),
                    ] else if (_selectedTab == 1) ...[
                      // Scheduled Orders (Cell 37)
                      _buildScheduledOrderCard(
                        code: 'HS-2026-0014',
                        serviceName: 'Vệ sinh & Bảo dưỡng Máy lạnh Inverter',
                        schedule: 'Ngày mai · 09:00 - 11:00',
                        address: 'Căn hộ 802, Tháp B, Flora Novia, TP. Thủ Đức',
                        price: 450000,
                      ),
                    ] else ...[
                      // Completed Orders (Cell 38 & Cell 91 Warranty Chip)
                      _buildCompletedOrderCard(
                        code: 'HS-20250318-0087',
                        serviceName: 'Vệ sinh & Bảo dưỡng Máy lạnh Inverter',
                        completedAt: '18/03/2026 · 10:30',
                        price: 450000,
                        warrantyChipText: context.l10n.ordersWarrantyActiveChip,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildCompletedOrderCard(
                        code: 'HS-2026-0008',
                        serviceName: 'Sửa chữa & Thay ron vòi sen tăng áp',
                        completedAt: '20/09/2026 · 15:30',
                        price: 400000,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Floating Capsule Bottom Dock
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomerFloatingDock(
              currentIndex: 1, // Orders tab active
              onTabSelected: _onDockTabSelected,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(int index, String label) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(AppRadius.control),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveOrderCard({
    required String code,
    required String serviceName,
    required String schedule,
    required String workerName,
    required String workerRating,
    required String stageText,
    required int price,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  code,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.navigation_outlined, size: 14, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      stageText,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            serviceName,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  schedule,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.secondarySurface,
                      child: Icon(Icons.person, color: AppColors.primary, size: 18),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workerName,
                            style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            workerRating,
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _formatPrice(price),
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    unawaited(context.push('${AppRoutes.customerOrderDetail}?code=$code'));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.ordersViewDetailCta,
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: context.l10n.ordersTrackWorkerCta,
                  icon: Icons.map_outlined,
                  onPressed: () {
                    unawaited(context.push('${AppRoutes.customerTracking}?code=$code'));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledOrderCard({
    required String code,
    required String serviceName,
    required String schedule,
    required String address,
    required int price,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  code,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: const Color(0xFF93C5FD)),
                ),
                child: Text(
                  context.l10n.ordersTabScheduled,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: const Color(0xFF2563EB),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            serviceName,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.calendar_today_rounded, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  schedule,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  address,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.l10n.orderDetailPriceCard,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _formatPrice(price),
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    unawaited(context.push('${AppRoutes.customerOrderDetail}?code=$code'));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.ordersViewDetailCta,
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveWarrantyOrderCard({
    required String code,
    required String serviceName,
    required String schedule,
    required String workerName,
    required String workerRating,
    required String stageText,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F1EA),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        context.l10n.warrantyBadgeTag,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: const Color(0xFF0E5952),
                          fontWeight: FontWeight.w800,
                          fontSize: 9.5,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(
                      child: Text(
                        code,
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondarySurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Text(
                  stageText,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            serviceName,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.schedule_rounded, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  schedule,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '$workerName ($workerRating)',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.orderDetailPriceCard,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
              ),
              Text(
                '0đ',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    unawaited(context.push('${AppRoutes.customerOrderDetail}?code=$code'));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.ordersViewDetailCta,
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: context.l10n.warrantyStatusTitle,
                  icon: Icons.track_changes_rounded,
                  onPressed: () {
                    unawaited(context.push(AppRoutes.warrantyStatus));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedOrderCard({
    required String code,
    required String serviceName,
    required String completedAt,
    required int price,
    String? warrantyChipText,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  code,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                  border: Border.all(color: AppColors.success),
                ),
                child: Text(
                  context.l10n.orderDetailPaidStatus,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.successDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          if (warrantyChipText != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondarySurface,
                borderRadius: BorderRadius.circular(AppRadius.control),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_outlined, size: 16, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      warrantyChipText,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  InkWell(
                    onTap: () {
                      unawaited(context.push('${AppRoutes.warrantyCertificate}?code=$code'));
                    },
                    child: Text(
                      context.l10n.ordersViewWarrantyCertCta,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Text(
            serviceName,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded, size: 16, color: AppColors.success),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  completedAt,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.l10n.orderDetailPriceCard,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _formatPrice(price),
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    unawaited(context.push('${AppRoutes.customerOrderDetail}?code=$code'));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.control),
                    ),
                  ),
                  child: Text(
                    context.l10n.ordersViewDetailCta,
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  label: context.l10n.ordersRebookCta,
                  icon: Icons.refresh_rounded,
                  onPressed: () {
                    unawaited(context.push(AppRoutes.bookingStep1));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
