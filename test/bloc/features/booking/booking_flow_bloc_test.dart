import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/new_booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/price_estimate.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';

import '../../../fixtures/booking/booking_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);

const _profileWithAddress = UserProfile(
  id: '9',
  role: UserRole.customer,
  defaultAddress: '123 Đường ABC, Quận 1',
  lat: 10.7626,
  lng: 106.6601,
);

void main() {
  late MockGetCategoryUseCase getCategory;
  late MockGetProfileUseCase getProfile;
  late MockEstimatePriceUseCase estimatePrice;
  late MockCreateBookingUseCase createBooking;
  late MockLocationService location;

  BookingFlowBloc build() => BookingFlowBloc(getCategory, getProfile, estimatePrice, createBooking, location);

  setUpAll(() {
    registerFallbackValue(
      NewBooking(categoryId: '', description: '', addressDetail: '', lat: 0, lng: 0, scheduledTime: DateTime.utc(2030)),
    );
  });

  setUp(() {
    getCategory = MockGetCategoryUseCase();
    getProfile = MockGetProfileUseCase();
    estimatePrice = MockEstimatePriceUseCase();
    createBooking = MockCreateBookingUseCase();
    location = MockLocationService();
  });

  group('start', () {
    blocTest<BookingFlowBloc, BookingFlowState>(
      'loads the category and pre-fills the default address and coordinates',
      setUp: () {
        when(() => getCategory('1')).thenAnswer((_) async => const Ok<ServiceCategory>(acCategory));
        when(() => getProfile()).thenAnswer((_) async => const Ok<UserProfile>(_profileWithAddress));
      },
      build: build,
      act: (bloc) => bloc.add(const BookingFlowStartedEvent('1')),
      expect: () => [
        const BookingFlowLoadingState(BookingDraft(categoryId: '1')),
        const BookingFlowEditingState(
          BookingDraft(categoryId: '1', category: acCategory, address: '123 Đường ABC, Quận 1', location: hcmc),
        ),
      ],
    );

    blocTest<BookingFlowBloc, BookingFlowState>(
      'a profile failure only leaves the address empty',
      setUp: () {
        when(() => getCategory('1')).thenAnswer((_) async => const Ok<ServiceCategory>(acCategory));
        when(() => getProfile()).thenAnswer((_) async => const Err<UserProfile>(_offline));
      },
      build: build,
      act: (bloc) => bloc.add(const BookingFlowStartedEvent('1')),
      skip: 1,
      expect: () => [const BookingFlowEditingState(BookingDraft(categoryId: '1', category: acCategory))],
    );

    blocTest<BookingFlowBloc, BookingFlowState>(
      'a category failure is an error without a category',
      setUp: () {
        when(() => getCategory('1')).thenAnswer((_) async => const Err<ServiceCategory>(_offline));
        when(() => getProfile()).thenAnswer((_) async => const Ok<UserProfile>(_profileWithAddress));
      },
      build: build,
      act: (bloc) => bloc.add(const BookingFlowStartedEvent('1')),
      skip: 1,
      expect: () => [const BookingFlowErrorState(BookingDraft(categoryId: '1'), _offline)],
    );
  });

  group('estimate', () {
    const draft = BookingDraft(categoryId: '1', category: acCategory);

    blocTest<BookingFlowBloc, BookingFlowState>(
      'stores the trimmed description and the server estimate',
      setUp: () => when(
        () => estimatePrice(categoryId: '1', description: 'Máy lạnh không mát'),
      ).thenAnswer((_) async => const Ok<PriceEstimate>(estimate)),
      build: build,
      seed: () => const BookingFlowEditingState(draft),
      act: (bloc) => bloc.add(const BookingEstimateRequestedEvent('  Máy lạnh không mát ')),
      expect: () => [
        BookingFlowEstimatingState(draft.copyWith(description: 'Máy lạnh không mát')),
        BookingFlowEstimatedState(draft.copyWith(description: 'Máy lạnh không mát', estimate: estimate)),
      ],
    );

    blocTest<BookingFlowBloc, BookingFlowState>(
      'surfaces estimate errors',
      setUp: () => when(
        () => estimatePrice(categoryId: any(named: 'categoryId'), description: any(named: 'description')),
      ).thenAnswer((_) async => const Err<PriceEstimate>(_offline)),
      build: build,
      seed: () => const BookingFlowEditingState(draft),
      act: (bloc) => bloc.add(const BookingEstimateRequestedEvent('x')),
      skip: 1,
      expect: () => [BookingFlowErrorState(draft.copyWith(description: 'x'), _offline)],
    );
  });

  group('location', () {
    const draft = BookingDraft(categoryId: '1', category: acCategory);

    blocTest<BookingFlowBloc, BookingFlowState>(
      'stores the device position',
      setUp: () => when(() => location.currentPosition()).thenAnswer((_) async => (hcmc, null)),
      build: build,
      seed: () => const BookingFlowEditingState(draft),
      act: (bloc) => bloc.add(const BookingLocationRequestedEvent()),
      expect: () => [
        const BookingFlowLocatingState(draft),
        BookingFlowEditingState(draft.copyWith(location: hcmc)),
      ],
    );

    blocTest<BookingFlowBloc, BookingFlowState>(
      'reports why the position is unavailable',
      setUp: () =>
          when(() => location.currentPosition()).thenAnswer((_) async => (null, LocationFailure.permissionDenied)),
      build: build,
      seed: () => const BookingFlowEditingState(draft),
      act: (bloc) => bloc.add(const BookingLocationRequestedEvent()),
      skip: 1,
      expect: () => [const BookingFlowLocationFailedState(draft, LocationFailure.permissionDenied)],
    );
  });

  blocTest<BookingFlowBloc, BookingFlowState>(
    'schedule stores UTC time, trimmed address and notes',
    build: build,
    seed: () => BookingFlowEditingState(readyDraft.copyWith(scheduledTime: null)),
    act: (bloc) => bloc.add(
      BookingScheduleSubmittedEvent(scheduledTime: DateTime.utc(2030, 1, 3, 1), address: ' 9 Lê Lợi ', notes: ' Gọi trước '),
    ),
    expect: () => [
      BookingFlowScheduledState(
        readyDraft.copyWith(scheduledTime: DateTime.utc(2030, 1, 3, 1), address: '9 Lê Lợi', notes: 'Gọi trước'),
      ),
    ],
  );

  group('confirm', () {
    blocTest<BookingFlowBloc, BookingFlowState>(
      'creates the booking with the description plus notes',
      setUp: () => when(() => createBooking(any())).thenAnswer((_) async => Ok<Booking>(pendingBooking)),
      build: build,
      seed: () => BookingFlowScheduledState(readyDraft.copyWith(notes: 'Gọi trước')),
      act: (bloc) => bloc.add(const BookingConfirmedEvent()),
      expect: () => [
        BookingFlowSubmittingState(readyDraft.copyWith(notes: 'Gọi trước')),
        BookingFlowSubmittedState(readyDraft.copyWith(notes: 'Gọi trước', booking: pendingBooking)),
      ],
      verify: (_) {
        final sent = verify(() => createBooking(captureAny())).captured.single as NewBooking;
        expect(sent.description, 'Máy lạnh không mát\nGọi trước');
        expect(sent.lat, hcmc.lat);
        expect(sent.categoryId, '1');
      },
    );

    blocTest<BookingFlowBloc, BookingFlowState>(
      'does nothing without a location',
      build: build,
      seed: () => BookingFlowScheduledState(readyDraft.copyWith(location: null)),
      act: (bloc) => bloc.add(const BookingConfirmedEvent()),
      expect: () => <BookingFlowState>[],
    );

    blocTest<BookingFlowBloc, BookingFlowState>(
      'surfaces create errors',
      setUp: () => when(() => createBooking(any())).thenAnswer((_) async => const Err<Booking>(_offline)),
      build: build,
      seed: () => BookingFlowScheduledState(readyDraft),
      act: (bloc) => bloc.add(const BookingConfirmedEvent()),
      skip: 1,
      expect: () => [BookingFlowErrorState(readyDraft, _offline)],
    );
  });
}
