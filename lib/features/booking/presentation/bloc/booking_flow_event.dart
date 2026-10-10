part of 'booking_flow_bloc.dart';

@immutable
sealed class BookingFlowEvent {
  const BookingFlowEvent();
}

/// Step 1 opened for a category: loads the category and the profile's default address.
final class BookingFlowStartedEvent extends BookingFlowEvent {
  const BookingFlowStartedEvent(this.categoryId);

  final String categoryId;
}

/// Step 1 submitted: `POST /bookings/estimate` for the typed problem description.
final class BookingEstimateRequestedEvent extends BookingFlowEvent {
  const BookingEstimateRequestedEvent(this.description);

  final String description;
}

/// Step 2: replace the coordinates with the device's current position.
final class BookingLocationRequestedEvent extends BookingFlowEvent {
  const BookingLocationRequestedEvent();
}

/// Step 2 submitted. [scheduledTime] may be local; it is stored in UTC.
final class BookingScheduleSubmittedEvent extends BookingFlowEvent {
  const BookingScheduleSubmittedEvent({required this.scheduledTime, required this.address, required this.notes});

  final DateTime scheduledTime;
  final String address;
  final String notes;
}

/// Step 3 confirmed: `POST /bookings`.
final class BookingConfirmedEvent extends BookingFlowEvent {
  const BookingConfirmedEvent();
}
