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

/// Worker Completion Wait & Payout Screen (`wwait` — Concept 02: Cells 66–69, 91, 131).
/// Stages: Waiting for Sign-off -> Waiting for Payment -> Payout Credited, plus the
/// complaint-hold and warranty-completed outcomes.
class WorkerJobCompletionPage extends StatelessWidget {
  const WorkerJobCompletionPage({
    super.key,
    this.initialStage = stageInspection,
    this.totalPrice = 400000,
    this.extraCost = 0,
    this.orderCode = 'HS-2026-0012',
  });

  static const String stageInspection = 'inspection';
  static const String stagePayment = 'payment';
  static const String stageCredited = 'credited';
  static const String stageDisputed = 'disputed';
  static const String stageWarrantyDone = 'warranty_done';

  /// One of the `stage*` constants above.
  final String initialStage;

  /// Service price the platform fee is charged on.
  final int totalPrice;

  /// Customer-approved extra cost (Cell 131); passed through 100% to the worker.
  final int extraCost;
  final String orderCode;

  static const double _platformFeeRate = 0.15;

  String _formatPrice(int value) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(value)}đ';
  }

  int get _platformFee => (totalPrice * _platformFeeRate).round();

  int get _workerNet => totalPrice + extraCost - _platformFee;

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
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: switch (initialStage) {
          stagePayment => _buildPaymentStage(context),
          stageCredited => _buildCreditedStage(context),
          stageDisputed => _buildDisputedStage(context),
          stageWarrantyDone => _buildWarrantyDoneStage(context),
          _ => _buildInspectionStage(context),
        },
      ),
    );
  }

  // Cell 66: Waiting for Customer Inspection
  List<Widget> _buildInspectionStage(BuildContext context) {
    return [
      _StatusCard(
        borderColor: AppColors.border,
        leading: const SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(strokeWidth: 3, color: AppColors.primary),
        ),
        title: context.l10n.workerWaitInspectionTitle,
        body: context.l10n.workerWaitInspectionDesc,
      ),
    ];
  }

  // Cell 67: Waiting for Payment
  List<Widget> _buildPaymentStage(BuildContext context) {
    return [
      _StatusCard(
        borderColor: AppColors.warning,
        leading: const _IconBadge(icon: Icons.hourglass_top_rounded, color: AppColors.warning),
        title: context.l10n.workerWaitPaymentTitle,
        body: context.l10n.workerWaitPaymentDesc(_formatPrice(totalPrice + extraCost)),
      ),
    ];
  }

  // Cells 68 & 131: Payment Received & Credited to Worker Wallet (optionally with extra cost)
  List<Widget> _buildCreditedStage(BuildContext context) {
    final l10n = context.l10n;
    return [
      _StatusCard(
        borderColor: AppColors.success,
        leading: const _IconBadge(icon: Icons.account_balance_wallet_rounded, color: AppColors.success),
        title: l10n.workerPaidCelebrationTitle,
        body: l10n.workerPaidWalletCredit(_formatPrice(_workerNet)),
        bodyColor: AppColors.successDark,
      ),
      const SizedBox(height: AppSpacing.lg),

      // Transparent Earnings Card (Deep Teal)
      Container(
        key: const Key('worker_earnings_card'),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(color: AppColors.workerTeal, borderRadius: BorderRadius.circular(AppRadius.card)),
        child: Column(
          children: [
            Text(
              l10n.receiptWorkerPayout,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.onPrimary.withValues(alpha: 0.8)),
            ),
            const SizedBox(height: 2),
            Text(
              _formatPrice(_workerNet),
              style: AppTextStyles.headlineLarge.copyWith(color: AppColors.onPrimary, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            Divider(height: 1, color: AppColors.onPrimary.withValues(alpha: 0.24)),
            const SizedBox(height: AppSpacing.sm),
            _EarningsRow(label: l10n.paymentTotalToPay, value: _formatPrice(totalPrice), isEmphasised: true),
            if (extraCost > 0) ...[
              const SizedBox(height: 2),
              _EarningsRow(label: l10n.workerExtraCostLabel, value: '+${_formatPrice(extraCost)}', isEmphasised: true),
            ],
            const SizedBox(height: 2),
            _EarningsRow(label: l10n.jobPlatformFee, value: '-${_formatPrice(_platformFee)}'),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.xl),
      AppButton.primary(
        label: l10n.workerViewWalletCta,
        icon: Icons.account_balance_wallet_outlined,
        onPressed: () {
          unawaited(context.push(AppRoutes.workerWallet));
        },
      ),
    ];
  }

  // Cell 69: Customer filed a complaint — payout on hold
  List<Widget> _buildDisputedStage(BuildContext context) {
    final l10n = context.l10n;
    return [
      _StatusCard(
        borderColor: AppColors.warning,
        leading: const _IconBadge(icon: Icons.gavel_rounded, color: AppColors.warning),
        title: l10n.workerDisputedTitle,
        body: l10n.workerDisputedDesc,
      ),
      const SizedBox(height: AppSpacing.lg),
      Container(
        key: const Key('worker_complaint_card'),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.report_outlined, size: 20, color: AppColors.textSecondary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.workerDisputedComplaintTitle,
                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('#KN-0425-031 · #$orderCode', style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.workerDisputedComplaintSample,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
            AppSecondaryButton(
              label: l10n.workerDisputedReplyCta,
              isFullWidth: true,
              icon: Icons.reply_rounded,
              onPressed: () {
                unawaited(context.push(AppRoutes.workerDisputeNotification));
              },
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.xl),
      AppButton.primary(
        label: l10n.workerBackToTodayCta,
        icon: Icons.today_rounded,
        onPressed: () => context.go(AppRoutes.workerDashboard),
      ),
    ];
  }

  // Cell 91: Warranty job signed off — no payment step, 0đ
  List<Widget> _buildWarrantyDoneStage(BuildContext context) {
    final l10n = context.l10n;
    return [
      _StatusCard(
        borderColor: AppColors.success,
        leading: const _IconBadge(icon: Icons.verified_user_outlined, color: AppColors.success),
        title: l10n.workerWarrantyDoneTitle,
        body: l10n.workerWarrantyDoneDesc,
      ),
      const SizedBox(height: AppSpacing.lg),
      Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                l10n.workerWarrantyAmountLabel,
                style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ),
            Text(
              _formatPrice(0),
              style: AppTextStyles.headlineSmall.copyWith(fontWeight: FontWeight.w800, color: AppColors.primary),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.xl),
      AppButton.primary(
        label: l10n.workerBackToTodayCta,
        icon: Icons.today_rounded,
        onPressed: () => context.go(AppRoutes.workerDashboard),
      ),
    ];
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.borderColor,
    required this.leading,
    required this.title,
    required this.body,
    this.bodyColor = AppColors.textSecondary,
  });

  final Color borderColor;
  final Widget leading;
  final String title;
  final String body;
  final Color bodyColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          leading,
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineSmall.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            body,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: bodyColor,
              fontWeight: bodyColor == AppColors.textSecondary ? null : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 32),
    );
  }
}

class _EarningsRow extends StatelessWidget {
  const _EarningsRow({required this.label, required this.value, this.isEmphasised = false});

  final String label;
  final String value;
  final bool isEmphasised;

  @override
  Widget build(BuildContext context) {
    final color = isEmphasised ? AppColors.onPrimary : AppColors.onPrimary.withValues(alpha: 0.8);
    return Row(
      children: [
        Expanded(
          child: Text(label, style: AppTextStyles.bodySmall.copyWith(color: color)),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(color: color, fontWeight: isEmphasised ? FontWeight.w600 : null),
        ),
      ],
    );
  }
}
