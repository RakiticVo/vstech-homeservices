import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_page.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';

/// One booking by id. The API has no `GET /bookings/{id}` yet, so this reads the repository cache
/// and otherwise pages through `GET /bookings` (bounded) until it finds it.
@injectable
class GetBookingUseCase {
  const GetBookingUseCase(this._repository);

  final BookingRepository _repository;

  static const int maxPages = 5;

  Future<Result<Booking>> call(String id, {bool refresh = false}) async {
    final cached = _repository.cached(id);
    if (cached != null && !refresh) return Ok(cached);
    for (var page = 0; page < maxPages; page++) {
      final result = await _repository.getMyBookings(page: page);
      if (result is Err<BookingPage>) return Err(result.failure);
      final value = (result as Ok<BookingPage>).value;
      for (final booking in value.items) {
        if (booking.id == id) return Ok(booking);
      }
      if (!value.hasMore) break;
    }
    return const Err(Failure(kind: NetworkErrorKind.server, errorCode: 'HS-404-0010', statusCode: 404));
  }
}
