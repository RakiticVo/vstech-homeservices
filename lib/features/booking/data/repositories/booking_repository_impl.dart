import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:vstech_home_services/features/booking/data/models/booking_response.dart';
import 'package:vstech_home_services/features/booking/data/models/complete_booking_request.dart';
import 'package:vstech_home_services/features/booking/data/models/create_booking_request.dart';
import 'package:vstech_home_services/features/booking/data/models/estimate_request.dart';
import 'package:vstech_home_services/features/booking/data/models/quote_item_request.dart';
import 'package:vstech_home_services/features/booking/data/models/status_transition_response.dart';
import 'package:vstech_home_services/features/booking/data/models/submit_quote_request.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_page.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/new_booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/price_estimate.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/booking/domain/repositories/booking_repository.dart';

/// Singleton so the in-memory cache of fetched bookings survives between screens — order detail
/// reads from it because the API has no `GET /bookings/{id}`.
@LazySingleton(as: BookingRepository)
class BookingRepositoryImpl implements BookingRepository {
  BookingRepositoryImpl(this._remote);

  final BookingRemoteDataSource _remote;
  final Map<String, Booking> _cache = {};

  static const int pageSize = 20;

  @override
  Future<Result<PriceEstimate>> estimate({required String categoryId, required String description}) =>
      Result.guard(() async {
        final r = await _remote.estimate(EstimateRequest(categoryId: categoryId, description: description));
        final commission = r.commissionFee ?? 0;
        return PriceEstimate(
          estimatedPrice: r.estimatedPrice,
          commissionFee: commission,
          totalEstimated: r.totalEstimated ?? r.estimatedPrice + commission,
          categoryName: r.categoryName,
        );
      });

  @override
  Future<Result<Booking>> create(NewBooking booking) => Result.guard(() async {
    final response = await _remote.createBooking(
      CreateBookingRequest(
        categoryId: booking.categoryId,
        description: booking.description,
        addressDetail: booking.addressDetail,
        locationLat: booking.lat,
        locationLng: booking.lng,
        scheduledTime: booking.scheduledTime.toUtc(),
      ),
    );
    return _remember(_toEntity(response));
  });

  @override
  Future<Result<BookingPage>> getMyBookings({required int page, BookingStatus? status}) => Result.guard(() async {
    final response = await _remote.getBookings(page: page, size: pageSize, status: status?.apiValue);
    return BookingPage(
      items: [for (final item in response.content) _remember(_toEntity(item))],
      page: response.page,
      hasMore: response.hasMore,
    );
  });

  @override
  Booking? cached(String id) => _cache[id];

  @override
  Future<Result<BookingStatus>> cancel(String bookingId) => _transition(bookingId, _remote.cancel);

  @override
  Future<Result<BookingStatus>> dispute(String bookingId) => _transition(bookingId, _remote.dispute);

  @override
  Future<Result<void>> approveQuote(String bookingId) => Result.guard(() => _remote.approveQuote(bookingId));

  @override
  Future<Result<void>> rejectQuote(String bookingId) => Result.guard(() => _remote.rejectQuote(bookingId));

  @override
  Future<Result<BookingStatus>> accept(String bookingId) => _transition(bookingId, _remote.accept);

  @override
  Future<Result<BookingStatus>> start(String bookingId) => _transition(bookingId, _remote.start);

  @override
  Future<Result<BookingStatus>> complete(String bookingId, {required num actualPrice}) =>
      _transition(bookingId, (id) => _remote.complete(id, CompleteBookingRequest(actualPrice: actualPrice)));

  @override
  Future<Result<void>> submitQuote(String bookingId, List<QuoteLine> lines) => Result.guard(
    () => _remote.submitQuote(
      bookingId,
      SubmitQuoteRequest(
        items: [for (final line in lines) QuoteItemRequest(itemName: line.itemName, amount: line.amount)],
      ),
    ),
  );

  Future<Result<BookingStatus>> _transition(
    String bookingId,
    Future<StatusTransitionResponse> Function(String bookingId) call,
  ) => Result.guard(() async {
    final response = await call(bookingId);
    final status = BookingStatus.fromApi(response.newStatus);
    final cached = _cache[bookingId];
    if (cached != null) _cache[bookingId] = cached.copyWith(status: status);
    return status;
  });

  Booking _remember(Booking booking) => _cache[booking.id] = booking;

  static Booking _toEntity(BookingResponse r) => Booking(
    id: r.requestId,
    status: BookingStatus.fromApi(r.status),
    categoryId: r.categoryId,
    assignedWorkerId: r.assignedWorkerId,
    estimatedPrice: r.estimatedPrice,
    finalPrice: r.finalPrice,
    description: r.description,
    addressDetail: r.addressDetail,
    scheduledTime: r.scheduledTime,
    createdAt: r.createdAt,
  );
}
