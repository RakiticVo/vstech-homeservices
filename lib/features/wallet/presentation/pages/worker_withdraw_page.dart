import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';

/// Worker withdrawal screen (Cell 120 `wwd`).
class WorkerWithdrawPage extends StatefulWidget {
  const WorkerWithdrawPage({super.key});

  @override
  State<WorkerWithdrawPage> createState() => _WorkerWithdrawPageState();
}

class _WorkerWithdrawPageState extends State<WorkerWithdrawPage> {
  final int _availableBalance = 4860000;
  final TextEditingController _amountController = TextEditingController(text: '2000000');
  int _currentAmount = 2000000;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final clean = _amountController.text.replaceAll(RegExp('[^0-9]'), '');
    final val = int.tryParse(clean) ?? 0;
    setState(() {
      _currentAmount = val;
    });
  }

  void _selectQuickAmount(int amt) {
    setState(() {
      _currentAmount = amt;
      _amountController.text = amt.toString();
    });
  }

  bool get _isValid => _currentAmount >= 100000 && _currentAmount <= _availableBalance;

  String _formatVnd(int val) {
    final fmt = NumberFormat.decimalPattern('vi');
    return '${fmt.format(val)}đ';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final balanceAfter = _availableBalance - _currentAmount;

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
          l10n.wwdTitle,
          style: AppTextStyles.headlineMd.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
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
                                    hintStyle: AppTextStyles.headlineLg.copyWith(
                                      color: AppColors.textMuted,
                                    ),
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
                              _buildQuickChip(
                                label: '500k',
                                amount: 500000,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _buildQuickChip(
                                label: '1 triệu',
                                amount: 1000000,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _buildQuickChip(
                                label: l10n.wwdQuickAll,
                                amount: _availableBalance,
                              ),
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
                              Text(
                                l10n.wwdFromKyc,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.secondarySurface,
                                  borderRadius: BorderRadius.circular(AppRadius.chip),
                                  border: Border.all(color: AppColors.border),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.account_balance,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Vietcombank · CN Tân Bình',
                                      style: AppTextStyles.bodyMd.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '•••• 4821 · TRAN VAN HUNG',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                          _buildCalculationRow(
                            label: l10n.wwdCurrentBalance,
                            value: _formatVnd(_availableBalance),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _buildCalculationRow(
                            label: l10n.wwdMinAmount,
                            value: '100.000đ',
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          _buildCalculationRow(
                            label: l10n.wwdFee,
                            value: l10n.wwdFeeFree,
                            valueColor: AppColors.success,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const Divider(height: 1, color: AppColors.border),
                          const SizedBox(height: AppSpacing.sm),
                          _buildCalculationRow(
                            label: l10n.wwdBalanceAfter,
                            value: _formatVnd(balanceAfter >= 0 ? balanceAfter : 0),
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
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xFFA35A06),
                            size: 18,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              l10n.wwdPhase1Notice,
                              style: AppTextStyles.caption.copyWith(
                                color: const Color(0xFFA35A06),
                                height: 1.4,
                              ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  key: const Key('withdraw_continue_button'),
                  onPressed: _isValid
                      ? () => context.push(
                            AppRoutes.workerWithdrawPin,
                            extra: _formatVnd(_currentAmount),
                          )
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.border,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  child: Text(
                    _currentAmount < 100000
                        ? l10n.wwdMinValidation
                        : _currentAmount > _availableBalance
                            ? l10n.wwdMaxValidation
                            : l10n.wwdContinueCta,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickChip({required String label, required int amount}) {
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
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1.0,
            ),
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

  Widget _buildCalculationRow({
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
