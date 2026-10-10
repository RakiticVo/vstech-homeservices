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
import 'package:vstech_home_services/features/home/presentation/widgets/customer_floating_dock.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart';

/// Customer Orders Hub Screen (`orders` — Concept 02: Cells 36–39).
/// The customer's bookings from `GET /bookings`, split into 3 tabs by status — Active (accepted,
/// in progress, disputed), Waiting (looking for a pro) and Done (completed / cancelled) — with
/// pull-to-refresh, manual "load more" paging, empty state and the fixed floating bottom dock.
class CustomerOrdersPage extends StatefulWidget {
  const CustomerOrdersPage({super.key, this.initialTab = 0});

  final int initialTab;

  /// Statuses listed under each tab, in tab order.
  static const List<Set<BookingStatus>> tabStatuses = [
    {BookingStatus.accepted, BookingStatus.inProgress, BookingStatus.dispute},
    {BookingStatus.pending, BookingStatus.dispatchFailed},
    {BookingStatus.completed, BookingStatus.cancelled, BookingStatus.unknown},
  ];

  @override
  State<CustomerOrdersPage> createState() => _CustomerOrdersPageState();
}

class _CustomerOrdersPageState extends State<CustomerOrdersPage> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab.clamp(0, CustomerOrdersPage.tabStatuses.length - 1);
  }

  void _onDockTabSelected(int index) {
    if (index == 1) return; // already here
    if (index == 0) {
      unawaited(context.push(AppRoutes.customerHome));
    } else if (index == 3) {
      unawaited(context.push(AppRoutes.customerNotifications));
    }
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
          context.l10n.ordersTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Segmented Tabs Filter (3 Tabs)
              Container(
                color: AppColors.surface,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    _buildFilterTab(0, context.l10n.ordersTabActive),
                    const SizedBox(width: AppSpacing.sm),
                    _buildFilterTab(1, context.l10n.ordersTabScheduled),
                    const SizedBox(width: AppSpacing.sm),
                    _buildFilterTab(2, context.l10n.ordersTabCompleted),
                  ],
                ),
              ),
              Container(color: AppColors.border, height: 1),

              // Tab Content Body
              Expanded(
                child: BlocBuilder<BookingListCubit, BookingListState>(
                  builder: (context, state) => switch (state) {
                    BookingListInitialState() || BookingListLoadingState() => const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    ),
                    BookingListErrorState(:final failure) => ListView(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      children: [
                        ErrorRetryView(
                          message: context.l10n.failureMessage(failure),
                          onRetry: () => unawaited(context.read<BookingListCubit>().load()),
                        ),
                      ],
                    ),
                    final BookingListLoadedState loaded => _buildList(loaded),
                  },
                ),
              ),
            ],
          ),

          // Floating Capsule Bottom Dock
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomerFloatingDock(
              currentIndex: 1, // Orders tab active
              onTabSelected: _onDockTabSelected,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BookingListLoadedState state) {
    final statuses = CustomerOrdersPage.tabStatuses[_selectedTab];
    final bookings = [
      for (final booking in state.bookings)
        if (statuses.contains(booking.status)) booking,
    ];
    final showLoadMore = state.hasMore;
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<BookingListCubit>().load(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.dockClearanceMax),
        itemCount: (bookings.isEmpty ? 1 : bookings.length) + (showLoadMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          if (bookings.isEmpty && index == 0) return _buildEmptyState();
          if (index >= bookings.length) {
            return state.isLoadingMore
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : AppSecondaryButton(
                    key: const Key('orders_load_more_button'),
                    label: context.l10n.ordersLoadMore,
                    icon: Icons.expand_more,
                    isFullWidth: true,
                    onPressed: () => unawaited(context.read<BookingListCubit>().loadMore()),
                  );
          }
          final booking = bookings[index];
          return _BookingCard(booking: booking, serviceName: state.categoryNames[booking.categoryId]);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      key: const Key('orders_empty_state'),
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 36,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.l10n.ordersEmptyTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            context.l10n.ordersEmptyDesc,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton.primary(
            label: context.l10n.ordersEmptyCta,
            icon: Icons.add_rounded,
            onPressed: () {
              unawaited(context.push(AppRoutes.categories));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(int index, String label) {
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

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.booking, required this.serviceName});

  final Booking booking;
  final String? serviceName;

  @override
  Widget build(BuildContext context) {
    final scheduledTime = booking.scheduledTime;
    final price = booking.finalPrice ?? booking.estimatedPrice;
    final canTrack = booking.status == BookingStatus.accepted || booking.status == BookingStatus.inProgress;
    return Container(
      key: Key('order_card_${booking.id}'),
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
                  style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
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
          if (scheduledTime != null) ...[
            const SizedBox(height: 4),
            _InfoRow(icon: Icons.access_time_rounded, text: bookingScheduleLabel(context, scheduledTime)),
          ],
          if (booking.addressDetail != null && booking.addressDetail!.isNotEmpty) ...[
            const SizedBox(height: 4),
            _InfoRow(icon: Icons.location_on_outlined, text: booking.addressDetail!),
          ],
          if (price != null) ...[
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Text(
                    booking.finalPrice != null ? context.l10n.ordersFinalPrice : context.l10n.bookingEstimatedPreview,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ),
                Text(
                  MoneyFormatter.format(price),
                  style: AppTextStyles.labelLarge.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: AppSecondaryButton(
                  key: Key('order_detail_button_${booking.id}'),
                  label: context.l10n.ordersViewDetailCta,
                  isFullWidth: true,
                  onPressed: () => unawaited(context.push(AppRoutes.customerOrderDetailLocation(booking.id))),
                ),
              ),
              if (canTrack) ...[
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: context.l10n.ordersTrackWorkerCta,
                    icon: Icons.map_outlined,
                    isFullWidth: true,
                    onPressed: () => unawaited(context.push('${AppRoutes.customerTracking}?code=${booking.id}')),
                  ),
                ),
              ],
            ],
          ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary))),
      ],
    );
  }
}
