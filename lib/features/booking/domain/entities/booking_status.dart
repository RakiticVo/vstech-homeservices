/// Booking lifecycle (`docs/reference/api/02-bookings.md` §1).
enum BookingStatus {
  pending,
  accepted,
  inProgress,
  completed,
  cancelled,
  dispute,
  dispatchFailed,
  unknown;

  static BookingStatus fromApi(String? value) => switch (value) {
    'PENDING' => BookingStatus.pending,
    'ACCEPTED' => BookingStatus.accepted,
    'IN_PROGRESS' => BookingStatus.inProgress,
    'COMPLETED' => BookingStatus.completed,
    'CANCELLED' => BookingStatus.cancelled,
    'DISPUTE' => BookingStatus.dispute,
    'DISPATCH_FAILED' => BookingStatus.dispatchFailed,
    _ => BookingStatus.unknown,
  };

  String get apiValue => switch (this) {
    BookingStatus.pending => 'PENDING',
    BookingStatus.accepted => 'ACCEPTED',
    BookingStatus.inProgress => 'IN_PROGRESS',
    BookingStatus.completed => 'COMPLETED',
    BookingStatus.cancelled => 'CANCELLED',
    BookingStatus.dispute => 'DISPUTE',
    BookingStatus.dispatchFailed => 'DISPATCH_FAILED',
    BookingStatus.unknown => throw UnsupportedError('No API value for $this'),
  };

  /// Customer may cancel before the work starts (state machine: PENDING/ACCEPTED → CANCELLED).
  bool get canCancel => this == BookingStatus.pending || this == BookingStatus.accepted;

  /// Disputes are only accepted once the job is COMPLETED (`HS-400-0014` otherwise).
  bool get canDispute => this == BookingStatus.completed;
}
