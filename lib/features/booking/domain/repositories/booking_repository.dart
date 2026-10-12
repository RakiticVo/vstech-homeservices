import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_page.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/new_booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/price_estimate.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';

abstract interface class BookingRepository {
  Future<Result<PriceEstimate>> estimate({
    required String categoryId,
    required String description,
  });

  Future<Result<Booking>> create(NewBooking booking);

  /// The signed-in user's bookings, newest first as returned by the API; [status] null = all.
  Future<Result<BookingPage>> getMyBookings({
    required int page,
    BookingStatus? status,
  });

  /// Last fetched copy of a booking — there is no `GET /bookings/{id}` endpoint yet.
  Booking? cached(String id);

  Future<Result<BookingStatus>> cancel(String bookingId);

  Future<Result<BookingStatus>> dispute(String bookingId);

  Future<Result<void>> approveQuote(String bookingId);

  // --- worker ---

  Future<Result<BookingStatus>> accept(String bookingId);

  Future<Result<BookingStatus>> start(String bookingId);

  Future<Result<BookingStatus>> complete(
    String bookingId, {
    required num actualPrice,
  });

  Future<Result<void>> submitQuote(String bookingId, List<QuoteLine> lines);

  Future<Result<void>> rejectQuote(String bookingId);
}
