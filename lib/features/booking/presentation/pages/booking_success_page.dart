import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_schedule_label.dart';

/// Booking Step 4 — Done (`done` — Concept 02: Cell 46).
/// Shows the booking just created by `POST /bookings` (its `requestId` as the order code) and
/// restates that payment happens after sign-off.
class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final draft = context.watch<BookingFlowBloc>().state.draft;
    final booking = draft.booking;
    final scheduledTime = booking?.scheduledTime ?? draft.scheduledTime;
    final estimate = booking?.estimatedPrice ?? draft.estimate?.totalEstimated;
    final orderCode = booking?.id ?? '';
    final rows = <(String, String)>[
      (l10n.bookingSuccessServiceLabel, draft.category?.name ?? ''),
      if (scheduledTime != null) (l10n.bookingSuccessTimeLabel, bookingScheduleLabel(context, scheduledTime)),
      (l10n.bookingSuccessAddressLabel, booking?.addressDetail ?? draft.address),
      if (estimate != null) (l10n.bookingSuccessEstimateLabel, MoneyFormatter.format(estimate)),
      (l10n.bookingSuccessPaymentLabel, l10n.bookingPayAfterInspection),
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
                        key: const Key('booking_order_code'),
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
