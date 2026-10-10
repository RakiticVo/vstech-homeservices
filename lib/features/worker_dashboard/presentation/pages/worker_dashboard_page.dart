import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/constants/app_colors.dart';
import 'package:vstech_home_services/core/constants/app_spacing.dart';
import 'package:vstech_home_services/core/constants/app_text_styles.dart';
import 'package:vstech_home_services/core/extensions/l10n_extension.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_schedule_label.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/bloc/worker_presence_cubit.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_earnings_card.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_floating_dock.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_job_request_card.dart';

/// Worker Dashboard ("Việc hôm nay") screen.
/// Adheres strictly to Master Spec v9.0 and Concept 02:
/// - Warm ivory background (#FAF9F6)
/// - Top header with Online/Offline toggle ([WorkerPresenceCubit] — Online broadcasts GPS every ~2 s)
/// - Deep Teal earnings card (#0E5952)
/// - New job card: the first PENDING booking from `GET /bookings` (no dispatch WebSocket format yet)
/// - Today's schedule list
/// - Fixed capsule 4-tab floating bottom dock with 128px scroll clearance.
class WorkerDashboardPage extends StatefulWidget {
  const WorkerDashboardPage({super.key});

  @override
  State<WorkerDashboardPage> createState() => _WorkerDashboardPageState();
}

class _WorkerDashboardPageState extends State<WorkerDashboardPage> {
  int _currentTabIndex = 0;

  /// Offers hidden with the decline button on this device — the API has no decline endpoint yet.
  final Set<String> _dismissedOfferIds = {};

  void _onPresenceChanged(BuildContext context, WorkerPresenceState state) {
    if (state is! WorkerPresenceErrorState) return;
    final message = switch (state.reason) {
      LocationFailure.permissionDenied => context.l10n.bookingLocationDenied,
      LocationFailure.serviceDisabled => context.l10n.bookingLocationServiceOff,
      LocationFailure.unavailable => context.l10n.bookingLocationUnavailable,
    };
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final presence = context.watch<WorkerPresenceCubit>().state;
    final isOnline = presence.isOnline;
    final jobs = context.watch<BookingListCubit>().state;
    final offer = jobs is BookingListLoadedState
        ? jobs.bookings
              .where((b) => b.status == BookingStatus.pending && !_dismissedOfferIds.contains(b.id))
              .firstOrNull
        : null;
    return BlocListener<WorkerPresenceCubit, WorkerPresenceState>(
      listener: _onPresenceChanged,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Top worker header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
                      child: Row(
                        children: [
                          // Worker avatar
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(AppRadius.control),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Center(child: Icon(Icons.person_rounded, color: AppColors.primary, size: 24)),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.workerGreeting('Hùng'),
                                  style: AppTextStyles.headlineSmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  context.l10n.workerGreetingSubtitle,
                                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          // Online / Offline toggle button
                          GestureDetector(
                            key: const Key('worker_online_toggle'),
                            onTap: () => unawaited(context.read<WorkerPresenceCubit>().toggle()),
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isOnline ? AppColors.secondarySurface : AppColors.surface,
                                borderRadius: BorderRadius.circular(AppRadius.full),
                                border: Border.all(color: isOnline ? AppColors.primary : AppColors.border),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: isOnline ? AppColors.success : AppColors.textMuted,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    isOnline ? context.l10n.workerOnline : context.l10n.workerOffline,
                                    style: AppTextStyles.caption.copyWith(
                                      color: isOnline ? AppColors.primary : AppColors.textSecondary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Main body content
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.dockClearanceMax,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Deep Teal Earnings Card
                        const WorkerEarningsCard(),
                        const SizedBox(height: AppSpacing.md),

                        // Incoming Job Dispatch Card
                        if (isOnline && offer != null) ...[
                          WorkerJobRequestCard(
                            key: Key('worker_job_offer_${offer.id}'),
                            jobTitle:
                                (jobs as BookingListLoadedState).categoryNames[offer.categoryId] ??
                                offer.description ??
                                '',
                            schedule: offer.scheduledTime == null
                                ? null
                                : bookingScheduleLabel(context, offer.scheduledTime!),
                            address: offer.addressDetail,
                            price: offer.estimatedPrice == null ? null : MoneyFormatter.format(offer.estimatedPrice!),
                            onViewAndAccept: () => unawaited(context.push(AppRoutes.workerJobDetailLocation(offer.id))),
                            onDecline: () => setState(() => _dismissedOfferIds.add(offer.id)),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                        ],

                        // Today's schedule title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.l10n.workerTodaySchedule,
                              style: AppTextStyles.headlineSmall.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.secondarySurface,
                                borderRadius: BorderRadius.circular(AppRadius.chip),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                context.l10n.workerJobsCompletedRatio,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        // Schedule item 1 (Done)
                        _ScheduleJobTile(
                          time: '08:30 - 10:00',
                          serviceName: context.l10n.jobSampleSchedule1Service,
                          customerName: context.l10n.jobSampleSchedule1Customer,
                          statusText: context.l10n.workerDone,
                          isDone: true,
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        // Schedule item 2 (Upcoming)
                        _ScheduleJobTile(
                          time: '14:00 - 15:30',
                          serviceName: context.l10n.jobSampleSchedule2Service,
                          customerName: context.l10n.jobSampleSchedule2Customer,
                          statusText: context.l10n.workerUpcoming,
                          isDone: false,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),

              // Fixed Floating Bottom Dock
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: WorkerFloatingDock(
                  currentIndex: _currentTabIndex,
                  onTabSelected: (index) {
                    setState(() {
                      _currentTabIndex = index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleJobTile extends StatelessWidget {
  const _ScheduleJobTile({
    required this.time,
    required this.serviceName,
    required this.customerName,
    required this.statusText,
    required this.isDone,
  });

  final String time;
  final String serviceName;
  final String customerName;
  final String statusText;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.chip),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              time,
              style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(customerName, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDone ? AppColors.success.withValues(alpha: 0.12) : AppColors.secondarySurface,
              borderRadius: BorderRadius.circular(AppRadius.chip),
              border: Border.all(
                color: isDone ? AppColors.success.withValues(alpha: 0.3) : AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              statusText,
              style: AppTextStyles.caption.copyWith(
                color: isDone ? AppColors.successDark : AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
