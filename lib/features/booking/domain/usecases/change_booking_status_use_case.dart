import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';

/// Customer-side booking actions. Each returns the booking's new status.
@injectable
class CancelBookingUseCase {
  const CancelBookingUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<BookingStatus>> call(String bookingId) => _repository.cancel(bookingId);
}

@injectable
class DisputeBookingUseCase {
  const DisputeBookingUseCase(this._repository);

  final BookingRepository _repository;

  Future<Result<BookingStatus>> call(String bookingId) => _repository.dispute(bookingId);
}
