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

/// Worker Completion Wait & Payout Screen (`wwait` — Concept 02: Cells 51, 54, 60).
/// Transitions through: Waiting for Sign-off -> Waiting for Payment -> Payout Credited.
class WorkerJobCompletionPage extends StatefulWidget {
  const WorkerJobCompletionPage({
    super.key,
    this.initialStage = 'inspection',
    this.totalPrice = 400000,
    this.orderCode = 'HS-2026-0012',
  });

  /// 'inspection' (Cell 51), 'payment' (Cell 54), 'credited' (Cell 60)
  final String initialStage;
  final int totalPrice;
  final String orderCode;

  @override
  State<WorkerJobCompletionPage> createState() => _WorkerJobCompletionPageState();
}

class _WorkerJobCompletionPageState extends State<WorkerJobCompletionPage> {
  late String _currentStage;

  @override
  void initState() {
    super.initState();
    _currentStage = widget.initialStage;
  }

  String _formatPrice(int value) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(value)}đ';
  }

  @override
  Widget build(BuildContext context) {
    final workerNet = (widget.totalPrice * 0.85).round();

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
          context.l10n.workerWaitTitle,
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
      body: Column(
        children: [
          // Stage Selector for Preview & Demonstration
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            color: AppColors.surface,
            child: Row(
              children: [
                _buildStageChip('inspection', 'Chờ nghiệm thu (Cell 51)'),
                const SizedBox(width: 8),
                _buildStageChip('payment', 'Chờ trả tiền (Cell 54)'),
                const SizedBox(width: 8),
                _buildStageChip('credited', 'Đã nhận tiền (Cell 60)'),
              ],
            ),
          ),
          Container(color: AppColors.border, height: 1),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                if (_currentStage == 'inspection') ...[
                  // Cell 51: Waiting for Customer Inspection
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          context.l10n.workerWaitInspectionTitle,
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          context.l10n.workerWaitInspectionDesc,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else if (_currentStage == 'payment') ...[
                  // Cell 54: Waiting for Payment
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.warning),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.warning.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.hourglass_top_rounded,
                            color: AppColors.warning,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          context.l10n.workerWaitPaymentTitle,
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          context.l10n.workerWaitPaymentDesc(_formatPrice(widget.totalPrice)),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Cell 60: Payment Received & Credited to Worker Wallet
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.success),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_rounded,
                            color: AppColors.success,
                            size: 38,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          context.l10n.workerPaidCelebrationTitle,
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          context.l10n.workerPaidWalletCredit(_formatPrice(workerNet)),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.successDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Transparent Earnings Card (Deep Teal)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.workerTeal,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                    ),
                    child: Column(
                      children: [
                        Text(
                          context.l10n.receiptWorkerPayout,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatPrice(workerNet),
                          style: AppTextStyles.headlineLarge.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const Divider(height: 1, color: Colors.white24),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                context.l10n.paymentTotalToPay,
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.onPrimary),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              _formatPrice(widget.totalPrice),
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                context.l10n.jobPlatformFee,
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.onPrimary.withValues(alpha: 0.8)),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              '-${_formatPrice(widget.totalPrice - workerNet)}',
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.onPrimary.withValues(alpha: 0.8)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // View Wallet CTA
                  AppButton(
                    label: context.l10n.workerViewWalletCta,
                    onPressed: () {
                      unawaited(context.push(AppRoutes.workerDashboard));
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageChip(String stage, String label) {
    final isSelected = _currentStage == stage;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentStage = stage),
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
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
