import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';

part 'booking.freezed.dart';

/// A customer's service request. Times are UTC — convert to local only for display.
@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required String id,
    required BookingStatus status,
    String? categoryId,
    String? assignedWorkerId,
    num? estimatedPrice,
    num? finalPrice,
    String? description,
    String? addressDetail,
    DateTime? scheduledTime,
    DateTime? createdAt,
  }) = _Booking;
}
