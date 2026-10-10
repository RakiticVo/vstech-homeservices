part of 'booking_flow_bloc.dart';

/// Every state carries the current [draft]; the state type says what just happened, which is what
/// the step pages react to (e.g. [BookingFlowEstimatedState] → open step 2).
@immutable
sealed class BookingFlowState {
  const BookingFlowState(this.draft);

  final BookingDraft draft;

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType && other is BookingFlowState && other.draft == draft;

  @override
  int get hashCode => Object.hash(runtimeType, draft);
}

final class BookingFlowInitialState extends BookingFlowState {
  const BookingFlowInitialState() : super(const BookingDraft());
}

/// Category/profile are loading.
final class BookingFlowLoadingState extends BookingFlowState {
  const BookingFlowLoadingState(super.draft);
}

/// Idle — the user is editing.
final class BookingFlowEditingState extends BookingFlowState {
  const BookingFlowEditingState(super.draft);
}

final class BookingFlowEstimatingState extends BookingFlowState {
  const BookingFlowEstimatingState(super.draft);
}

/// A fresh estimate is in [draft]; step 1 moves on.
final class BookingFlowEstimatedState extends BookingFlowState {
  const BookingFlowEstimatedState(super.draft);
}

final class BookingFlowLocatingState extends BookingFlowState {
  const BookingFlowLocatingState(super.draft);
}

final class BookingFlowLocationFailedState extends BookingFlowState {
  const BookingFlowLocationFailedState(super.draft, this.reason);

  final LocationFailure reason;

  @override
  bool operator ==(Object other) => super == other && other is BookingFlowLocationFailedState && other.reason == reason;

  @override
  int get hashCode => Object.hash(super.hashCode, reason);
}

/// Schedule/address saved; step 2 moves on.
final class BookingFlowScheduledState extends BookingFlowState {
  const BookingFlowScheduledState(super.draft);
}

final class BookingFlowSubmittingState extends BookingFlowState {
  const BookingFlowSubmittingState(super.draft);
}

/// `draft.booking` holds the created booking; step 3 opens the success screen.
final class BookingFlowSubmittedState extends BookingFlowState {
  const BookingFlowSubmittedState(super.draft);
}

/// Loading, estimating or submitting failed. When `draft.category` is null the category itself
/// could not be loaded (step 1 shows a retry view); otherwise pages show a SnackBar.
final class BookingFlowErrorState extends BookingFlowState {
  const BookingFlowErrorState(super.draft, this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => super == other && other is BookingFlowErrorState && other.failure == failure;

  @override
  int get hashCode => Object.hash(super.hashCode, failure);
}
