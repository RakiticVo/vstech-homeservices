part of 'worker_presence_cubit.dart';

@immutable
sealed class WorkerPresenceState {
  const WorkerPresenceState();

  bool get isOnline => this is WorkerOnlineState;
}

final class WorkerOfflineState extends WorkerPresenceState {
  const WorkerOfflineState();
}

/// Waiting for location permission / the first GPS fix.
final class WorkerGoingOnlineState extends WorkerPresenceState {
  const WorkerGoingOnlineState();
}

/// Broadcasting. [lastSent] is the last position reported to the server (null before the first).
final class WorkerOnlineState extends WorkerPresenceState {
  const WorkerOnlineState({this.lastSent});

  final GeoPoint? lastSent;

  @override
  bool operator ==(Object other) => other is WorkerOnlineState && other.lastSent == lastSent;

  @override
  int get hashCode => lastSent.hashCode;
}

/// Could not go Online because the position is unavailable; the worker stays Offline.
final class WorkerPresenceErrorState extends WorkerPresenceState {
  const WorkerPresenceErrorState(this.reason);

  final LocationFailure reason;

  @override
  bool operator ==(Object other) => other is WorkerPresenceErrorState && other.reason == reason;

  @override
  int get hashCode => reason.hashCode;
}
