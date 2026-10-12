import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notifications_cubit.dart';

import '../../../fixtures/notifications/notification_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);

void main() {
  late MockGetNotificationsUseCase getNotifications;
  late MockMarkNotificationReadUseCase markRead;
  late MockMarkAllNotificationsReadUseCase markAllRead;

  setUp(() {
    getNotifications = MockGetNotificationsUseCase();
    markRead = MockMarkNotificationReadUseCase();
    markAllRead = MockMarkAllNotificationsReadUseCase();
  });

  NotificationsCubit build() =>
      NotificationsCubit(getNotifications, markRead, markAllRead);

  NotificationsLoadedState loaded(
    List<AppNotification> items, {
    bool hasMore = false,
    NotificationType? filter,
  }) => NotificationsLoadedState(
    items: items,
    page: 0,
    hasMore: hasMore,
    filter: filter,
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'load emits the first page',
    setUp: () => when(() => getNotifications()).thenAnswer(
      (_) async => Ok(
        NotificationPage(
          items: [bookingUnread, systemRead],
          page: 0,
          hasMore: true,
        ),
      ),
    ),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => [
      const NotificationsLoadingState(),
      loaded([bookingUnread, systemRead], hasMore: true),
    ],
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'changing the filter refetches with the type and keeps it for refresh',
    setUp: () => when(() => getNotifications(type: NotificationType.promo))
        .thenAnswer(
          (_) async => const Ok(
            NotificationPage(items: [promoUnread], page: 0, hasMore: false),
          ),
        ),
    build: build,
    seed: () => loaded([bookingUnread]),
    act: (cubit) async {
      await cubit.load(filter: NotificationType.promo);
      await cubit.refresh();
    },
    expect: () => [
      const NotificationsLoadingState(filter: NotificationType.promo),
      loaded([promoUnread], filter: NotificationType.promo),
    ],
    verify: (_) =>
        verify(() => getNotifications(type: NotificationType.promo)).called(2),
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'load failure emits an error state',
    setUp: () =>
        when(() => getNotifications())
            .thenAnswer((_) async => const Err(_offline)),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => [
      const NotificationsLoadingState(),
      const NotificationsErrorState(_offline),
    ],
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'loadMore appends the next page and skips duplicates',
    setUp: () => when(() => getNotifications(page: 1)).thenAnswer(
      (_) async => Ok(
        NotificationPage(
          items: [systemRead, promoUnread],
          page: 1,
          hasMore: false,
        ),
      ),
    ),
    build: build,
    seed: () => loaded([bookingUnread, systemRead], hasMore: true),
    act: (cubit) => cubit.loadMore(),
    expect: () => [
      loaded([
        bookingUnread,
        systemRead,
      ], hasMore: true).copyWith(isLoadingMore: true),
      NotificationsLoadedState(
        items: [bookingUnread, systemRead, promoUnread],
        page: 1,
        hasMore: false,
      ),
    ],
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'markRead is optimistic and reverts with a one-shot failure when refused',
    setUp: () =>
        when(() => markRead('101'))
            .thenAnswer((_) async => const Err(_offline)),
    build: build,
    seed: () => loaded([bookingUnread]),
    act: (cubit) => cubit.markRead('101'),
    expect: () => [
      loaded([bookingUnread.copyWith(isRead: true)]),
      loaded([bookingUnread]).copyWith(actionFailure: _offline),
    ],
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'markRead does nothing for an already read notification',
    build: build,
    seed: () => loaded([systemRead]),
    act: (cubit) => cubit.markRead('102'),
    expect: () => <NotificationsState>[],
    verify: (_) => verifyNever(() => markRead(any())),
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'markAllRead marks every item read',
    setUp: () =>
        when(() => markAllRead()).thenAnswer((_) async => const Ok<void>(null)),
    build: build,
    seed: () => loaded([bookingUnread, systemRead, promoUnread]),
    act: (cubit) => cubit.markAllRead(),
    expect: () => [
      loaded([
        bookingUnread.copyWith(isRead: true),
        systemRead,
        promoUnread.copyWith(isRead: true),
      ]),
    ],
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'markAllRead restores the list when refused',
    setUp: () =>
        when(() => markAllRead()).thenAnswer((_) async => const Err(_offline)),
    build: build,
    seed: () => loaded([bookingUnread]),
    act: (cubit) => cubit.markAllRead(),
    expect: () => [
      loaded([bookingUnread.copyWith(isRead: true)]),
      loaded([bookingUnread]).copyWith(actionFailure: _offline),
    ],
  );
}
