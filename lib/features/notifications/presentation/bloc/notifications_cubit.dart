import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/domain/usecases/notification_use_cases.dart';

part 'notifications_state.dart';

/// In-app notifications (`GET /notifications`) with a server-side type filter and manual
/// "load more" — the API returns a bare list without paging metadata.
@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._getNotifications, this._markRead, this._markAllRead)
    : super(const NotificationsLoadingState());

  final GetNotificationsUseCase _getNotifications;
  final MarkNotificationReadUseCase _markRead;
  final MarkAllNotificationsReadUseCase _markAllRead;

  NotificationType? _filter;

  /// Loads the first page. Passing a different [filter] (null = all) refetches from scratch.
  Future<void> load({NotificationType? filter, bool keepFilter = false}) async {
    final nextFilter = keepFilter ? _filter : filter;
    final filterChanged = nextFilter != _filter;
    _filter = nextFilter;
    if (state is! NotificationsLoadedState || filterChanged) {
      emit(NotificationsLoadingState(filter: nextFilter));
    }
    switch (await _getNotifications(type: nextFilter)) {
      case Ok(:final value):
        if (nextFilter != _filter) return;
        emit(
          NotificationsLoadedState(
            items: value.items,
            page: value.page,
            hasMore: value.hasMore,
            filter: nextFilter,
          ),
        );
      case Err(:final failure):
        if (nextFilter != _filter) return;
        emit(NotificationsErrorState(failure, filter: nextFilter));
    }
  }

  Future<void> refresh() => load(keepFilter: true);

  Future<void> loadMore() async {
    final current = state;
    if (current is! NotificationsLoadedState ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    emit(current.copyWith(isLoadingMore: true));
    switch (await _getNotifications(
      page: current.page + 1,
      type: current.filter,
    )) {
      case Ok(:final value):
        final known = {for (final n in current.items) n.id};
        emit(
          current.copyWith(
            items: [
              ...current.items,
              for (final n in value.items)
                if (!known.contains(n.id)) n,
            ],
            page: value.page,
            hasMore: value.hasMore,
            isLoadingMore: false,
          ),
        );
      case Err(:final failure):
        emit(current.copyWith(isLoadingMore: false, actionFailure: failure));
    }
  }

  /// Optimistically marks one notification read; reverts if the server refuses.
  Future<void> markRead(String id) async {
    final current = state;
    if (current is! NotificationsLoadedState) return;
    final target = current.items.where((n) => n.id == id).firstOrNull;
    if (target == null || target.isRead) return;
    emit(
      current.copyWith(
        items: _withRead(current.items, (n) => n.id == id, read: true),
      ),
    );
    if (await _markRead(id) case Err(:final failure)) {
      final latest = state;
      if (latest is NotificationsLoadedState) {
        emit(
          latest.copyWith(
            items: _withRead(latest.items, (n) => n.id == id, read: false),
            actionFailure: failure,
          ),
        );
      }
    }
  }

  /// Optimistically marks everything read; restores the previous list if the server refuses.
  Future<void> markAllRead() async {
    final current = state;
    if (current is! NotificationsLoadedState || current.unreadCount == 0) {
      return;
    }
    emit(
      current.copyWith(
        items: _withRead(current.items, (_) => true, read: true),
      ),
    );
    if (await _markAllRead() case Err(:final failure)) {
      final latest = state;
      if (latest is NotificationsLoadedState) {
        emit(latest.copyWith(items: current.items, actionFailure: failure));
      }
    }
  }

  static List<AppNotification> _withRead(
    List<AppNotification> items,
    bool Function(AppNotification) test, {
    required bool read,
  }) => [
    for (final n in items)
      if (test(n)) n.copyWith(isRead: read) else n,
  ];
}
