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
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/wallet_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/widgets/wallet_labels.dart';

/// Worker earnings wallet screen (Cells 117 & 118 `wwallet`): available balance and on-hold amount
/// from `GET /wallets/me`, the ledger from `GET /wallets/me/transactions` with 4 local filters
/// (all / income / withdrawals / on hold) and manual "load more".
class WorkerWalletPage extends StatefulWidget {
  const WorkerWalletPage({super.key});

  @override
  State<WorkerWalletPage> createState() => _WorkerWalletPageState();
}

class _WorkerWalletPageState extends State<WorkerWalletPage> {
  int _selectedFilter = 0; // 0: All, 1: Income, 2: Withdraw, 3: Hold

  /// Ledger entries shown under the selected chip (filtered locally across loaded pages).
  List<WalletTransaction> _filter(List<WalletTransaction> transactions) => switch (_selectedFilter) {
    1 => [
      for (final t in transactions)
        if (t.delta > 0 && t.status != TransactionStatus.pending) t,
    ],
    2 => [
      for (final t in transactions)
        if (t.type == TransactionType.withdrawal) t,
    ],
    3 => [
      for (final t in transactions)
        if (t.status == TransactionStatus.pending) t,
    ],
    _ => transactions,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
              context.go(AppRoutes.workerDashboard);
            }
          },
        ),
        title: Text(
          l10n.wwalletTitle,
          style: AppTextStyles.headlineMd.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) => switch (state) {
            WalletLoadingState() => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            WalletErrorState(:final failure) => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ErrorRetryView(
                message: l10n.failureMessage(failure),
                onRetry: () => unawaited(context.read<WalletCubit>().load()),
              ),
            ),
            final WalletLoadedState loaded => _buildLoaded(context, loaded),
          },
        ),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, WalletLoadedState state) {
    final l10n = context.l10n;
    final transactions = _filter(state.transactions);
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<WalletCubit>().load(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Available balance main card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.wwalletAvailableBalance,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    MoneyFormatter.format(state.wallet.balance),
                    key: const Key('wallet_available_balance_text'),
                    style: AppTextStyles.headlineLg.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      key: const Key('worker_withdraw_action_button'),
                      onPressed: () => context.push(AppRoutes.workerWithdraw),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.control)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.account_balance_wallet_outlined, size: 18, color: AppColors.primary),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            l10n.wwalletWithdrawCta,
                            style: AppTextStyles.bodyMd.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 2. Ledger breakdown summary card
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildLedgerRow(
                    label: l10n.wwalletOnHoldNotice,
                    value: MoneyFormatter.format(state.wallet.frozenBalance),
                    valueColor: AppColors.textPrimary,
                    isAmber: true,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: AppSpacing.sm),
                  _buildLedgerRow(
                    label: l10n.wwalletAvailableBalance,
                    value: MoneyFormatter.format(state.wallet.balance),
                    valueColor: AppColors.primary,
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // 3. Filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(label: l10n.wwalletTabAll, index: 0),
                  const SizedBox(width: AppSpacing.sm),
                  _buildFilterChip(label: l10n.wwalletTabIncome, index: 1),
                  const SizedBox(width: AppSpacing.sm),
                  _buildFilterChip(label: l10n.wwalletTabWithdraw, index: 2),
                  const SizedBox(width: AppSpacing.sm),
                  _buildFilterChip(label: l10n.wwalletTabHold, index: 3),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 4. Transaction list
            if (transactions.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Center(
                  child: Text(
                    l10n.wwalletEmpty,
                    key: const Key('wallet_empty'),
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                  ),
                ),
              ),
            for (final tx in transactions) _buildTransactionCard(context, tx),
            if (state.hasMore && state.isLoadingMore)
              const Center(child: CircularProgressIndicator(color: AppColors.primary))
            else if (state.hasMore)
              AppSecondaryButton(
                key: const Key('wallet_load_more_button'),
                label: l10n.ordersLoadMore,
                icon: Icons.expand_more,
                isFullWidth: true,
                onPressed: () => unawaited(context.read<WalletCubit>().loadMore()),
              ),

            const SizedBox(height: AppSpacing.dockClearanceMin),
          ],
        ),
      ),
    );
  }

  Widget _buildLedgerRow({
    required String label,
    required String value,
    required Color valueColor,
    bool isBold = false,
    bool isAmber = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              color: isAmber ? const Color(0xFFA35A06) : AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMd.copyWith(
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            color: valueColor,
            fontSize: isBold ? 15 : 13,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip({required String label, required int index}) {
    final isSelected = _selectedFilter == index;
    return InkWell(
      key: Key('wallet_filter_chip_$index'),
      borderRadius: BorderRadius.circular(AppRadius.chip),
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: isSelected ? 1.5 : 1.0),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCard(BuildContext context, WalletTransaction tx) {
    final isHold = tx.status == TransactionStatus.pending;
    final isIncoming = tx.delta > 0;
    final createdAt = tx.createdAt;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        key: Key('tx_item_${tx.id}'),
        borderRadius: BorderRadius.circular(AppRadius.card),
        onTap: () => unawaited(context.push(AppRoutes.workerTransactionDetailLocation(tx.id))),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Icon(
                isHold
                    ? Icons.lock_clock
                    : isIncoming
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: AppColors.textSecondary,
                size: 22,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.description?.isNotEmpty ?? false ? tx.description! : transactionTypeLabel(context, tx.type),
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [
                        transactionTypeLabel(context, tx.type),
                        if (createdAt != null) transactionTime(createdAt),
                      ].join(' · '),
                      style: AppTextStyles.caption.copyWith(color: AppColors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    signedAmount(tx),
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  TransactionStatusChip(status: tx.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
