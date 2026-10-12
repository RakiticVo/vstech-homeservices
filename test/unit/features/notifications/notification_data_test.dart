import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:vstech_home_services/features/notifications/data/models/notification_response.dart';
import 'package:vstech_home_services/features/notifications/data/models/notification_settings_response.dart';
import 'package:vstech_home_services/features/notifications/data/models/update_notification_settings_request.dart';
import 'package:vstech_home_services/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/mocks.dart';

ApiResponse<T> _ok<T>(T data) => ApiResponse(
  status: 200,
  message: '',
  data: data,
  errorCode: null,
  timestamp: null,
);

void main() {
  group('NotificationRemoteDataSource', () {
    late MockApiClient client;
    late NotificationRemoteDataSource dataSource;

    setUp(() {
      client = MockApiClient();
      dataSource = NotificationRemoteDataSource(client);
    });

    test('decodes the bare notifications list (int or UUID ids) and passes the type filter', () async {
      when(
        () => client.get<NotificationPageResponse>(
          ApiEndpoints.notifications,
          query: any(named: 'query'),
          decode: any(named: 'decode'),
        ),
      ).thenAnswer((invocation) async {
        final decode =
            invocation.namedArguments[#decode]
                as NotificationPageResponse Function(Object?);
        return _ok(
          decode(jsonFixture('notifications/notifications_page.json')['data']),
        );
      });

      final page = await dataSource.getNotifications(
        page: 1,
        size: 20,
        type: 'BOOKING',
      );

      expect(page.notifications.map((n) => n.id), [
        '101',
        'b2c4f2d0-uuid',
        '103',
      ]);
      expect(
        page.notifications.first.createdAt,
        DateTime.utc(2026, 10, 11, 3, 30),
      );
      verify(
        () => client.get<NotificationPageResponse>(
          ApiEndpoints.notifications,
          query: {'page': 1, 'size': 20, 'type': 'BOOKING'},
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });

    test('updateSettings PUTs all three flags', () async {
      when(
        () => client.put<NotificationSettingsResponse>(
          ApiEndpoints.notificationSettings,
          body: any(named: 'body'),
          decode: any(named: 'decode'),
        ),
      ).thenAnswer(
        (_) async =>
            _ok(const NotificationSettingsResponse(promoEnabled: false)),
      );

      await dataSource.updateSettings(
        const UpdateNotificationSettingsRequest(
          systemEnabled: true,
          bookingEnabled: true,
          promoEnabled: false,
        ),
      );

      verify(
        () => client.put<NotificationSettingsResponse>(
          ApiEndpoints.notificationSettings,
          body: {
            'systemEnabled': true,
            'bookingEnabled': true,
            'promoEnabled': false,
          },
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });
  });

  group('NotificationRepositoryImpl', () {
    late MockNotificationRemoteDataSource remote;
    late NotificationRepositoryImpl repository;

    setUpAll(
      () => registerFallbackValue(
        const UpdateNotificationSettingsRequest(
          systemEnabled: true,
          bookingEnabled: true,
          promoEnabled: true,
        ),
      ),
    );

    setUp(() {
      remote = MockNotificationRemoteDataSource();
      repository = NotificationRepositoryImpl(remote);
    });

    test('maps types (unknown kept as unknown) and infers hasMore from a full page', () async {
      when(() => remote.getNotifications(page: 0, size: 20)).thenAnswer(
        (_) async => NotificationPageResponse(
          notifications: [
            for (var i = 0; i < 20; i++)
              NotificationResponse(
                id: '$i',
                type: i.isEven ? 'BOOKING' : 'NEW_KIND',
              ),
          ],
        ),
      );

      final page = (await repository.getNotifications(
        page: 0,
      ) as Ok<NotificationPage>).value;

      expect(page.hasMore, isTrue);
      expect(page.items[0].type, NotificationType.booking);
      expect(page.items[1].type, NotificationType.unknown);
      expect(page.items[0].isRead, isFalse);
    });

    test('a short page means there is nothing more to load', () async {
      when(() => remote.getNotifications(page: 2, size: 20, type: 'PROMO'))
          .thenAnswer(
            (_) async => const NotificationPageResponse(
              notifications: [NotificationResponse(id: '1')],
            ),
          );

      final page = (await repository.getNotifications(
        page: 2,
        type: NotificationType.promo,
      ) as Ok<NotificationPage>).value;

      expect(page.hasMore, isFalse);
      expect(page.page, 2);
    });

    test('settings default missing flags to on', () async {
      when(() => remote.getSettings()).thenAnswer(
        (_) async => const NotificationSettingsResponse(promoEnabled: false),
      );

      final settings =
          (await repository.getSettings() as Ok<NotificationSettings>).value;

      expect(settings, const NotificationSettings(promoEnabled: false));
    });

    test('markRead surfaces failures as Err', () async {
      when(() => remote.markRead('5')).thenThrow(Exception('boom'));

      expect(await repository.markRead('5'), isA<Err<void>>());
    });
  });
}
