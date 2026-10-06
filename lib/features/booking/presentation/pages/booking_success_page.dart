import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';

/// Booking Step 4 — Done (`done` — Concept 02: Cell 46).
/// Highlights the order code and restates that payment happens after sign-off.
class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({
    super.key,
    this.orderCode = 'HS-2026-0012',
    this.total = 350000,
    this.date = 'today',
    this.slot = '14:00 - 16:00',
    this.paymentMethod = 'vietqr',
  });

  final String orderCode;
  final int total;

  /// 'today' or 'tomorrow', matching the booking step 2/3 query params.
  final String date;
  final String slot;

  /// 'vietqr', 'vnpay' or 'cash', matching booking step 3.
  final String paymentMethod;

  String _formatPrice(int amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)}đ';
  }

  String _methodLabel(BuildContext context) {
    switch (paymentMethod) {
      case 'vnpay':
        return context.l10n.bookingPaymentVnPay;
      case 'cash':
        return context.l10n.bookingPaymentCash;
      default:
        return context.l10n.bookingPaymentVietQR;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dayLabel =
        date == 'today' ? l10n.bookingScheduleToday : l10n.bookingScheduleTomorrow;
    final rows = <(String, String)>[
      (l10n.bookingSuccessServiceLabel, l10n.jobSampleCleaningTitle),
      (l10n.bookingSuccessTimeLabel, '$dayLabel · $slot'),
      (l10n.bookingSuccessAddressLabel, l10n.jobSampleCustomerAddress),
      (l10n.bookingSuccessEstimateLabel, _formatPrice(total)),
      (l10n.bookingSuccessPaymentLabel, l10n.bookingSuccessPayAfter(_methodLabel(context))),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  const SizedBox(height: AppSpacing.xl),
                  Center(
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: const Icon(
                        Icons.event_available_rounded,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.bookingSuccessTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headlineMd.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.bookingSuccessDesc,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.chip),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        '#$orderCode',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.card),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < rows.length; i++) ...[
                          if (i > 0) const Divider(height: 1, color: AppColors.border),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 96,
                                  child: Text(
                                    rows[i].$1,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    rows[i].$2,
                                    textAlign: TextAlign.right,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: AppButton.primary(
                label: l10n.bookingSuccessTrackCta,
                icon: Icons.radar_rounded,
                onPressed: () => context.go(AppRoutes.bookingMatching),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
