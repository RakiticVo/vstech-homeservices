part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {
  const NotificationsState({this.filter});

  /// Active type filter; null = all types.
  final NotificationType? filter;
}

final class NotificationsLoadingState extends NotificationsState {
  const NotificationsLoadingState({super.filter});

  @override
  bool operator ==(Object other) =>
      other is NotificationsLoadingState && other.filter == filter;

  @override
  int get hashCode => filter.hashCode;
}

final class NotificationsErrorState extends NotificationsState {
  const NotificationsErrorState(this.failure, {super.filter});

  final Failure failure;

  @override
  bool operator ==(Object other) =>
      other is NotificationsErrorState &&
      other.failure == failure &&
      other.filter == filter;

  @override
  int get hashCode => Object.hash(failure, filter);
}

final class NotificationsLoadedState extends NotificationsState {
  const NotificationsLoadedState({
    required this.items,
    required this.page,
    required this.hasMore,
    super.filter,
    this.isLoadingMore = false,
    this.actionFailure,
  });

  final List<AppNotification> items;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  /// One-shot failure of load-more / mark-read, shown as a SnackBar.
  final Failure? actionFailure;

  int get unreadCount => items.where((n) => !n.isRead).length;

  /// Clears [actionFailure] unless a new one is passed.
  NotificationsLoadedState copyWith({
    List<AppNotification>? items,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    Failure? actionFailure,
  }) => NotificationsLoadedState(
    items: items ?? this.items,
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
    filter: filter,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    actionFailure: actionFailure,
  );

  @override
  bool operator ==(Object other) =>
      other is NotificationsLoadedState &&
      listEquals(other.items, items) &&
      other.page == page &&
      other.hasMore == hasMore &&
      other.filter == filter &&
      other.isLoadingMore == isLoadingMore &&
      other.actionFailure == actionFailure;

  @override
  int get hashCode => Object.hash(
    Object.hashAll(items),
    page,
    hasMore,
    filter,
    isLoadingMore,
    actionFailure,
  );
}
