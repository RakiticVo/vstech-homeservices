import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker transaction detail screen (Cell 119 `wtx`).
class WorkerTransactionDetailPage extends StatelessWidget {
  const WorkerTransactionDetailPage({
    super.key,
    this.txId,
    this.title,
    this.amount,
    this.grossAmount,
    this.fee,
    this.time,
    this.status,
    this.orderCode,
    this.bankInfo,
  });

  final String? txId;
  final String? title;
  final String? amount;
  final String? grossAmount;
  final String? fee;
  final String? time;
  final String? status;
  final String? orderCode;
  final String? bankInfo;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final displayTitle = title ?? 'Vệ sinh nhà cửa #HS20250421-0031';
    final displayAmount = amount ?? '+340.000đ';
    final displayGross = grossAmount ?? '400.000đ';
    final displayFee = fee ?? '60.000đ';
    final displayTime = time ?? '21/04/2026 · 14:00';
    final displayStatus = status ?? 'completed';
    final displayOrder = orderCode ?? '#HS20250421-0031';
    final displayBank = bankInfo;

    final isHold = displayStatus == 'hold';
    final isWithdraw = displayAmount.startsWith('−') || displayAmount.startsWith('-');
    final isPositive = !isWithdraw && !isHold;

    final amountColor = isHold
        ? const Color(0xFFA35A06)
        : isPositive
            ? AppColors.primary
            : AppColors.error;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.workerWallet);
            }
          },
        ),
        title: Text(
          l10n.wtxTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            children: [
              // Top summary block
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Text(
                      displayTitle,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      displayAmount,
                      key: const Key('wtx_detail_amount_text'),
                      style: AppTextStyles.headlineLg.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: amountColor,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isHold
                            ? const Color(0xFFFDF0D8)
                            : isPositive
                                ? AppColors.secondarySurface
                                : const Color(0xFFFDE8E4),
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(
                          color: isHold
                              ? const Color(0xFFA35A06).withValues(alpha: 0.3)
                              : isPositive
                                  ? AppColors.primary.withValues(alpha: 0.3)
                                  : AppColors.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        isHold
                            ? l10n.wwalletStatusOnHold
                            : l10n.wwalletStatusCompleted,
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          color: isHold
                              ? const Color(0xFFA35A06)
                              : isPositive
                                  ? AppColors.primary
                                  : AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Breakdown card
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.wtxBreakdownTitle,
                      style: AppTextStyles.titleLg.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (isWithdraw) ...[
                      _buildInfoRow(
                        label: l10n.wwdAmountLabel,
                        value: displayGross,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildInfoRow(
                        label: l10n.wwdFee,
                        value: '0đ',
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Divider(height: 1, color: AppColors.border),
                      const SizedBox(height: AppSpacing.sm),
                      _buildInfoRow(
                        label: l10n.wtxTargetBank,
                        value: displayAmount,
                        valueColor: AppColors.textPrimary,
                        isBold: true,
                      ),
                    ] else ...[
                      _buildInfoRow(
                        label: l10n.wtxCustomerPaid,
                        value: displayGross,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildInfoRow(
                        label: l10n.wtxPlatformFee,
                        value: '−$displayFee',
                        valueColor: AppColors.error,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Divider(height: 1, color: AppColors.border),
                      const SizedBox(height: AppSpacing.sm),
                      _buildInfoRow(
                        label: l10n.wtxNetIncome,
                        value: displayAmount,
                        valueColor: amountColor,
                        isBold: true,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Information card
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.wtxInfoTitle,
                      style: AppTextStyles.titleLg.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildInfoRow(
                      label: l10n.wtxTime,
                      value: displayTime,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(
                      label: l10n.wtxTxId,
                      value: 'GD250425${(txId ?? "01").replaceAll(RegExp('[^0-9]'), "")}',
                    ),
                    if (displayOrder.isNotEmpty && !isWithdraw) ...[
                      const SizedBox(height: AppSpacing.sm),
                      InkWell(
                        key: const Key('wtx_related_order_link'),
                        onTap: () => context.push(AppRoutes.workerJobsHub),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.wtxRelatedOrder,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '$displayOrder ›',
                              style: AppTextStyles.bodyMd.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (displayBank != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      _buildInfoRow(
                        label: l10n.wtxTargetBank,
                        value: displayBank,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMd.copyWith(
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            color: valueColor ?? AppColors.textPrimary,
            fontSize: isBold ? 15 : 13,
          ),
        ),
      ],
    );
  }
}
