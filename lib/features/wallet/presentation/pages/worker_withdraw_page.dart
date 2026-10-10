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
import 'package:vstech_home_services/core/widgets/app_text_field.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdraw_cubit.dart';

/// Worker withdrawal screen (Cell 120 `wwd`): amount (checked against the real balance from
/// `GET /wallets/me`), destination bank code + account number (no saved-account API yet), then the
/// PIN step. Submitted by [WithdrawCubit] as `POST /wallets/withdrawals`.
class WorkerWithdrawPage extends StatefulWidget {
  const WorkerWithdrawPage({super.key});

  @override
  State<WorkerWithdrawPage> createState() => _WorkerWithdrawPageState();
}

class _WorkerWithdrawPageState extends State<WorkerWithdrawPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankCodeController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  num _currentAmount = 0;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
    _bankCodeController.addListener(_refresh);
    _accountController.addListener(_refresh);
    unawaited(context.read<WithdrawCubit>().load());
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    _bankCodeController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final clean = _amountController.text.replaceAll(RegExp('[^0-9]'), '');
    final num val = int.tryParse(clean) ?? 0;
    setState(() {
      _currentAmount = val;
    });
  }

  void _selectQuickAmount(num amt) {
    setState(() {
      _currentAmount = amt;
      _amountController.text = amt.toString();
    });
  }

  bool _isValid(num balance) =>
      _currentAmount >= WithdrawCubit.minAmount &&
      _currentAmount <= balance &&
      _bankCodeController.text.trim().isNotEmpty &&
      _accountController.text.trim().isNotEmpty;

  void _onContinue() => context.read<WithdrawCubit>().review(
    amount: _currentAmount,
    bankCode: _bankCodeController.text,
    bankAccountNumber: _accountController.text,
  );

  void _onStateChanged(BuildContext context, WithdrawState state) {
    if (state is WithdrawReadyState) unawaited(context.push(AppRoutes.workerWithdrawPin));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<WithdrawCubit>().state;
    final balance = state.draft?.balance;

    return BlocListener<WithdrawCubit, WithdrawState>(
      listener: _onStateChanged,
      child: Scaffold(
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
            l10n.wwdTitle,
            style: AppTextStyles.headlineMd.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: switch (state) {
            WithdrawLoadingState() => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            WithdrawLoadErrorState(:final failure) => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ErrorRetryView(
                message: l10n.failureMessage(failure),
                onRetry: () => unawaited(context.read<WithdrawCubit>().load()),
              ),
            ),
            _ => _buildForm(context, balance ?? 0),
          },
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, num balance) {
    final l10n = context.l10n;
    final balanceAfter = balance - _currentAmount;
    final isValid = _isValid(balance);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Amount input container
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
                        l10n.wwdAmountLabel,
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              key: const Key('withdraw_amount_input'),
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              style: AppTextStyles.headlineLg.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.primary,
                                fontSize: 28,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: AppTextStyles.headlineLg.copyWith(color: AppColors.textMuted),
                                suffixText: 'VNĐ',
                                suffixStyle: AppTextStyles.titleLg.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      const SizedBox(height: AppSpacing.md),

                      // Quick chips
                      Row(
                        children: [
                          _buildQuickChip(label: MoneyFormatter.format(500000), amount: 500000),
                          const SizedBox(width: AppSpacing.sm),
                          _buildQuickChip(label: MoneyFormatter.format(1000000), amount: 1000000),
                          const SizedBox(width: AppSpacing.sm),
                          _buildQuickChip(label: l10n.wwdQuickAll, amount: balance),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Destination Bank Account card
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.wwdBankCardTitle,
                            style: AppTextStyles.titleLg.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        key: const Key('withdraw_bank_code_input'),
                        controller: _bankCodeController,
                        label: l10n.wwdBankCodeLabel,
                        hintText: l10n.wwdBankCodeHint,
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.account_balance, color: AppColors.textMuted, size: 20),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        key: const Key('withdraw_account_input'),
                        controller: _accountController,
                        label: l10n.wwdAccountNumberLabel,
                        hintText: l10n.wwdAccountNumberHint,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.numbers, color: AppColors.textMuted, size: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Ledger table card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _buildCalculationRow(label: l10n.wwdCurrentBalance, value: MoneyFormatter.format(balance)),
                      const SizedBox(height: AppSpacing.sm),
                      _buildCalculationRow(
                        label: l10n.wwdMinAmount,
                        value: MoneyFormatter.format(WithdrawCubit.minAmount),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildCalculationRow(label: l10n.wwdFee, value: l10n.wwdFeeFree, valueColor: AppColors.success),
                      const SizedBox(height: AppSpacing.sm),
                      const Divider(height: 1, color: AppColors.border),
                      const SizedBox(height: AppSpacing.sm),
                      _buildCalculationRow(
                        label: l10n.wwdBalanceAfter,
                        value: MoneyFormatter.format(balanceAfter >= 0 ? balanceAfter : 0),
                        valueColor: balanceAfter >= 0 ? AppColors.primary : AppColors.error,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Phase 1 accounting notice
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF0D8),
                    borderRadius: BorderRadius.circular(AppRadius.card),
                    border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, color: Color(0xFFA35A06), size: 18),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          l10n.wwdPhase1Notice,
                          style: AppTextStyles.caption.copyWith(color: const Color(0xFFA35A06), height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),

        // Bottom CTA
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              key: const Key('withdraw_continue_button'),
              onPressed: isValid ? _onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.border,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.full)),
              ),
              child: Text(
                _currentAmount < WithdrawCubit.minAmount
                    ? l10n.wwdMinValidation
                    : _currentAmount > balance
                    ? l10n.wwdMaxValidation
                    : l10n.wwdContinueCta,
                style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickChip({required String label, required num amount}) {
    final isSelected = _currentAmount == amount;
    return Expanded(
      child: InkWell(
        key: Key('quick_amt_chip_$amount'),
        borderRadius: BorderRadius.circular(AppRadius.chip),
        onTap: () => _selectQuickAmount(amount),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.chip),
            border: Border.all(color: isSelected ? AppColors.primary : AppColors.border, width: isSelected ? 1.5 : 1.0),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalculationRow({required String label, required String value, Color? valueColor, bool isBold = false}) {
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
