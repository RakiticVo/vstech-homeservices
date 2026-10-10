part of 'customer_orders_cubit.dart';

@immutable
sealed class CustomerOrdersState {
  const CustomerOrdersState();
}

final class CustomerOrdersInitialState extends CustomerOrdersState {
  const CustomerOrdersInitialState();
}

final class CustomerOrdersLoadingState extends CustomerOrdersState {
  const CustomerOrdersLoadingState();
}

final class CustomerOrdersLoadedState extends CustomerOrdersState {
  const CustomerOrdersLoadedState({
    required this.bookings,
    required this.categoryNames,
    required this.page,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<Booking> bookings;

  /// categoryId → name.
  final Map<String, String> categoryNames;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  CustomerOrdersLoadedState copyWith({List<Booking>? bookings, int? page, bool? hasMore, bool? isLoadingMore}) =>
      CustomerOrdersLoadedState(
        bookings: bookings ?? this.bookings,
        categoryNames: categoryNames,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      );

  @override
  bool operator ==(Object other) =>
      other is CustomerOrdersLoadedState &&
      listEquals(other.bookings, bookings) &&
      mapEquals(other.categoryNames, categoryNames) &&
      other.page == page &&
      other.hasMore == hasMore &&
      other.isLoadingMore == isLoadingMore;

  @override
  int get hashCode => Object.hash(Object.hashAll(bookings), page, hasMore, isLoadingMore);
}

final class CustomerOrdersErrorState extends CustomerOrdersState {
  const CustomerOrdersErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is CustomerOrdersErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
