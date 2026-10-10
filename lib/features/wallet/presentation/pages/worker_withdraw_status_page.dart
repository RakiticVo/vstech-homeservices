import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdrawal_status_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/widgets/wallet_labels.dart';

/// Worker withdrawal request status timeline screen (Cell 122 `wwdst`): the request from
/// `POST/GET /wallets/withdrawals` — amount, bank, and a 3-step timeline driven by its
/// `WithdrawalStatus` (sent → awaiting approval → transferred, or rejected/cancelled with reason).
class WorkerWithdrawStatusPage extends StatefulWidget {
  const WorkerWithdrawStatusPage({required this.withdrawalId, super.key});

  final String withdrawalId;

  @override
  State<WorkerWithdrawStatusPage> createState() => _WorkerWithdrawStatusPageState();
}

class _WorkerWithdrawStatusPageState extends State<WorkerWithdrawStatusPage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<WithdrawalStatusCubit>().load(widget.withdrawalId));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<WithdrawalStatusCubit>().state;
    return switch (state) {
      WithdrawalStatusLoadingState() => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ),
      WithdrawalStatusErrorState(:final failure) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ErrorRetryView(
            message: l10n.failureMessage(failure),
            onRetry: () => unawaited(context.read<WithdrawalStatusCubit>().load(widget.withdrawalId)),
          ),
        ),
      ),
      WithdrawalStatusLoadedState(:final withdrawal) => _buildLoaded(context, withdrawal),
    };
  }

  Widget _buildLoaded(BuildContext context, Withdrawal withdrawal) {
    final l10n = context.l10n;
    final amount = MoneyFormatter.format(withdrawal.amount);
    final status = withdrawal.status;
    final isApproved = status == WithdrawalStatus.approved;
    final isClosed = status == WithdrawalStatus.rejected || status == WithdrawalStatus.cancelled;
    final account = withdrawal.bankAccountNumber ?? '';
    final last4 = account.length > 4 ? account.substring(account.length - 4) : account;
    final createdAt = withdrawal.createdAt;
    final updatedAt = withdrawal.updatedAt;
    final time = DateFormat('HH:mm · dd/MM/yyyy');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(AppRoutes.workerWallet),
        ),
        title: Text(
          l10n.wwdstTitle,
          style: AppTextStyles.headlineMd.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    // Success icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                      ),
                      child: const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 36),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Success title
                    Text(
                      isClosed ? l10n.wwdstClosedTitle : l10n.wwdstSuccessTitle,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Amount display
                    Text(
                      amount,
                      key: const Key('withdrawal_amount'),
                      style: AppTextStyles.displaySm.copyWith(fontWeight: FontWeight.w800, color: AppColors.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${withdrawal.bankCode ?? ''} ••• $last4',
                      style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // 3-step Timeline Card
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
                          WithdrawalStatusChip(status: status),
                          const SizedBox(height: AppSpacing.md),
                          _buildTimelineStep(
                            isFirst: true,
                            isCompleted: true,
                            stepNumber: '1',
                            title: l10n.wwdstStep1,
                            subtitle: createdAt == null ? '' : time.format(createdAt.toLocal()),
                          ),
                          _buildTimelineStep(
                            isCompleted: isApproved,
                            isInProgress: status == WithdrawalStatus.pendingApproval,
                            stepNumber: '2',
                            title: l10n.wwdstStep2,
                            subtitle: isClosed
                                ? (withdrawal.reason ?? withdrawalStatusLabel(context, status))
                                : l10n.wwdPhase1Notice,
                          ),
                          _buildTimelineStep(
                            isLast: true,
                            isCompleted: isApproved,
                            stepNumber: '3',
                            title: l10n.wwdstStep3,
                            subtitle: isApproved && updatedAt != null
                                ? time.format(updatedAt.toLocal())
                                : l10n.wwdstStep3Pending,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Notice note box
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.control),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              l10n.wwdstNote,
                              style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: AppButton(label: l10n.wwdstBackWalletCta, onPressed: () => context.go(AppRoutes.workerWallet)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required String stepNumber,
    required String title,
    required String subtitle,
    bool isFirst = false,
    bool isLast = false,
    bool isCompleted = false,
    bool isInProgress = false,
  }) {
    final circleBg = isCompleted || isInProgress ? AppColors.primary : AppColors.surface;
    final circleText = isCompleted || isInProgress ? AppColors.onPrimary : AppColors.textMuted;
    final circleBorder = isCompleted || isInProgress ? AppColors.primary : AppColors.border;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: circleBg,
                shape: BoxShape.circle,
                border: Border.all(color: circleBorder, width: 2),
              ),
              alignment: Alignment.center,
              child: isCompleted
                  ? const Icon(Icons.check, size: 16, color: AppColors.onPrimary)
                  : Text(
                      stepNumber,
                      style: AppTextStyles.caption.copyWith(color: circleText, fontWeight: FontWeight.w700),
                    ),
            ),
            if (!isLast) Container(width: 2, height: 48, color: isCompleted ? AppColors.primary : AppColors.border),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMd.copyWith(
                    fontWeight: isInProgress || isCompleted ? FontWeight.w700 : FontWeight.w600,
                    color: isInProgress || isCompleted ? AppColors.textPrimary : AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySm.copyWith(
                    color: isInProgress ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
