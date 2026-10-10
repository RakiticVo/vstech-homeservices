import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/error/failure_message.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/transaction_detail_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/widgets/wallet_labels.dart';

/// Worker transaction detail screen (Cell 119 `wtx`): one ledger entry — signed amount, type,
/// status, time, transaction id and the related job. The fee/net breakdown of the design has no
/// API fields yet, so it is not shown.
class WorkerTransactionDetailPage extends StatefulWidget {
  const WorkerTransactionDetailPage({required this.transactionId, super.key});

  final String transactionId;

  @override
  State<WorkerTransactionDetailPage> createState() => _WorkerTransactionDetailPageState();
}

class _WorkerTransactionDetailPageState extends State<WorkerTransactionDetailPage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<TransactionDetailCubit>().load(widget.transactionId));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<TransactionDetailCubit>().state;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.workerWallet),
        ),
        title: Text(
          l10n.wtxTitle,
          style: AppTextStyles.headlineMd.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: switch (state) {
          TransactionDetailLoadingState() => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
          TransactionDetailErrorState(:final failure) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ErrorRetryView(
              message: l10n.failureMessage(failure),
              onRetry: () => unawaited(context.read<TransactionDetailCubit>().load(widget.transactionId)),
            ),
          ),
          TransactionDetailLoadedState(:final transaction) => _buildBody(transaction),
        },
      ),
    );
  }

  Widget _buildBody(WalletTransaction tx) {
    final l10n = context.l10n;
    final createdAt = tx.createdAt;
    final related = tx.referenceRequestId;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Amount header
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Text(
                transactionTypeLabel(context, tx.type),
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                signedAmount(tx),
                key: const Key('transaction_amount'),
                style: AppTextStyles.headlineLg.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TransactionStatusChip(status: tx.status),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Transaction info
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
                style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.sm),
              _InfoRow(label: l10n.wtxType, value: transactionTypeLabel(context, tx.type)),
              if (tx.description?.isNotEmpty ?? false) _InfoRow(label: l10n.wtxDescription, value: tx.description!),
              if (createdAt != null) _InfoRow(label: l10n.wtxTime, value: transactionTime(createdAt)),
              _InfoRow(label: l10n.wtxTxId, value: '#${tx.id}'),
              if (related != null)
                InkWell(
                  key: const Key('transaction_related_order'),
                  onTap: () => unawaited(context.push(AppRoutes.workerJobDetailLocation(related))),
                  child: _InfoRow(label: l10n.wtxRelatedOrder, value: '#$related', isLink: true),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.isLink = false});

  final String label;
  final String value;
  final bool isLink;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontSize: 13)),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodyMd.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontSize: 13,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
          if (isLink) const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
