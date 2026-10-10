import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/price_estimate.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';

part 'booking_draft.freezed.dart';

/// What the customer has entered so far across the booking steps. [scheduledTime] is UTC.
@freezed
abstract class BookingDraft with _$BookingDraft {
  const factory BookingDraft({
    @Default('') String categoryId,
    ServiceCategory? category,
    @Default('') String description,
    PriceEstimate? estimate,
    @Default('') String address,
    GeoPoint? location,
    DateTime? scheduledTime,
    @Default('') String notes,
    Booking? booking,
  }) = _BookingDraft;

  const BookingDraft._();

  /// Description sent to the API: the problem description plus the optional notes for the worker.
  String get fullDescription => notes.trim().isEmpty ? description.trim() : '${description.trim()}\n${notes.trim()}';
}
