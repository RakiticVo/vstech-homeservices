import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_my_bookings_use_case.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_categories_use_case.dart';

part 'customer_orders_state.dart';

/// The customer's bookings (`GET /bookings`, paged) plus category names to label them — a booking
/// only carries its `categoryId`.
@injectable
class CustomerOrdersCubit extends Cubit<CustomerOrdersState> {
  CustomerOrdersCubit(this._getBookings, this._getCategories) : super(const CustomerOrdersInitialState());

  final GetMyBookingsUseCase _getBookings;
  final GetCategoriesUseCase _getCategories;

  Future<void> load() async {
    if (state is! CustomerOrdersLoadedState) emit(const CustomerOrdersLoadingState());
    final (bookings, categories) = await (_getBookings(), _getCategories()).wait;
    switch (bookings) {
      case Err(:final failure):
        emit(CustomerOrdersErrorState(failure));
      case Ok(:final value):
        final names = switch (categories) {
          Ok(value: final list) => {for (final category in list) category.id: category.name},
          Err() => const <String, String>{},
        };
        emit(CustomerOrdersLoadedState(bookings: value.items, categoryNames: names, page: value.page, hasMore: value.hasMore));
    }
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! CustomerOrdersLoadedState || !current.hasMore || current.isLoadingMore) return;
    emit(current.copyWith(isLoadingMore: true));
    switch (await _getBookings(page: current.page + 1)) {
      case Ok(:final value):
        emit(
          current.copyWith(
            bookings: [...current.bookings, ...value.items],
            page: value.page,
            hasMore: value.hasMore,
            isLoadingMore: false,
          ),
        );
      case Err():
        emit(current.copyWith(isLoadingMore: false));
    }
  }
}
