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
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_schedule_label.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_step_indicator.dart';

/// Step 3 of Customer Booking: review the request and the server estimate (`estimatedPrice` +
/// `commissionFee` = `totalEstimated`), then create it with `POST /bookings`. Payment happens after
/// the customer inspects the work.
class BookingStep3ConfirmPage extends StatelessWidget {
  const BookingStep3ConfirmPage({super.key});

  void _onStateChanged(BuildContext context, BookingFlowState state) {
    switch (state) {
      case BookingFlowSubmittedState():
        context.go(AppRoutes.bookingSuccess);
      case BookingFlowErrorState(:final failure):
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(context.l10n.failureMessage(failure))));
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BookingFlowBloc>().state;
    final draft = state.draft;
    final estimate = draft.estimate;
    final scheduledTime = draft.scheduledTime;
    final isSubmitting = state is BookingFlowSubmittingState;

    return BlocListener<BookingFlowBloc, BookingFlowState>(
      listener: _onStateChanged,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: BookingStepIndicator(currentStep: 3, stepTitle: context.l10n.bookingStep3Title),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  children: [
                    // Service, schedule, address and issue recap
                    _Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            draft.category?.name ?? estimate?.categoryName ?? '',
                            style: AppTextStyles.titleLg.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          if (scheduledTime != null)
                            _RecapRow(icon: Icons.calendar_today_outlined, text: bookingScheduleLabel(context, scheduledTime)),
                          _RecapRow(icon: Icons.location_on_outlined, text: draft.address),
                          _RecapRow(icon: Icons.description_outlined, text: draft.fullDescription),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Server estimate breakdown
                    Text(
                      context.l10n.bookingOrderSummary,
                      style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (estimate != null)
                      _Card(
                        child: Column(
                          children: [
                            _PriceRow(
                              label: context.l10n.bookingServicePriceLabel,
                              value: MoneyFormatter.format(estimate.estimatedPrice),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _PriceRow(
                              label: context.l10n.bookingPlatformFeeLabel,
                              value: MoneyFormatter.format(estimate.commissionFee),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                              child: Divider(color: AppColors.border, height: 1),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    context.l10n.bookingTotalEstimated,
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Text(
                                  MoneyFormatter.format(estimate.totalEstimated),
                                  key: const Key('booking_total_estimated'),
                                  style: AppTextStyles.headlineSmall.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: AppSpacing.md),

                    // Guarantee notices
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.secondarySurface,
                        borderRadius: BorderRadius.circular(AppRadius.card),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.verified_outlined, size: 18, color: AppColors.primary),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  context.l10n.bookingWarranty30DaysBadge,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            context.l10n.bookingPayAfterInspectNotice,
                            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Pinned primary CTA
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: AppButton.primary(
                  key: const Key('booking_confirm_button'),
                  label: context.l10n.bookingConfirmCta(MoneyFormatter.format(estimate?.totalEstimated ?? 0)),
                  isLoading: isSubmitting,
                  onPressed: isSubmitting ? null : () => context.read<BookingFlowBloc>().add(const BookingConfirmedEvent()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _RecapRow extends StatelessWidget {
  const _RecapRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(text, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
        ),
        Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      ],
    );
  }
}
