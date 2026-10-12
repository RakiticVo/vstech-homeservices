part of 'voip_call_cubit.dart';

@immutable
sealed class VoipCallState {
  const VoipCallState();
}

/// Logging the call start.
final class VoipCallStartingState extends VoipCallState {
  const VoipCallStartingState();
}

final class VoipCallActiveState extends VoipCallState {
  const VoipCallActiveState({
    required this.call,
    this.elapsedSeconds = 0,
    this.isMuted = false,
    this.isSpeaker = false,
  });

  final VoipCall call;
  final int elapsedSeconds;
  final bool isMuted;
  final bool isSpeaker;

  VoipCallActiveState copyWith({
    int? elapsedSeconds,
    bool? isMuted,
    bool? isSpeaker,
  }) => VoipCallActiveState(
    call: call,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    isMuted: isMuted ?? this.isMuted,
    isSpeaker: isSpeaker ?? this.isSpeaker,
  );

  @override
  bool operator ==(Object other) =>
      other is VoipCallActiveState &&
      other.call == call &&
      other.elapsedSeconds == elapsedSeconds &&
      other.isMuted == isMuted &&
      other.isSpeaker == isSpeaker;

  @override
  int get hashCode => Object.hash(call, elapsedSeconds, isMuted, isSpeaker);
}

final class VoipCallEndedState extends VoipCallState {
  const VoipCallEndedState({required this.durationSeconds});

  final int durationSeconds;

  @override
  bool operator ==(Object other) =>
      other is VoipCallEndedState && other.durationSeconds == durationSeconds;

  @override
  int get hashCode => durationSeconds.hashCode;
}

final class VoipCallErrorState extends VoipCallState {
  const VoipCallErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) =>
      other is VoipCallErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
