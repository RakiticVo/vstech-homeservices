import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Electronic Receipt Screen (`receipt` — Concept 02: Cell 56).
/// Itemized electronic tax & service receipt with PDF download and sharing.
class ElectronicReceiptPage extends StatelessWidget {
  const ElectronicReceiptPage({
    super.key,
    this.amount = 400000,
    this.orderCode = 'HS-2026-0012',
  });

  final int amount;
  final String orderCode;

  String _formatPrice(int value) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(value)}đ';
  }

  @override
  Widget build(BuildContext context) {
    final workerPayout = (amount * 0.85).round();
    final platformFee = amount - workerPayout;

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
          context.l10n.receiptTitle,
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
          // White Paper Receipt Card with Hairline Border
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Stamp
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VSTech Home Services',
                            style: AppTextStyles.headlineSmall.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'Eco-Clean Sanctuary v9.0',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: AppColors.success),
                      ),
                      child: Text(
                        'ĐÃ THANH TOÁN',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.successDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.md),

                // Order Meta
                _buildMetaRow(context.l10n.receiptInvoiceNo(orderCode), '24/09/2026 · 14:45'),
                const SizedBox(height: AppSpacing.xs),
                _buildMetaRow('Khách hàng', 'Chị Mai (0912***789)'),
                const SizedBox(height: AppSpacing.xs),
                _buildMetaRow('Thợ đối tác', 'Nguyễn Văn Hùng (4.9 ★)'),
                const SizedBox(height: AppSpacing.xs),
                _buildMetaRow('Địa điểm', 'Căn hộ 802, Tháp B, Flora Novia'),

                const SizedBox(height: AppSpacing.lg),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.md),

                // Itemized Breakdown
                Text(
                  'Chi tiết thanh toán',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                _buildLineItem(context.l10n.bookingBaseLabourFee, 350000),
                const SizedBox(height: AppSpacing.xs),
                _buildLineItem(context.l10n.bookingAddonsFee, 30000),
                const SizedBox(height: AppSpacing.xs),
                _buildLineItem(context.l10n.bookingPremisesFee, 20000),

                const SizedBox(height: AppSpacing.md),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: AppSpacing.md),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'TỔNG TIỀN THANH TOÁN',
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      _formatPrice(amount),
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // Transparent Allocation Box
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.secondarySurface,
                    borderRadius: BorderRadius.circular(AppRadius.control),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Minh bạch dòng tiền nền tảng',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(context.l10n.receiptWorkerPayout, style: AppTextStyles.bodySmall)),
                          const SizedBox(width: AppSpacing.sm),
                          Text(_formatPrice(workerPayout), style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(context.l10n.receiptPlatformFeeShare, style: AppTextStyles.bodySmall)),
                          const SizedBox(width: AppSpacing.sm),
                          Text(_formatPrice(platformFee), style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Download PDF Action
          AppButton(
            label: context.l10n.receiptDownloadPdf,
            icon: Icons.download_rounded,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.receiptDownloading(orderCode))),
              );
            },
          ),

          const SizedBox(height: AppSpacing.md),

          // Share Action
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.receiptShare)),
              );
            },
            icon: const Icon(Icons.share_outlined, size: 18, color: AppColors.primary),
            label: Text(
              context.l10n.receiptShare,
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.control),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          flex: 6,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLineItem(String title, int price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(title, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary))),
        Text(_formatPrice(price), style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }
}
