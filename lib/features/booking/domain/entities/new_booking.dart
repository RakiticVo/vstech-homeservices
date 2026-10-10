/// Everything `POST /api/v1/bookings` needs. [scheduledTime] is UTC.
class NewBooking {
  const NewBooking({
    required this.categoryId,
    required this.description,
    required this.addressDetail,
    required this.lat,
    required this.lng,
    required this.scheduledTime,
  });

  final String categoryId;
  final String description;
  final String addressDetail;
  final double lat;
  final double lng;
  final DateTime scheduledTime;
}
