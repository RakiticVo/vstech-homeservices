part of 'booking_action_cubit.dart';

@immutable
sealed class BookingActionState {
  const BookingActionState();
}

final class BookingActionIdleState extends BookingActionState {
  const BookingActionIdleState();
}

final class BookingActionInProgressState extends BookingActionState {
  const BookingActionInProgressState();
}

final class BookingActionDoneState extends BookingActionState {
  const BookingActionDoneState(this.newStatus);

  final BookingStatus newStatus;

  @override
  bool operator ==(Object other) => other is BookingActionDoneState && other.newStatus == newStatus;

  @override
  int get hashCode => newStatus.hashCode;
}

final class BookingActionFailedState extends BookingActionState {
  const BookingActionFailedState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is BookingActionFailedState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
