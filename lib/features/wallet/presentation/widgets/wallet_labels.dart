import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';

/// Localized label for a ledger entry type.
String transactionTypeLabel(BuildContext context, TransactionType type) {
  final l10n = context.l10n;
  return switch (type) {
    TransactionType.deposit => l10n.wtxTypeDeposit,
    TransactionType.commission => l10n.wtxTypeCommission,
    TransactionType.earning => l10n.wtxTypeEarning,
    TransactionType.tip => l10n.wtxTypeTip,
    TransactionType.withdrawal => l10n.wtxTypeWithdrawal,
    TransactionType.refund => l10n.wtxTypeRefund,
    TransactionType.unknown => l10n.wtxTypeOther,
  };
}

/// "+297.500đ" / "−2.000.000đ".
String signedAmount(WalletTransaction transaction) =>
    '${transaction.delta < 0 ? '−' : '+'}${MoneyFormatter.format(transaction.delta.abs())}';

/// Local "dd/MM · HH:mm" for a UTC timestamp.
String transactionTime(DateTime utc) => DateFormat('dd/MM · HH:mm').format(utc.toLocal());

/// Transaction status as Icon + Label + Color.
class TransactionStatusChip extends StatelessWidget {
  const TransactionStatusChip({required this.status, super.key});

  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, label, color) = switch (status) {
      TransactionStatus.completed => (Icons.check_circle_outline, l10n.wwalletStatusCompleted, AppColors.successDark),
      TransactionStatus.pending => (Icons.schedule, l10n.wwalletStatusProcessing, AppColors.warning),
      TransactionStatus.failed => (Icons.cancel_outlined, l10n.wwalletStatusFailed, AppColors.error),
      TransactionStatus.unknown => (Icons.help_outline, l10n.bookingStatusUnknown, AppColors.textSecondary),
    };
    return Container(
      key: Key('transaction_status_${status.name}'),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
