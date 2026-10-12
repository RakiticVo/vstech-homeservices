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
import 'package:vstech_home_services/core/widgets/app_button.dart';
import 'package:vstech_home_services/core/widgets/error_retry_view.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:vstech_home_services/features/notifications/presentation/widgets/notification_tile.dart';

/// Notifications for customers (`notif`, Cell 64) and workers (`wnotif`, Cell 66), from
/// `GET /notifications`: type filter chips (server-side), Today / Earlier sections, mark one or all
/// as read, manual "load more". A booking notification opens the orders / jobs list because the
/// payload carries no booking id.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({
    required this.isWorker,
    this.settingsRoute,
    super.key,
  });

  final bool isWorker;

  /// Notification settings screen for this role; hides the settings action when null.
  final String? settingsRoute;

  static const List<NotificationType?> _filters = [
    null,
    NotificationType.booking,
    NotificationType.promo,
    NotificationType.system,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
          l10n.notificationsTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          if (settingsRoute != null)
            IconButton(
              key: const Key('notifications_settings_button'),
              tooltip: l10n.notifSettingsTitle,
              icon: const Icon(
                Icons.tune_rounded,
                color: AppColors.textSecondary,
              ),
              onPressed: () => unawaited(context.push(settingsRoute!)),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.border, height: 1),
        ),
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listenWhen: (previous, current) =>
            current is NotificationsLoadedState &&
            current.actionFailure != null,
        listener: (context, state) {
          final failure = (state as NotificationsLoadedState).actionFailure!;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(l10n.failureMessage(failure))),
            );
        },
        builder: (context, state) => Column(
          children: [
            _FilterBar(selected: state.filter, filters: _filters),
            Container(color: AppColors.border, height: 1),
            Expanded(
              child: switch (state) {
                NotificationsLoadingState() => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                NotificationsErrorState(:final failure) => Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ErrorRetryView(
                      message: l10n.failureMessage(failure),
                      onRetry: () => unawaited(
                        context.read<NotificationsCubit>().refresh(),
                      ),
                    ),
                  ),
                ),
                NotificationsLoadedState() => _Feed(
                  state: state,
                  isWorker: isWorker,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.selected, required this.filters});

  final NotificationType? selected;
  final List<NotificationType?> filters;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          for (final (index, filter) in filters.indexed) ...[
            if (index > 0) const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: _FilterChip(
                key: Key('notifications_filter_${filter?.name ?? 'all'}'),
                label: switch (filter) {
                  null => l10n.notificationsTabAll,
                  NotificationType.booking => l10n.notificationsTabOrders,
                  NotificationType.promo => l10n.notificationsTabPromo,
                  NotificationType.system => l10n.notificationsTabSystem,
                  NotificationType.unknown => l10n.notificationsTypeOther,
                },
                isSelected: filter == selected,
                onTap: () => unawaited(
                  context.read<NotificationsCubit>().load(filter: filter),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.chip),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: AppErgonomics.minTouchTarget,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.labelSmall.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _Feed extends StatelessWidget {
  const _Feed({required this.state, required this.isWorker});

  final NotificationsLoadedState state;
  final bool isWorker;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<NotificationsCubit>();
    final now = DateTime.now();
    bool isToday(AppNotification n) {
      final local = n.createdAt?.toLocal();
      return local != null &&
          local.year == now.year &&
          local.month == now.month &&
          local.day == now.day;
    }

    final today = state.items.where(isToday).toList();
    final earlier = state.items.where((n) => !isToday(n)).toList();
    final rows = <Widget>[
      if (state.unreadCount > 0)
        Align(
          alignment: Alignment.centerRight,
          child: AppSecondaryButton(
            key: const Key('notifications_mark_all_read'),
            label: l10n.notificationsMarkAllRead,
            icon: Icons.done_all_rounded,
            onPressed: () => unawaited(cubit.markAllRead()),
          ),
        ),
      if (today.isNotEmpty) ...[
        _SectionTitle(l10n.notificationsSectionToday),
        for (final n in today) _tile(context, n),
      ],
      if (earlier.isNotEmpty) ...[
        _SectionTitle(l10n.notificationsSectionEarlier),
        for (final n in earlier) _tile(context, n),
      ],
      if (state.hasMore)
        AppSecondaryButton(
          key: const Key('notifications_load_more'),
          label: l10n.notificationsLoadMore,
          icon: state.isLoadingMore ? null : Icons.expand_more_rounded,
          isFullWidth: true,
          onPressed: state.isLoadingMore
              ? null
              : () => unawaited(cubit.loadMore()),
        ),
    ];

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: cubit.refresh,
      child: state.items.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [_EmptyView()],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: rows.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (_, index) => rows[index],
            ),
    );
  }

  Widget _tile(BuildContext context, AppNotification notification) =>
      NotificationTile(
        key: Key('notification_${notification.id}'),
        notification: notification,
        onTap: () {
          final cubit = context.read<NotificationsCubit>();
          unawaited(cubit.markRead(notification.id));
          if (notification.type == NotificationType.booking) {
            unawaited(
              context.push(
                isWorker ? AppRoutes.workerJobsHub : AppRoutes.customerOrders,
              ),
            );
          }
        },
      );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.sm),
    child: Text(
      text,
      style: AppTextStyles.labelLarge.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        const Icon(
          Icons.notifications_none_rounded,
          size: 24,
          color: AppColors.textMuted,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.notificationsEmpty,
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.notificationsEmptyHint,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
