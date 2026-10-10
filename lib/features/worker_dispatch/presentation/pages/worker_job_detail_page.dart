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
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_schedule_label.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_status_chip.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/worker_task_cubit.dart';

/// Worker job detail (offer review). Shows the booking's service, schedule, address, the customer's
/// issue and the estimated price; a PENDING job is accepted with `POST /bookings/{id}/accept`,
/// after which the worker starts travelling.
class WorkerJobDetailPage extends StatefulWidget {
  const WorkerJobDetailPage({required this.bookingId, super.key});

  final String bookingId;

  @override
  State<WorkerJobDetailPage> createState() => _WorkerJobDetailPageState();
}

class _WorkerJobDetailPageState extends State<WorkerJobDetailPage> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<WorkerTaskCubit>().load(widget.bookingId));
  }

  void _onStateChanged(BuildContext context, WorkerTaskState state) {
    switch (state) {
      case WorkerTaskActionDoneState(action: WorkerTaskAction.accept):
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.jobAcceptedSuccess)));
        context.pushReplacement(AppRoutes.workerEnRouteLocation(widget.bookingId));
      case WorkerTaskActionFailedState(:final failure):
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(context.l10n.failureMessage(failure))));
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorkerTaskCubit>().state;
    return BlocListener<WorkerTaskCubit, WorkerTaskState>(
      listener: _onStateChanged,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.workerDashboard),
          ),
          title: Text(
            context.l10n.orderDetailTitle,
            style: AppTextStyles.headlineSmall.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ),
        body: SafeArea(
          child: switch (state) {
            WorkerTaskLoadingState() => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            WorkerTaskLoadErrorState(:final failure) => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ErrorRetryView(
                message: context.l10n.failureMessage(failure),
                onRetry: () => unawaited(context.read<WorkerTaskCubit>().load(widget.bookingId)),
              ),
            ),
            final WorkerTaskWithDataState loaded => _buildBody(loaded),
          },
        ),
      ),
    );
  }

  Widget _buildBody(WorkerTaskWithDataState state) {
    final l10n = context.l10n;
    final booking = state.task.booking;
    final scheduledTime = booking.scheduledTime;
    final isBusy = state is WorkerTaskBusyState;
    final (String? label, VoidCallback? onPressed) = switch (booking.status) {
      BookingStatus.pending => (l10n.jobAcceptCta, () => unawaited(context.read<WorkerTaskCubit>().accept())),
      BookingStatus.accepted => (
        l10n.workerStartTravelCta,
        () => unawaited(context.push(AppRoutes.workerEnRouteLocation(booking.id))),
      ),
      BookingStatus.inProgress => (
        l10n.workerContinueJobCta,
        () => unawaited(context.push(AppRoutes.workerExecutingLocation(booking.id))),
      ),
      _ => (null, null),
    };
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      state.task.serviceName ?? '',
                      style: AppTextStyles.titleLg.copyWith(fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                    if (scheduledTime != null)
                      _InfoRow(icon: Icons.access_time_rounded, text: bookingScheduleLabel(context, scheduledTime)),
                    if (booking.addressDetail?.isNotEmpty ?? false)
                      _InfoRow(icon: Icons.location_on_outlined, text: booking.addressDetail!),
                    if (booking.description?.isNotEmpty ?? false)
                      _InfoRow(icon: Icons.description_outlined, text: booking.description!),
                    if (booking.estimatedPrice != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      const Divider(height: 1, color: AppColors.border),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.bookingEstimatedPreview,
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                            ),
                          ),
                          Text(
                            MoneyFormatter.format(booking.estimatedPrice!),
                            style: AppTextStyles.headlineSmall.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        if (label != null)
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: AppButton.primary(
              key: const Key('worker_job_detail_cta'),
              label: label,
              isLoading: isBusy,
              onPressed: isBusy ? null : onPressed,
            ),
          ),
      ],
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
          Expanded(child: Text(text, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary))),
        ],
      ),
    );
  }
}
