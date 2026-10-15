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
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_floating_dock.dart';

/// Worker Jobs Hub Screen (`wjobs` — Concept 02: Cells 40–42).
/// The worker's bookings from `GET /bookings` in 3 tabs — Assigned (new offers and accepted jobs),
/// Active (in progress) and Completed — each card leading to the next step of the job.
class WorkerJobsHubPage extends StatefulWidget {
  const WorkerJobsHubPage({super.key, this.initialTab = 0});

  final int initialTab;

  /// Statuses listed under each tab, in tab order.
  static const List<Set<BookingStatus>> tabStatuses = [
    {BookingStatus.pending, BookingStatus.accepted},
    {BookingStatus.inProgress},
    {
      BookingStatus.completed,
      BookingStatus.dispute,
      BookingStatus.cancelled,
      BookingStatus.dispatchFailed,
      BookingStatus.unknown,
    },
  ];

  @override
  State<WorkerJobsHubPage> createState() => _WorkerJobsHubPageState();
}

class _WorkerJobsHubPageState extends State<WorkerJobsHubPage> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab.clamp(
      0,
      WorkerJobsHubPage.tabStatuses.length - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          context.l10n.workerJobsTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () =>
                unawaited(context.push(AppRoutes.workerNotifications)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 3-Segment Filter Bar
              Container(
                color: AppColors.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    _buildTabItem(0, context.l10n.workerJobsTabAssigned),
                    const SizedBox(width: AppSpacing.sm),
                    _buildTabItem(1, context.l10n.workerJobsTabActive),
                    const SizedBox(width: AppSpacing.sm),
                    _buildTabItem(2, context.l10n.workerJobsTabCompleted),
                  ],
                ),
              ),
              Container(color: AppColors.border, height: 1),

              // Jobs List Body
              Expanded(
                child: BlocBuilder<BookingListCubit, BookingListState>(
                  builder: (context, state) => switch (state) {
                    BookingListInitialState() ||
                    BookingListLoadingState() => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                    BookingListErrorState(:final failure) => ListView(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      children: [
                        ErrorRetryView(
                          message: context.l10n.failureMessage(failure),
                          onRetry: () => unawaited(
                            context.read<BookingListCubit>().load(),
                          ),
                        ),
                      ],
                    ),
                    final BookingListLoadedState loaded => _buildList(loaded),
                  },
                ),
              ),
            ],
          ),

          // Floating Capsule Bottom Dock for Worker
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: WorkerFloatingDock(currentIndex: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BookingListLoadedState state) {
    final statuses = WorkerJobsHubPage.tabStatuses[_selectedTab];
    final jobs = [
      for (final booking in state.bookings)
        if (statuses.contains(booking.status)) booking,
    ];
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<BookingListCubit>().load(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.dockClearanceMax,
        ),
        itemCount: (jobs.isEmpty ? 1 : jobs.length) + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          if (jobs.isEmpty && index == 0) {
            return Padding(
              key: const Key('worker_jobs_empty'),
              padding: const EdgeInsets.only(top: AppSpacing.xl),
              child: Text(
                context.l10n.workerJobsEmpty,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }
          if (index >= jobs.length) {
            return state.isLoadingMore
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : AppSecondaryButton(
                    key: const Key('worker_jobs_load_more_button'),
                    label: context.l10n.ordersLoadMore,
                    icon: Icons.expand_more,
                    isFullWidth: true,
                    onPressed: () =>
                        unawaited(context.read<BookingListCubit>().loadMore()),
                  );
          }
          final job = jobs[index];
          return _JobCard(
            booking: job,
            serviceName: state.categoryNames[job.categoryId],
          );
        },
      ),
    );
  }

  Widget _buildTabItem(int index, String label) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        borderRadius: BorderRadius.circular(AppRadius.control),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondarySurface : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One job: code, status, service, time, address, price and the action for its next step.
class _JobCard extends StatelessWidget {
  const _JobCard({required this.booking, required this.serviceName});

  final Booking booking;
  final String? serviceName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheduledTime = booking.scheduledTime;
    final price = booking.finalPrice ?? booking.estimatedPrice;
    final (String? label, String? location) = switch (booking.status) {
      BookingStatus.pending => (
        l10n.workerViewAndAccept,
        AppRoutes.workerJobDetailLocation(booking.id),
      ),
      BookingStatus.accepted => (
        l10n.workerStartTravelCta,
        AppRoutes.workerEnRouteLocation(booking.id),
      ),
      BookingStatus.inProgress => (
        l10n.workerContinueJobCta,
        AppRoutes.workerExecutingLocation(booking.id),
      ),
      _ => (null, null),
    };
    return Container(
      key: Key('worker_job_card_${booking.id}'),
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
                  '#${booking.id}',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              BookingStatusChip(status: booking.status),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            serviceName ?? booking.description ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          if (scheduledTime != null)
            _InfoRow(
              icon: Icons.access_time_rounded,
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
          if (price != null) ...[
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Text(
                    booking.finalPrice != null
                        ? l10n.ordersFinalPrice
                        : l10n.bookingEstimatedPreview,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Text(
                  MoneyFormatter.format(price),
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
          if (label != null && location != null) ...[
            const SizedBox(height: AppSpacing.lg),
            AppButton.primary(
              key: Key('worker_job_action_${booking.id}'),
              label: label,
              onPressed: () => unawaited(context.push(location)),
            ),
          ],
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
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textMuted),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
