import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';

/// Status of the last extra-cost quote on the In-progress screen (design Cell 133), always as
/// Icon + Label + Color. Approved / declined only show once the app can learn the customer's
/// decision — today it only knows what the submit response said (NOTES L29).
class QuoteStatusCard extends StatelessWidget {
  const QuoteStatusCard({
    required this.quote,
    required this.estimatedPrice,
    required this.onMessage,
    required this.onContinue,
    super.key,
  });

  final SubmittedQuote quote;
  final num? estimatedPrice;
  final VoidCallback onMessage;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (IconData icon, Color color, String label) = switch (quote.status) {
      QuoteStatus.pending => (
        Icons.schedule_rounded,
        AppColors.warning,
        l10n.quoteStatusPending,
      ),
      QuoteStatus.approved => (
        Icons.check_circle_outline_rounded,
        AppColors.successDark,
        l10n.quoteStatusApproved,
      ),
      QuoteStatus.rejected => (
        Icons.cancel_outlined,
        AppColors.error,
        l10n.quoteStatusRejected,
      ),
      QuoteStatus.cancelled => (
        Icons.info_outline_rounded,
        AppColors.textSecondary,
        l10n.quoteStatusCancelled,
      ),
    };
    final sentAt = quote.submittedAt?.toLocal();

    return Container(
      key: Key('quote_status_${quote.status.name}'),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: color),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: color,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _Row(
            label: l10n.quoteTotalLabel,
            value: '+${MoneyFormatter.format(quote.totalAmount)}',
            emphasized: true,
          ),
          if (quote.status == QuoteStatus.pending) ...[
            Text(
              [
                l10n.quoteItemsCount(quote.lines.length),
                if (sentAt != null)
                  l10n.quoteSentAt(
                    DateFormat('HH:mm · dd/MM/yyyy').format(sentAt),
                  ),
              ].join(' · '),
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppSecondaryButton(
              key: const Key('quote_review_button'),
              label: l10n.quoteReview,
              icon: Icons.receipt_long_outlined,
              isFullWidth: true,
              onPressed: () => _showReview(context),
            ),
          ],
          if (quote.status == QuoteStatus.approved && estimatedPrice != null)
            _Row(
              label: l10n.quoteNewTotal,
              value: MoneyFormatter.format(estimatedPrice! + quote.totalAmount),
              emphasized: true,
            ),
          if (quote.status == QuoteStatus.rejected) ...[
            Text(
              l10n.quoteRejectedHint,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    key: const Key('quote_message_button'),
                    label: l10n.trackingChat,
                    icon: Icons.chat_bubble_outline_rounded,
                    isFullWidth: true,
                    onPressed: onMessage,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppButton.primary(
                    key: const Key('quote_continue_button'),
                    label: l10n.quoteContinueWork,
                    onPressed: onContinue,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showReview(BuildContext context) {
    final l10n = context.l10n;
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.card),
          ),
        ),
        builder: (sheetContext) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.quoteTitle,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                for (final line in quote.lines)
                  _Row(
                    label: line.itemName,
                    value: MoneyFormatter.format(line.amount),
                  ),
                const Divider(height: AppSpacing.lg, color: AppColors.border),
                _Row(
                  label: l10n.quoteTotalLabel,
                  value: MoneyFormatter.format(quote.totalAmount),
                  emphasized: true,
                ),
                const SizedBox(height: AppSpacing.md),
                AppSecondaryButton(
                  label: l10n.quoteClose,
                  icon: Icons.close_rounded,
                  isFullWidth: true,
                  onPressed: () => Navigator.of(sheetContext).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: emphasized ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
