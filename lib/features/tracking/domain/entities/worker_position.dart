import 'dart:math' as math;

import 'package:flutter/foundation.dart';

/// Last known GPS position of the assigned worker. [updatedAt] is UTC.
@immutable
class WorkerPosition {
  const WorkerPosition({
    required this.latitude,
    required this.longitude,
    this.heading,
    this.updatedAt,
  });

  final double latitude;
  final double longitude;

  /// Degrees clockwise from north, if the device reports it.
  final double? heading;
  final DateTime? updatedAt;

  /// Great-circle distance in metres to ([latitude], [longitude]) — haversine, good enough for "about
  /// 2,4 km away" (there is no routing API for a real ETA).
  double distanceTo({required double latitude, required double longitude}) {
    const earthRadius = 6371000.0;
    double rad(double degrees) => degrees * math.pi / 180;
    final dLat = rad(latitude - this.latitude);
    final dLng = rad(longitude - this.longitude);
    final a =
        math.pow(math.sin(dLat / 2), 2) +
        math.cos(rad(this.latitude)) *
            math.cos(rad(latitude)) *
            math.pow(math.sin(dLng / 2), 2);
    return 2 * earthRadius * math.asin(math.sqrt(a));
  }

  @override
  bool operator ==(Object other) =>
      other is WorkerPosition &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.heading == heading &&
      other.updatedAt == updatedAt;

  @override
  int get hashCode => Object.hash(latitude, longitude, heading, updatedAt);
}

/// Something the tracking socket told us.
@immutable
sealed class TrackingEvent {
  const TrackingEvent();
}

/// `CONNECTED` (first fix, may be null if the worker has not sent GPS yet) or `LOCATION_UPDATE`.
final class TrackingPositionEvent extends TrackingEvent {
  const TrackingPositionEvent(this.position);

  final WorkerPosition? position;
}

/// `TRACKING_ENDED` — the job moved on (e.g. `COMPLETED`); the server closes the socket.
final class TrackingEndedEvent extends TrackingEvent {
  const TrackingEndedEvent(this.reason);

  final String? reason;
}

/// `ERROR` — e.g. not this customer's booking or the booking is not ACCEPTED / IN_PROGRESS.
final class TrackingErrorEvent extends TrackingEvent {
  const TrackingErrorEvent(this.errorCode);

  final String? errorCode;
}

enum TrackingConnectionStatus { connecting, live, reconnecting, offline }
