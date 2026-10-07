import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/mocks.dart';

ResponseBody _json(String body, int status) => ResponseBody.fromString(
  body,
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

void main() {
  late MockAuthTokenStore tokenStore;
  late MockHttpClientAdapter adapter;
  late int sessionExpiredCalls;
  late ApiClient client;
  late List<RequestOptions> requests;

  /// Routes adapter calls to [handler] and records every request.
  void respond(ResponseBody Function(RequestOptions options) handler) {
    when(() => adapter.fetch(any(), any(), any())).thenAnswer((invocation) async {
      final options = invocation.positionalArguments[0] as RequestOptions;
      requests.add(options);
      return handler(options);
    });
  }

  setUpAll(() {
    registerFallbackValue(RequestOptions());
  });

  setUp(() {
    tokenStore = MockAuthTokenStore();
    adapter = MockHttpClientAdapter();
    sessionExpiredCalls = 0;
    requests = [];
    when(() => tokenStore.readAccessToken()).thenAnswer((_) async => 'old-access');
    when(() => tokenStore.readRefreshToken()).thenAnswer((_) async => 'refresh');
    when(() => tokenStore.clear()).thenAnswer((_) async {});
    when(
      () => tokenStore.saveTokens(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    ).thenAnswer((_) async {});
    client = ApiClient(
      baseUrl: 'https://api.test',
      tokenStore: tokenStore,
      onSessionExpired: () => sessionExpiredCalls++,
      languageCode: () => 'vi',
      httpClientAdapter: adapter,
    );
  });

  Map<String, dynamic> decodeMap(Object? json) => json! as Map<String, dynamic>;

  group('request decoration', () {
    test('attaches bearer token and Accept-Language, decodes data', () async {
      respond((_) => _json(fixture('core/profile_success.json'), 200));

      final response = await client.get(ApiEndpoints.profiles, decode: decodeMap);

      expect(response.requireData['id'], 9);
      expect(requests.single.headers['Authorization'], 'Bearer old-access');
      expect(requests.single.headers['Accept-Language'], 'vi');
      expect(requests.single.headers.containsKey(ApiClient.idempotencyHeader), isFalse);
    });

    test('omits bearer token for unauthenticated calls', () async {
      respond((_) => _json(fixture('core/profile_success.json'), 200));

      await client.post(ApiEndpoints.authLogin, body: <String, dynamic>{}, decode: decodeMap, authenticated: false);

      expect(requests.single.headers.containsKey('Authorization'), isFalse);
    });

    test('adds a uuid X-Idempotency-Key to idempotent calls', () async {
      respond((_) => _json(fixture('core/profile_success.json'), 200));

      await client.post(ApiEndpoints.bookings, decode: decodeMap, idempotent: true);

      final key = requests.single.headers[ApiClient.idempotencyHeader] as String;
      expect(RegExp(r'^[0-9a-f-]{36}$').hasMatch(key), isTrue);
    });

    test('synthesizes a success envelope for empty 204 responses', () async {
      respond((_) => ResponseBody(const Stream<Uint8List>.empty(), 204));

      final response = await client.delete<Object?>(ApiEndpoints.devices, decode: (json) => json);

      expect(response.isSuccess, isTrue);
      expect(response.data, isNull);
    });
  });

  group('errors', () {
    test('maps an error envelope to NetworkException with its errorCode', () async {
      respond((_) => _json(fixture('core/error_insufficient_balance.json'), 400));

      await expectLater(
        client.post(ApiEndpoints.withdrawals, decode: decodeMap, idempotent: true),
        throwsA(
          isA<NetworkException>()
              .having((e) => e.errorCode, 'errorCode', 'HS-400-0020')
              .having((e) => e.statusCode, 'statusCode', 400)
              .having((e) => e.kind, 'kind', NetworkErrorKind.server),
        ),
      );
    });

    test('maps connection errors to NetworkErrorKind.noConnection', () async {
      when(() => adapter.fetch(any(), any(), any()))
          .thenThrow(DioException.connectionError(requestOptions: RequestOptions(), reason: 'offline'));

      await expectLater(
        client.get(ApiEndpoints.profiles, decode: decodeMap),
        throwsA(isA<NetworkException>().having((e) => e.kind, 'kind', NetworkErrorKind.noConnection)),
      );
    });

    test('a 401 on login does not trigger a refresh', () async {
      respond((_) => _json(fixture('core/error_invalid_credentials.json'), 401));

      await expectLater(
        client.post(ApiEndpoints.authLogin, decode: decodeMap, authenticated: false),
        throwsA(isA<NetworkException>().having((e) => e.errorCode, 'errorCode', 'HS-401-0002')),
      );
      expect(requests, hasLength(1));
      expect(sessionExpiredCalls, 0);
    });
  });

  group('token refresh', () {
    test('refreshes once on 401, keeps the refresh token and retries with the same idempotency key', () async {
      var accessToken = 'old-access';
      when(() => tokenStore.readAccessToken()).thenAnswer((_) async => accessToken);
      when(
        () => tokenStore.saveTokens(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      ).thenAnswer((invocation) async {
        accessToken = invocation.namedArguments[#accessToken] as String;
      });
      respond((options) {
        if (options.path == ApiEndpoints.authRefresh) {
          return _json(fixture('core/refresh_success.json'), 200);
        }
        return options.headers['Authorization'] == 'Bearer new-access'
            ? _json(fixture('core/profile_success.json'), 200)
            : _json('{"status":401,"errorCode":"HS-401-0001"}', 401);
      });

      final response = await client.post(ApiEndpoints.bookings, decode: decodeMap, idempotent: true);

      expect(response.requireData['id'], 9);
      verify(() => tokenStore.saveTokens(accessToken: 'new-access', refreshToken: 'refresh')).called(1);
      final bookingCalls = requests.where((r) => r.path == ApiEndpoints.bookings).toList();
      expect(bookingCalls, hasLength(2));
      expect(
        bookingCalls.first.headers[ApiClient.idempotencyHeader],
        bookingCalls.last.headers[ApiClient.idempotencyHeader],
      );
      final refreshBody = requests.firstWhere((r) => r.path == ApiEndpoints.authRefresh).data;
      expect(refreshBody, {'refreshToken': 'refresh'});
      expect(sessionExpiredCalls, 0);
    });

    test('saves a rotated refresh token when the server returns one', () async {
      var accessToken = 'old-access';
      when(() => tokenStore.readAccessToken()).thenAnswer((_) async => accessToken);
      when(
        () => tokenStore.saveTokens(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      ).thenAnswer((invocation) async {
        accessToken = invocation.namedArguments[#accessToken] as String;
      });
      respond((options) {
        if (options.path == ApiEndpoints.authRefresh) {
          return _json(
            '{"status":200,"data":{"accessToken":"new-access","refreshToken":"rotated","expiresIn":900}}',
            200,
          );
        }
        return options.headers['Authorization'] == 'Bearer new-access'
            ? _json(fixture('core/profile_success.json'), 200)
            : _json('{"status":401,"errorCode":"HS-401-0001"}', 401);
      });

      await client.get(ApiEndpoints.profiles, decode: decodeMap);

      verify(() => tokenStore.saveTokens(accessToken: 'new-access', refreshToken: 'rotated')).called(1);
    });

    test('concurrent 401s share a single refresh call', () async {
      var accessToken = 'old-access';
      when(() => tokenStore.readAccessToken()).thenAnswer((_) async => accessToken);
      when(
        () => tokenStore.saveTokens(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      ).thenAnswer((invocation) async {
        accessToken = invocation.namedArguments[#accessToken] as String;
      });
      respond((options) {
        if (options.path == ApiEndpoints.authRefresh) {
          return _json(fixture('core/refresh_success.json'), 200);
        }
        return options.headers['Authorization'] == 'Bearer new-access'
            ? _json(fixture('core/profile_success.json'), 200)
            : _json('{"status":401,"errorCode":"HS-401-0001"}', 401);
      });

      await Future.wait([
        client.get(ApiEndpoints.profiles, decode: decodeMap),
        client.get(ApiEndpoints.walletMe, decode: decodeMap),
        client.get(ApiEndpoints.notifications, decode: decodeMap),
      ]);

      expect(requests.where((r) => r.path == ApiEndpoints.authRefresh), hasLength(1));
    });

    test('failed refresh clears tokens and signals session expiry', () async {
      respond((options) {
        if (options.path == ApiEndpoints.authRefresh) {
          return _json('{"status":401,"errorCode":"HS-401-0001"}', 401);
        }
        return _json('{"status":401,"errorCode":"HS-401-0001"}', 401);
      });

      await expectLater(
        client.get(ApiEndpoints.profiles, decode: decodeMap),
        throwsA(isA<NetworkException>().having((e) => e.statusCode, 'statusCode', 401)),
      );
      verify(() => tokenStore.clear()).called(1);
      expect(sessionExpiredCalls, 1);
    });

    test('missing refresh token expires the session without calling /auth/refresh', () async {
      when(() => tokenStore.readRefreshToken()).thenAnswer((_) async => null);
      respond((_) => _json('{"status":401,"errorCode":"HS-401-0001"}', 401));

      await expectLater(client.get(ApiEndpoints.profiles, decode: decodeMap), throwsA(isA<NetworkException>()));
      expect(requests.where((r) => r.path == ApiEndpoints.authRefresh), isEmpty);
      expect(sessionExpiredCalls, 1);
    });
  });

  test('encodes request bodies as JSON', () async {
    respond((_) => _json(fixture('core/profile_success.json'), 200));

    await client.put(ApiEndpoints.profiles, body: {'fullName': 'A'}, decode: decodeMap);

    expect(jsonEncode(requests.single.data), '{"fullName":"A"}');
    expect(requests.single.method, 'PUT');
  });
}
