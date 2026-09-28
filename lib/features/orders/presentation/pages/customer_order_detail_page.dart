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

/// Customer Order Detail Screen (`orderdet` — Concept 02: Cells 62, 63).
/// Itemized order specifications, worker contact card, transparent price breakdown,
/// 30-day warranty badge, and situational action triggers.
class CustomerOrderDetailPage extends StatelessWidget {
  const CustomerOrderDetailPage({
    super.key,
    this.orderCode = 'HS-2026-0012',
    this.status = 'active', // 'active', 'completed', 'scheduled'
    this.totalPrice = 400000,
  });

  final String orderCode;
  final String status;
  final int totalPrice;

  String _formatPrice(int amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

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
          context.l10n.orderDetailTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Order Header Banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderCode,
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Dọn dẹp căn hộ tiêu chuẩn (Dưới 70m²)',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == 'completed'
                        ? const Color(0xFFE8F5E9)
                        : AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                    border: Border.all(
                      color: status == 'completed'
                          ? AppColors.success
                          : AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    status == 'completed'
                        ? context.l10n.orderDetailPaidStatus
                        : context.l10n.trackingStageEnRoute,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: status == 'completed'
                          ? AppColors.successDark
                          : AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Worker Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.orderDetailWorkerCard,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.secondarySurface,
                      child: Icon(Icons.person, color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nguyễn Văn Hùng',
                            style: AppTextStyles.labelLarge.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, size: 16, color: AppColors.warning),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '4.9 (120+ đơn hoàn tất)',
                                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.l10n.trackingChat)),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.l10n.trackingMaskedCall)),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Schedule & Address Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.orderDetailScheduleCard,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.textMuted),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '24/09/2026 (Hôm nay)',
                            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '14:00 - 16:00 (Khung giờ chiều)',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18, color: AppColors.textMuted),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Căn hộ 802, Tháp B, Flora Novia',
                            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '1452 Phạm Văn Đồng, P. Linh Tây, TP. Thủ Đức, TP. Hồ Chí Minh',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Itemized Invoice Breakdown
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.orderDetailPriceCard,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildPriceRow(context.l10n.bookingBaseLabourFee, 350000),
                const SizedBox(height: AppSpacing.xs),
                _buildPriceRow(context.l10n.bookingAddonsFee, 30000),
                const SizedBox(height: AppSpacing.xs),
                _buildPriceRow(context.l10n.bookingPremisesFee, 20000),
                const SizedBox(height: AppSpacing.md),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.paymentTotalToPay,
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      _formatPrice(totalPrice),
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // 30-Day Warranty Badge
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.secondarySurface,
              borderRadius: BorderRadius.circular(AppRadius.control),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    context.l10n.orderDetailWarrantyBadge,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Action Buttons
          if (status == 'active') ...[
            AppButton(
              label: context.l10n.ordersTrackWorkerCta,
              icon: Icons.map_outlined,
              onPressed: () {
                unawaited(context.push('${AppRoutes.customerTracking}?code=$orderCode'));
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () {
                unawaited(context.push('${AppRoutes.electronicReceipt}?code=$orderCode'));
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.control),
                ),
              ),
              child: Text(
                context.l10n.paidViewReceipt,
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
              ),
            ),
          ] else ...[
            AppButton(
              label: context.l10n.ordersRebookCta,
              icon: Icons.refresh_rounded,
              onPressed: () {
                unawaited(context.push(AppRoutes.bookingStep1));
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () {
                unawaited(context.push('${AppRoutes.electronicReceipt}?code=$orderCode'));
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.control),
                ),
              ),
              child: Text(
                context.l10n.paidViewReceipt,
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, int amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          _formatPrice(amount),
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
