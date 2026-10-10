import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_booking_use_case.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_category_use_case.dart';

part 'order_detail_state.dart';

/// One booking for the order detail screen, plus its category name.
@injectable
class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(this._getBooking, this._getCategory) : super(const OrderDetailInitialState());

  final GetBookingUseCase _getBooking;
  final GetCategoryUseCase _getCategory;

  Future<void> load(String bookingId, {bool refresh = false}) async {
    if (state is! OrderDetailLoadedState) emit(const OrderDetailLoadingState());
    switch (await _getBooking(bookingId, refresh: refresh)) {
      case Err(:final failure):
        emit(OrderDetailErrorState(failure));
      case Ok(value: final booking):
        final categoryId = booking.categoryId;
        String? name;
        if (categoryId != null) {
          name = switch (await _getCategory(categoryId)) {
            Ok(:final value) => value.name,
            Err() => null,
          };
        }
        emit(OrderDetailLoadedState(booking, serviceName: name));
    }
  }
}
