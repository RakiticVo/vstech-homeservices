part of 'worker_task_cubit.dart';

enum WorkerTaskAction { accept, start, complete }

/// The job plus what the worker added on this device.
@immutable
class WorkerTaskData {
  const WorkerTaskData({required this.booking, this.serviceName, this.quote});

  final Booking booking;
  final String? serviceName;

  /// Last extra-cost quote sent for this job from this device, if any.
  final SubmittedQuote? quote;

  /// Extra cost still counting toward the final price (a rejected / cancelled quote does not).
  num get quotedExtra => switch (quote?.status) {
    QuoteStatus.pending || QuoteStatus.approved => quote!.totalAmount,
    _ => 0,
  };

  /// Suggested `actualPrice` for completion: the estimate plus the quoted extra.
  num get suggestedFinalPrice => (booking.estimatedPrice ?? 0) + quotedExtra;

  WorkerTaskData copyWith({Booking? booking, SubmittedQuote? quote}) =>
      WorkerTaskData(
        booking: booking ?? this.booking,
        serviceName: serviceName,
        quote: quote ?? this.quote,
      );

  @override
  bool operator ==(Object other) =>
      other is WorkerTaskData &&
      other.booking == booking &&
      other.serviceName == serviceName &&
      other.quote == quote;

  @override
  int get hashCode => Object.hash(booking, serviceName, quote);
}

@immutable
sealed class WorkerTaskState {
  const WorkerTaskState();

  WorkerTaskData? get data => null;
}

final class WorkerTaskLoadingState extends WorkerTaskState {
  const WorkerTaskLoadingState();
}

final class WorkerTaskLoadErrorState extends WorkerTaskState {
  const WorkerTaskLoadErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) =>
      other is WorkerTaskLoadErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}

/// Base for states that have the job loaded.
sealed class WorkerTaskWithDataState extends WorkerTaskState {
  const WorkerTaskWithDataState(this.task);

  final WorkerTaskData task;

  @override
  WorkerTaskData get data => task;
}

final class WorkerTaskReadyState extends WorkerTaskWithDataState {
  const WorkerTaskReadyState(super.task);

  @override
  bool operator ==(Object other) =>
      other is WorkerTaskReadyState && other.task == task;

  @override
  int get hashCode => Object.hash(runtimeType, task);
}

final class WorkerTaskBusyState extends WorkerTaskWithDataState {
  const WorkerTaskBusyState(super.task, this.action);

  final WorkerTaskAction action;

  @override
  bool operator ==(Object other) =>
      other is WorkerTaskBusyState &&
      other.task == task &&
      other.action == action;

  @override
  int get hashCode => Object.hash(runtimeType, task, action);
}

/// [action] succeeded; `task.booking` carries the new status. Screens navigate on this.
final class WorkerTaskActionDoneState extends WorkerTaskWithDataState {
  const WorkerTaskActionDoneState(super.task, this.action);

  final WorkerTaskAction action;

  @override
  bool operator ==(Object other) =>
      other is WorkerTaskActionDoneState &&
      other.task == task &&
      other.action == action;

  @override
  int get hashCode => Object.hash(runtimeType, task, action);
}

final class WorkerTaskActionFailedState extends WorkerTaskWithDataState {
  const WorkerTaskActionFailedState(super.task, this.action, this.failure);

  final WorkerTaskAction action;
  final Failure failure;

  @override
  bool operator ==(Object other) =>
      other is WorkerTaskActionFailedState &&
      other.task == task &&
      other.action == action &&
      other.failure == failure;

  @override
  int get hashCode => Object.hash(runtimeType, task, action, failure);
}
