part of 'booking_list_cubit.dart';

@immutable
sealed class BookingListState {
  const BookingListState();
}

final class BookingListInitialState extends BookingListState {
  const BookingListInitialState();
}

final class BookingListLoadingState extends BookingListState {
  const BookingListLoadingState();
}

final class BookingListLoadedState extends BookingListState {
  const BookingListLoadedState({
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

  BookingListLoadedState copyWith({List<Booking>? bookings, int? page, bool? hasMore, bool? isLoadingMore}) =>
      BookingListLoadedState(
        bookings: bookings ?? this.bookings,
        categoryNames: categoryNames,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      );

  @override
  bool operator ==(Object other) =>
      other is BookingListLoadedState &&
      listEquals(other.bookings, bookings) &&
      mapEquals(other.categoryNames, categoryNames) &&
      other.page == page &&
      other.hasMore == hasMore &&
      other.isLoadingMore == isLoadingMore;

  @override
  int get hashCode => Object.hash(Object.hashAll(bookings), page, hasMore, isLoadingMore);
}

final class BookingListErrorState extends BookingListState {
  const BookingListErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is BookingListErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
