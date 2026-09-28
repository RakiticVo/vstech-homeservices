import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker earnings wallet screen (Cells 117 & 118 `wwallet`).
class WorkerWalletPage extends StatefulWidget {
  const WorkerWalletPage({super.key});

  @override
  State<WorkerWalletPage> createState() => _WorkerWalletPageState();
}

class _WorkerWalletPageState extends State<WorkerWalletPage> {
  int _selectedFilter = 0; // 0: All, 1: Income, 2: Withdraw, 3: Hold

  final List<_WalletTxItem> _transactions = [
    const _WalletTxItem(
      id: 'tx_1',
      title: 'Vệ sinh máy lạnh #HS20250425-0007',
      time: '25/04 · 11:30',
      amount: '+297.500đ',
      grossAmount: '350.000đ',
      fee: '52.500đ',
      isPositive: true,
      kind: 1, // income
      status: 'completed',
      orderCode: '#HS20250425-0007',
    ),
    const _WalletTxItem(
      id: 'tx_2',
      title: 'Sửa chữa điện nước #HS20250424-0019',
      time: '24/04 · 16:45',
      amount: '+238.000đ',
      grossAmount: '280.000đ',
      fee: '42.000đ',
      isPositive: true,
      kind: 1, // income
      status: 'completed',
      orderCode: '#HS20250424-0019',
    ),
    const _WalletTxItem(
      id: 'tx_3',
      title: 'Rút về Vietcombank ••• 4821',
      time: '22/04 · 09:15',
      amount: '−2.000.000đ',
      grossAmount: '2.000.000đ',
      fee: '0đ',
      isPositive: false,
      kind: 2, // withdraw
      status: 'completed',
      bankInfo: 'Vietcombank ••• 4821',
    ),
    const _WalletTxItem(
      id: 'tx_4',
      title: 'Vệ sinh nhà cửa #HS20250421-0031',
      time: '21/04 · 14:00',
      amount: '+340.000đ',
      grossAmount: '400.000đ',
      fee: '60.000đ',
      isPositive: true,
      kind: 1, // income
      status: 'completed',
      orderCode: '#HS20250421-0031',
    ),
    const _WalletTxItem(
      id: 'tx_5',
      title: 'Thưởng hoàn thành 10 việc',
      time: '20/04 · 18:00',
      amount: '+100.000đ',
      grossAmount: '100.000đ',
      fee: '0đ',
      isPositive: true,
      kind: 1, // income
      status: 'completed',
    ),
    const _WalletTxItem(
      id: 'tx_6',
      title: 'Đơn đang khiếu nại #HS20250425-0012',
      time: '25/04 · 16:34',
      amount: '340.000đ',
      grossAmount: '400.000đ',
      fee: '60.000đ',
      isPositive: null,
      kind: 3, // hold
      status: 'hold',
      orderCode: '#HS20250425-0012',
    ),
  ];

  List<_WalletTxItem> get _filteredTransactions {
    if (_selectedFilter == 1) {
      return _transactions.where((t) => t.kind == 1).toList();
    }
    if (_selectedFilter == 2) {
      return _transactions.where((t) => t.kind == 2).toList();
    }
    if (_selectedFilter == 3) {
      return _transactions.where((t) => t.kind == 3).toList();
    }
    return _transactions;
  }

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
            vertical: AppSpacing.sm,
          ),
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
                      '4.860.000đ',
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.control),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 18,
                              color: AppColors.primary,
                            ),
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
                      label: l10n.wwalletTotalEarned,
                      value: '6.860.000đ',
                      valueColor: AppColors.textPrimary,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildLedgerRow(
                      label: l10n.wwalletWithdrawn,
                      value: '−2.000.000đ',
                      valueColor: AppColors.textPrimary,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildLedgerRow(
                      label: l10n.wwalletOnHoldNotice,
                      value: '340.000đ',
                      valueColor: const Color(0xFFA35A06),
                      isAmber: true,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Divider(height: 1, color: AppColors.border),
                    const SizedBox(height: AppSpacing.sm),
                    _buildLedgerRow(
                      label: l10n.wwalletAvailableBalance,
                      value: '4.860.000đ',
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
              ..._filteredTransactions.map((tx) => _buildTransactionCard(context, tx)),

              const SizedBox(height: AppSpacing.dockClearanceMin),
            ],
          ),
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
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
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

  Widget _buildTransactionCard(BuildContext context, _WalletTxItem tx) {
    Color amountColor;
    if (tx.status == 'hold') {
      amountColor = const Color(0xFFA35A06);
    } else if (tx.isPositive == true) {
      amountColor = AppColors.primary;
    } else {
      amountColor = AppColors.error;
    }

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
        onTap: () => context.push(
          AppRoutes.workerTransactionDetail,
          extra: tx,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: tx.status == 'hold'
                      ? const Color(0xFFFDF0D8)
                      : tx.isPositive == true
                          ? AppColors.secondarySurface
                          : const Color(0xFFFDE8E4),
                  borderRadius: BorderRadius.circular(AppRadius.control),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(
                  tx.status == 'hold'
                      ? Icons.lock_clock
                      : tx.isPositive == true
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                  color: amountColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
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
                      tx.time,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tx.amount,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w800,
                      color: amountColor,
                      fontSize: 14,
                    ),
                  ),
                  if (tx.status == 'hold')
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF0D8),
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                      ),
                      child: Text(
                        context.l10n.wwalletStatusOnHold,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFA35A06),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletTxItem {
  const _WalletTxItem({
    required this.id,
    required this.title,
    required this.time,
    required this.amount,
    required this.grossAmount,
    required this.fee,
    required this.isPositive,
    required this.kind,
    required this.status,
    this.orderCode,
    this.bankInfo,
  });

  final String id;
  final String title;
  final String time;
  final String amount;
  final String grossAmount;
  final String fee;
  final bool? isPositive;
  final int kind; // 1: income, 2: withdraw, 3: hold
  final String status;
  final String? orderCode;
  final String? bankInfo;
}
