part of 'customer_tracking_cubit.dart';

/// What the customer sees, derived from [BookingStatus].
enum TrackingStage {
  /// ACCEPTED — the worker is on the way (the API has no separate "arrived" status).
  enRoute,

  /// IN_PROGRESS — work has started.
  working,

  /// COMPLETED — waiting for the customer's sign-off.
  awaitingSignoff,

  /// Anything else (pending, cancelled, disputed…) — nothing to track.
  inactive;

  static TrackingStage of(BookingStatus status) => switch (status) {
    BookingStatus.accepted => TrackingStage.enRoute,
    BookingStatus.inProgress => TrackingStage.working,
    BookingStatus.completed => TrackingStage.awaitingSignoff,
    _ => TrackingStage.inactive,
  };

  /// The server only streams positions for ACCEPTED / IN_PROGRESS bookings.
  bool get isTrackable =>
      this == TrackingStage.enRoute || this == TrackingStage.working;
}

@immutable
sealed class CustomerTrackingState {
  const CustomerTrackingState();
}

final class CustomerTrackingLoadingState extends CustomerTrackingState {
  const CustomerTrackingLoadingState();
}

final class CustomerTrackingErrorState extends CustomerTrackingState {
  const CustomerTrackingErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) =>
      other is CustomerTrackingErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}

final class CustomerTrackingLoadedState extends CustomerTrackingState {
  const CustomerTrackingLoadedState({
    required this.booking,
    this.home,
    this.position,
    this.connection = TrackingConnectionStatus.connecting,
    this.errorCode,
  });

  final Booking booking;

  /// Default address coordinates from the profile — the booking response has no location, so
  /// distance is measured to this (NOTES L30).
  final (double, double)? home;

  /// Last position the socket reported; null until the worker's GPS comes in.
  final WorkerPosition? position;
  final TrackingConnectionStatus connection;

  /// Set when the server rejected tracking (`ERROR` frame); empty string = no code given.
  final String? errorCode;

  TrackingStage get stage => TrackingStage.of(booking.status);

  /// Metres from the worker to [home], when both are known.
  double? get distanceMeters {
    final p = position;
    final h = home;
    if (p == null || h == null) return null;
    return p.distanceTo(latitude: h.$1, longitude: h.$2);
  }

  CustomerTrackingLoadedState copyWith({
    WorkerPosition? position,
    TrackingConnectionStatus? connection,
    String? errorCode,
    bool clearErrorCode = false,
  }) => CustomerTrackingLoadedState(
    booking: booking,
    home: home,
    position: position ?? this.position,
    connection: connection ?? this.connection,
    errorCode: clearErrorCode ? null : errorCode ?? this.errorCode,
  );

  @override
  bool operator ==(Object other) =>
      other is CustomerTrackingLoadedState &&
      other.booking == booking &&
      other.home == home &&
      other.position == position &&
      other.connection == connection &&
      other.errorCode == errorCode;

  @override
  int get hashCode =>
      Object.hash(booking, home, position, connection, errorCode);
}
