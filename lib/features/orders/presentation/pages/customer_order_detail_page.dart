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
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_schedule_label.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_status_chip.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/order_detail_cubit.dart';

/// Customer Order Detail Screen (`orderdet` — Concept 02: Cells 62, 63).
/// One booking's `BookingResponse` fields — status, service, schedule, address, issue description
/// and estimated/final price — with the actions its status allows: track the pro (accepted / in
/// progress), cancel (pending / accepted) or report an issue (completed).
class CustomerOrderDetailPage extends StatefulWidget {
  const CustomerOrderDetailPage({required this.bookingId, super.key});

  final String bookingId;

  @override
  State<CustomerOrderDetailPage> createState() =>
      _CustomerOrderDetailPageState();
}

class _CustomerOrderDetailPageState extends State<CustomerOrderDetailPage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<OrderDetailCubit>().load(widget.bookingId));
  }

  /// Opens a follow-up screen (cancel / dispute) and reloads afterwards — its status may change.
  Future<void> _pushAndReload(String location) async {
    final cubit = context.read<OrderDetailCubit>();
    await context.push(location);
    unawaited(cubit.load(widget.bookingId));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderDetailCubit>().state;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          context.l10n.orderDetailTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: switch (state) {
        OrderDetailInitialState() || OrderDetailLoadingState() => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        OrderDetailErrorState(:final failure) => Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ErrorRetryView(
            message: context.l10n.failureMessage(failure),
            onRetry: () => unawaited(
              context.read<OrderDetailCubit>().load(
                widget.bookingId,
                refresh: true,
              ),
            ),
          ),
        ),
        OrderDetailLoadedState(:final booking, :final serviceName) =>
          _buildBody(booking, serviceName),
      },
    );
  }

  Widget _buildBody(Booking booking, String? serviceName) {
    final l10n = context.l10n;
    final scheduledTime = booking.scheduledTime;
    final canTrack =
        booking.status == BookingStatus.accepted ||
        booking.status == BookingStatus.inProgress;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              // Order header: code + status (Icon + Label + Color)
              _Section(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.complaintDetailOrderCode('#${booking.id}'),
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    BookingStatusChip(status: booking.status),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Service, schedule, address, issue
              _Section(
                title: l10n.orderDetailScheduleCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (serviceName != null)
                      Text(
                        serviceName,
                        style: AppTextStyles.titleLg.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    if (scheduledTime != null)
                      _InfoRow(
                        icon: Icons.calendar_today_outlined,
                        text: bookingScheduleLabel(context, scheduledTime),
                      ),
                    if (booking.addressDetail?.isNotEmpty ?? false)
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        text: booking.addressDetail!,
                      ),
                    if (booking.description?.isNotEmpty ?? false)
                      _InfoRow(
                        icon: Icons.description_outlined,
                        text: booking.description!,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Price: estimate until the pro completes, then the final price
              _Section(
                title: l10n.orderDetailPriceCard,
                child: Column(
                  children: [
                    if (booking.estimatedPrice != null)
                      _PriceRow(
                        label: l10n.bookingEstimatedPreview,
                        value: MoneyFormatter.format(booking.estimatedPrice!),
                      ),
                    if (booking.finalPrice != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      _PriceRow(
                        label: l10n.ordersFinalPrice,
                        value: MoneyFormatter.format(booking.finalPrice!),
                        emphasized: true,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            l10n.bookingPayAfterInspectNotice,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Status-dependent actions
        if (canTrack || booking.status.canCancel || booking.status.canDispute)
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (canTrack)
                  AppButton.primary(
                    key: const Key('order_detail_track_button'),
                    label: l10n.ordersTrackWorkerCta,
                    icon: Icons.map_outlined,
                    onPressed: () => unawaited(
                      context.push(
                        '${AppRoutes.customerTracking}?code=${booking.id}',
                      ),
                    ),
                  ),
                if (canTrack) ...[
                  const SizedBox(height: AppSpacing.sm),
                  AppSecondaryButton(
                    key: const Key('order_detail_chat_button'),
                    label: l10n.trackingChat,
                    icon: Icons.chat_bubble_outline_rounded,
                    isFullWidth: true,
                    onPressed: () => unawaited(
                      context.push(
                        AppRoutes.chatLocation(
                          bookingId: booking.id,
                          isWorker: false,
                        ),
                      ),
                    ),
                  ),
                ],
                if (canTrack &&
                    (booking.status.canCancel || booking.status.canDispute))
                  const SizedBox(height: AppSpacing.sm),
                if (booking.status.canCancel)
                  AppSecondaryButton(
                    key: const Key('order_detail_cancel_button'),
                    label: l10n.orderDetailCancelCta,
                    icon: Icons.cancel_outlined,
                    isFullWidth: true,
                    textColor: AppColors.error,
                    onPressed: () => unawaited(
                      _pushAndReload(
                        AppRoutes.customerCancelLocation(booking.id),
                      ),
                    ),
                  ),
                if (booking.status.canDispute)
                  AppSecondaryButton(
                    key: const Key('order_detail_dispute_button'),
                    label: l10n.orderDetailReportIssue,
                    icon: Icons.report_problem_outlined,
                    isFullWidth: true,
                    onPressed: () => unawaited(
                      _pushAndReload(
                        AppRoutes.disputeReportLocation(booking.id),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.child, this.title});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textMuted),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          style:
              (emphasized
                      ? AppTextStyles.headlineSmall
                      : AppTextStyles.bodyMedium)
                  .copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
        ),
      ],
    );
  }
}
