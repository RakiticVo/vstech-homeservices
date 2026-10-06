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

/// Customer Order Detail Screen (`orderdet` — Concept 02: Cells 62, 63, 93–95, 116).
/// Itemized order specifications, worker contact card, transparent price breakdown,
/// 30-day warranty badge, and situational action triggers.
class CustomerOrderDetailPage extends StatelessWidget {
  const CustomerOrderDetailPage({
    super.key,
    this.orderCode = 'HS-2026-0012',
    // 'active', 'completed', 'scheduled', 'awaiting_payment', 'disputed', 'no_show'
    this.status = 'active',
    this.totalPrice = 400000,
  });

  static const String statusAwaitingPayment = 'awaiting_payment';
  static const String statusDisputed = 'disputed';
  static const String statusNoShow = 'no_show';
  static const int _noShowFee = 50000;

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
                _buildStatusChip(context),
              ],
            ),
          ),

          if (status == statusNoShow) ...[
            const SizedBox(height: AppSpacing.md),
            _buildNoticeCard(
              key: const Key('order_detail_no_show_note'),
              icon: Icons.person_off_outlined,
              color: AppColors.warning,
              title: context.l10n.orderDetailNoShowNoteTitle(_formatPrice(_noShowFee)),
              body: context.l10n.orderDetailNoShowNoteDesc(
                'Trần Văn Hùng',
                '13:58',
                _formatPrice(_noShowFee),
                _formatPrice(totalPrice),
              ),
            ),
          ],

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

          if (_paymentNotice(context) case final notice?) ...[
            notice,
            const SizedBox(height: AppSpacing.lg),
          ],

          if (status == statusAwaitingPayment || status == statusDisputed) ...[
            _buildBeforeAfterPhotos(context),
            const SizedBox(height: AppSpacing.lg),
          ],

          // 30-Day Warranty Badge
          if (!_isExceptionStatus) Container(
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
          if (status == statusAwaitingPayment) ...[
            AppButton(
              key: const Key('order_detail_pay_cta'),
              label: context.l10n.paymentPayNowCta(_formatPrice(totalPrice)),
              backgroundColor: AppColors.warning,
              textColor: AppColors.textPrimary,
              onPressed: () {
                unawaited(
                  context.push('${AppRoutes.orderPaymentSummary}?code=$orderCode'),
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: TextButton(
                onPressed: () {
                  unawaited(context.push('${AppRoutes.disputeReport}?code=$orderCode'));
                },
                child: Text(
                  context.l10n.orderDetailReportIssue,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ] else if (status == statusDisputed) ...[
            AppButton(
              key: const Key('order_detail_view_complaint_cta'),
              label: context.l10n.orderDetailViewComplaintCta,
              icon: Icons.gavel_rounded,
              onPressed: () {
                unawaited(
                  context.push(
                    '${AppRoutes.disputeDetail}?id=${Uri.encodeComponent('#KN-0425-031')}'
                    '&order=$orderCode',
                  ),
                );
              },
            ),
          ] else if (status == 'active') ...[
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

  bool get _isExceptionStatus =>
      status == statusAwaitingPayment || status == statusDisputed || status == statusNoShow;

  Widget _buildStatusChip(BuildContext context) {
    final l10n = context.l10n;
    final (String label, Color fg, Color bg, Color edge, IconData icon) = switch (status) {
      'completed' => (
          l10n.orderDetailPaidStatus,
          AppColors.successDark,
          AppColors.success.withValues(alpha: 0.1),
          AppColors.success,
          Icons.check_circle_outline_rounded,
        ),
      statusAwaitingPayment => (
          l10n.orderDetailStatusAwaitingPayment,
          AppColors.textPrimary,
          AppColors.warning.withValues(alpha: 0.12),
          AppColors.warning,
          Icons.payments_outlined,
        ),
      statusDisputed => (
          l10n.orderDetailStatusDisputed,
          AppColors.textPrimary,
          AppColors.warning.withValues(alpha: 0.12),
          AppColors.warning,
          Icons.gavel_rounded,
        ),
      statusNoShow => (
          l10n.orderDetailStatusNoShow,
          AppColors.textSecondary,
          AppColors.background,
          AppColors.border,
          Icons.person_off_outlined,
        ),
      _ => (
          l10n.trackingStageEnRoute,
          AppColors.primary,
          AppColors.secondarySurface,
          AppColors.primary.withValues(alpha: 0.3),
          Icons.directions_run_rounded,
        ),
    };

    return Container(
      key: const Key('order_detail_status_chip'),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: edge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  /// Payment / escrow state banner shown under the price card for the exception statuses.
  Widget? _paymentNotice(BuildContext context) {
    final l10n = context.l10n;
    final method = l10n.bookingPaymentVnPay;
    switch (status) {
      case statusAwaitingPayment:
        return _buildNoticeCard(
          key: const Key('order_detail_unpaid_notice'),
          icon: Icons.schedule_rounded,
          color: AppColors.primary,
          title: l10n.orderDetailUnpaidTitle,
          body: l10n.orderDetailUnpaidMethod(method),
        );
      case statusDisputed:
        return _buildNoticeCard(
          key: const Key('order_detail_held_notice'),
          icon: Icons.lock_outline_rounded,
          color: AppColors.warning,
          title: l10n.orderDetailHeldTitle,
          body: l10n.orderDetailHeldRef('#KN-0425-031'),
        );
      case statusNoShow:
        return _buildNoticeCard(
          key: const Key('order_detail_no_show_fee'),
          icon: Icons.receipt_long_outlined,
          color: AppColors.warning,
          title: l10n.orderDetailNoShowFeeTitle(_formatPrice(_noShowFee)),
          body: l10n.orderDetailNoShowFeeDesc(method),
        );
      default:
        return null;
    }
  }

  Widget _buildNoticeCard({
    required Key key,
    required IconData icon,
    required Color color,
    required String title,
    required String body,
  }) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: color),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeforeAfterPhotos(BuildContext context) {
    final labels = [context.l10n.orderDetailBeforeLabel, context.l10n.orderDetailAfterLabel];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.orderDetailBeforeAfterTitle,
          style: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < labels.length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image_outlined, size: 24, color: AppColors.textMuted),
                        const SizedBox(height: 4),
                        Text(
                          labels[i],
                          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
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
