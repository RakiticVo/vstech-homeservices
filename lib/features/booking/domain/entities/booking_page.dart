import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';

/// One page of `GET /api/v1/bookings`.
class BookingPage {
  const BookingPage({required this.items, required this.page, required this.hasMore});

  final List<Booking> items;
  final int page;
  final bool hasMore;
}
