import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/entities/new_booking.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/estimate_price_use_case.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_draft.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_category_use_case.dart';

export 'package:vstech_home_services/features/booking/presentation/bloc/booking_draft.dart';

part 'booking_flow_event.dart';
part 'booking_flow_state.dart';

/// Customer booking wizard (step 1 description + estimate → step 2 schedule/address → step 3
/// confirm → success). Provided once for all booking steps by a ShellRoute.
@injectable
class BookingFlowBloc extends Bloc<BookingFlowEvent, BookingFlowState> {
  BookingFlowBloc(
    this._getCategory,
    this._getProfile,
    this._estimatePrice,
    this._createBooking,
    this._location,
  ) : super(const BookingFlowInitialState()) {
    on<BookingFlowStartedEvent>(_onStarted);
    on<BookingEstimateRequestedEvent>(_onEstimateRequested);
    on<BookingLocationRequestedEvent>(_onLocationRequested);
    on<BookingScheduleSubmittedEvent>(_onScheduleSubmitted);
    on<BookingConfirmedEvent>(_onConfirmed);
  }

  final GetCategoryUseCase _getCategory;
  final GetProfileUseCase _getProfile;
  final EstimatePriceUseCase _estimatePrice;
  final CreateBookingUseCase _createBooking;
  final LocationService _location;

  Future<void> _onStarted(BookingFlowStartedEvent event, Emitter<BookingFlowState> emit) async {
    final draft = BookingDraft(categoryId: event.categoryId);
    emit(BookingFlowLoadingState(draft));
    final (category, profile) = await (_getCategory(event.categoryId), _getProfile()).wait;
    switch (category) {
      case Err(:final failure):
        emit(BookingFlowErrorState(draft, failure));
      case Ok(value: final category):
        // The profile only pre-fills the address; failing to load it is not fatal.
        final user = switch (profile) {
          Ok(:final value) => value,
          Err() => null,
        };
        final lat = user?.lat;
        final lng = user?.lng;
        emit(
          BookingFlowEditingState(
            draft.copyWith(
              category: category,
              address: user?.defaultAddress ?? '',
              location: lat != null && lng != null ? GeoPoint(lat, lng) : null,
            ),
          ),
        );
    }
  }

  Future<void> _onEstimateRequested(BookingEstimateRequestedEvent event, Emitter<BookingFlowState> emit) async {
    final draft = state.draft.copyWith(description: event.description.trim());
    emit(BookingFlowEstimatingState(draft));
    switch (await _estimatePrice(categoryId: draft.categoryId, description: draft.description)) {
      case Ok(:final value):
        emit(BookingFlowEstimatedState(draft.copyWith(estimate: value)));
      case Err(:final failure):
        emit(BookingFlowErrorState(draft, failure));
    }
  }

  Future<void> _onLocationRequested(BookingLocationRequestedEvent event, Emitter<BookingFlowState> emit) async {
    final draft = state.draft;
    emit(BookingFlowLocatingState(draft));
    final (point, failure) = await _location.currentPosition();
    if (point != null) {
      emit(BookingFlowEditingState(draft.copyWith(location: point)));
    } else {
      emit(BookingFlowLocationFailedState(draft, failure ?? LocationFailure.unavailable));
    }
  }

  void _onScheduleSubmitted(BookingScheduleSubmittedEvent event, Emitter<BookingFlowState> emit) {
    emit(
      BookingFlowScheduledState(
        state.draft.copyWith(
          scheduledTime: event.scheduledTime.toUtc(),
          address: event.address.trim(),
          notes: event.notes.trim(),
        ),
      ),
    );
  }

  Future<void> _onConfirmed(BookingConfirmedEvent event, Emitter<BookingFlowState> emit) async {
    final draft = state.draft;
    final location = draft.location;
    final scheduledTime = draft.scheduledTime;
    if (state is BookingFlowSubmittingState || location == null || scheduledTime == null) return;
    emit(BookingFlowSubmittingState(draft));
    final result = await _createBooking(
      NewBooking(
        categoryId: draft.categoryId,
        description: draft.fullDescription,
        addressDetail: draft.address,
        lat: location.lat,
        lng: location.lng,
        scheduledTime: scheduledTime,
      ),
    );
    switch (result) {
      case Ok(:final value):
        emit(BookingFlowSubmittedState(draft.copyWith(booking: value)));
      case Err(:final failure):
        emit(BookingFlowErrorState(draft, failure));
    }
  }
}
