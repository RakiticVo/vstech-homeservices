import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/new_booking.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';

@injectable
class CreateBookingUseCase {
  CreateBookingUseCase(this._repository, {@ignoreParam DateTime Function()? now}) : _now = now ?? DateTime.now;

  final BookingRepository _repository;
  final DateTime Function() _now;

  /// Rejects a past [NewBooking.scheduledTime] locally with the same code the server would use
  /// (`HS-400-0002`), so the user gets the message without a round trip.
  Future<Result<Booking>> call(NewBooking booking) async {
    if (!booking.scheduledTime.isAfter(_now())) {
      return const Err(Failure(kind: NetworkErrorKind.unknown, errorCode: 'HS-400-0002'));
    }
    return await _repository.create(booking);
  }
}
