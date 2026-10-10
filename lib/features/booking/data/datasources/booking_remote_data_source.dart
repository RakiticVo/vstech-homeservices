import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/data/models/booking_response.dart';
import 'package:vstech_home_services/features/booking/data/models/complete_booking_request.dart';
import 'package:vstech_home_services/features/booking/data/models/create_booking_request.dart';
import 'package:vstech_home_services/features/booking/data/models/estimate_request.dart';
import 'package:vstech_home_services/features/booking/data/models/estimate_response.dart';
import 'package:vstech_home_services/features/booking/data/models/quote_response.dart';
import 'package:vstech_home_services/features/booking/data/models/status_transition_response.dart';
import 'package:vstech_home_services/features/booking/data/models/submit_quote_request.dart';

/// `/api/v1/bookings` — customer and worker actions.
/// Every state-changing call sends `X-Idempotency-Key`.
@injectable
class BookingRemoteDataSource {
  const BookingRemoteDataSource(this._client);

  final ApiClient _client;

  Future<EstimateResponse> estimate(EstimateRequest request) async {
    final response = await _client.post(
      ApiEndpoints.bookingEstimate,
      body: request.toJson(),
      decode: (json) => EstimateResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  /// The module doc wraps the 201 body in `ApiResponse<BookingResponse>`; the OpenAPI spec says it
  /// is returned bare. Both shapes are accepted.
  Future<BookingResponse> createBooking(CreateBookingRequest request) async {
    final raw = await _client.sendUnwrapped(
      ApiEndpoints.bookings,
      method: 'POST',
      body: request.toJson(),
      idempotent: true,
    );
    if (raw is! Map<String, dynamic>) {
      throw const NetworkException(kind: NetworkErrorKind.unknown);
    }
    if (!raw.containsKey('data') || raw.containsKey('requestId')) return BookingResponse.fromJson(raw);
    final envelope = ApiResponse<BookingResponse>.fromJson(
      raw,
      (json) => BookingResponse.fromJson(json! as Map<String, dynamic>),
    );
    if (!envelope.isSuccess) {
      throw NetworkException(
        kind: NetworkErrorKind.server,
        errorCode: envelope.errorCode,
        statusCode: envelope.status,
        serverMessage: envelope.message,
      );
    }
    return envelope.requireData;
  }

  Future<PagedResponse<BookingResponse>> getBookings({required int page, required int size, String? status}) async {
    final response = await _client.get(
      ApiEndpoints.bookings,
      query: {'page': page, 'size': size, 'status': ?status},
      decode: (json) => PagedResponse.fromJson(
        json! as Map<String, dynamic>,
        (item) => BookingResponse.fromJson(item! as Map<String, dynamic>),
      ),
    );
    return response.requireData;
  }

  Future<StatusTransitionResponse> cancel(String bookingId) => _transition(ApiEndpoints.bookingCancel(bookingId));

  Future<StatusTransitionResponse> dispute(String bookingId) => _transition(ApiEndpoints.bookingDispute(bookingId));

  // --- worker ---

  Future<StatusTransitionResponse> accept(String bookingId) => _transition(ApiEndpoints.bookingAccept(bookingId));

  Future<StatusTransitionResponse> start(String bookingId) => _transition(ApiEndpoints.bookingStart(bookingId));

  Future<StatusTransitionResponse> complete(String bookingId, CompleteBookingRequest request) =>
      _transition(ApiEndpoints.bookingComplete(bookingId), body: request.toJson());

  Future<QuoteResponse> submitQuote(String bookingId, SubmitQuoteRequest request) =>
      _quoteDecision(ApiEndpoints.bookingQuote(bookingId), body: request.toJson());

  // --- customer quote decision ---

  Future<QuoteResponse> approveQuote(String bookingId) => _quoteDecision(ApiEndpoints.bookingQuoteApprove(bookingId));

  Future<QuoteResponse> rejectQuote(String bookingId) => _quoteDecision(ApiEndpoints.bookingQuoteReject(bookingId));

  Future<StatusTransitionResponse> _transition(String path, {Object? body}) async {
    final response = await _client.post(
      path,
      body: body,
      idempotent: true,
      decode: (json) => StatusTransitionResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<QuoteResponse> _quoteDecision(String path, {Object? body}) async {
    final response = await _client.post(
      path,
      body: body,
      idempotent: true,
      decode: (json) => QuoteResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }
}
