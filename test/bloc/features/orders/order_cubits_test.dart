import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_page.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/customer_orders_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/order_detail_cubit.dart';

import '../../../fixtures/booking/booking_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);

void main() {
  group('CustomerOrdersCubit', () {
    late MockGetMyBookingsUseCase getBookings;
    late MockGetCategoriesUseCase getCategories;

    setUp(() {
      getBookings = MockGetMyBookingsUseCase();
      getCategories = MockGetCategoriesUseCase();
      when(() => getCategories()).thenAnswer((_) async => const Ok([acCategory, cleanCategory]));
    });

    blocTest<CustomerOrdersCubit, CustomerOrdersState>(
      'load emits bookings with category names',
      setUp: () => when(
        () => getBookings(),
      ).thenAnswer((_) async => Ok<BookingPage>(pageOf([pendingBooking], hasMore: true))),
      build: () => CustomerOrdersCubit(getBookings, getCategories),
      act: (cubit) => cubit.load(),
      expect: () => [
        const CustomerOrdersLoadingState(),
        CustomerOrdersLoadedState(
          bookings: [pendingBooking],
          categoryNames: const {'1': 'Sửa máy lạnh', '2': 'Vệ sinh nhà'},
          page: 0,
          hasMore: true,
        ),
      ],
    );

    blocTest<CustomerOrdersCubit, CustomerOrdersState>(
      'category failure still shows bookings, unnamed',
      setUp: () {
        when(() => getBookings()).thenAnswer((_) async => Ok<BookingPage>(pageOf([pendingBooking])));
        when(() => getCategories()).thenAnswer((_) async => const Err<List<ServiceCategory>>(_offline));
      },
      build: () => CustomerOrdersCubit(getBookings, getCategories),
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => [
        CustomerOrdersLoadedState(bookings: [pendingBooking], categoryNames: const {}, page: 0, hasMore: false),
      ],
    );

    blocTest<CustomerOrdersCubit, CustomerOrdersState>(
      'booking failure is an error',
      setUp: () => when(() => getBookings()).thenAnswer((_) async => const Err<BookingPage>(_offline)),
      build: () => CustomerOrdersCubit(getBookings, getCategories),
      act: (cubit) => cubit.load(),
      expect: () => [const CustomerOrdersLoadingState(), const CustomerOrdersErrorState(_offline)],
    );

    final firstPage = CustomerOrdersLoadedState(
      bookings: [pendingBooking],
      categoryNames: const {},
      page: 0,
      hasMore: true,
    );

    blocTest<CustomerOrdersCubit, CustomerOrdersState>(
      'loadMore appends the next page',
      setUp: () => when(
        () => getBookings(page: 1),
      ).thenAnswer((_) async => Ok<BookingPage>(pageOf([completedBooking], page: 1))),
      build: () => CustomerOrdersCubit(getBookings, getCategories),
      seed: () => firstPage,
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        firstPage.copyWith(isLoadingMore: true),
        firstPage.copyWith(bookings: [pendingBooking, completedBooking], page: 1, hasMore: false),
      ],
    );

    blocTest<CustomerOrdersCubit, CustomerOrdersState>(
      'loadMore does nothing on the last page',
      build: () => CustomerOrdersCubit(getBookings, getCategories),
      seed: () => firstPage.copyWith(hasMore: false),
      act: (cubit) => cubit.loadMore(),
      expect: () => <CustomerOrdersState>[],
    );
  });

  group('OrderDetailCubit', () {
    late MockGetBookingUseCase getBooking;
    late MockGetCategoryUseCase getCategory;

    setUp(() {
      getBooking = MockGetBookingUseCase();
      getCategory = MockGetCategoryUseCase();
    });

    blocTest<OrderDetailCubit, OrderDetailState>(
      'load emits the booking with its service name',
      setUp: () {
        when(() => getBooking('501')).thenAnswer((_) async => Ok<Booking>(pendingBooking));
        when(() => getCategory('1')).thenAnswer((_) async => const Ok<ServiceCategory>(acCategory));
      },
      build: () => OrderDetailCubit(getBooking, getCategory),
      act: (cubit) => cubit.load('501'),
      expect: () => [const OrderDetailLoadingState(), OrderDetailLoadedState(pendingBooking, serviceName: 'Sửa máy lạnh')],
    );

    blocTest<OrderDetailCubit, OrderDetailState>(
      'load failure is emitted',
      setUp: () => when(() => getBooking('501')).thenAnswer((_) async => const Err<Booking>(_offline)),
      build: () => OrderDetailCubit(getBooking, getCategory),
      act: (cubit) => cubit.load('501'),
      expect: () => [const OrderDetailLoadingState(), const OrderDetailErrorState(_offline)],
    );
  });

  group('BookingActionCubit', () {
    late MockCancelBookingUseCase cancel;
    late MockDisputeBookingUseCase dispute;

    setUp(() {
      cancel = MockCancelBookingUseCase();
      dispute = MockDisputeBookingUseCase();
    });

    blocTest<BookingActionCubit, BookingActionState>(
      'cancel emits the new status',
      setUp: () => when(() => cancel('501')).thenAnswer((_) async => const Ok(BookingStatus.cancelled)),
      build: () => BookingActionCubit(cancel, dispute),
      act: (cubit) => cubit.cancel('501'),
      expect: () => [const BookingActionInProgressState(), const BookingActionDoneState(BookingStatus.cancelled)],
    );

    blocTest<BookingActionCubit, BookingActionState>(
      'dispute failure is emitted',
      setUp: () => when(() => dispute('503')).thenAnswer((_) async => const Err<BookingStatus>(_offline)),
      build: () => BookingActionCubit(cancel, dispute),
      act: (cubit) => cubit.dispute('503'),
      expect: () => [const BookingActionInProgressState(), const BookingActionFailedState(_offline)],
    );

    blocTest<BookingActionCubit, BookingActionState>(
      'ignores repeated taps while in progress',
      build: () => BookingActionCubit(cancel, dispute),
      seed: () => const BookingActionInProgressState(),
      act: (cubit) => cubit.cancel('501'),
      expect: () => <BookingActionState>[],
    );
  });
}
