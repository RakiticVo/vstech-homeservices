import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:vstech_home_services/core/debug/debug_log_store.dart';
import 'package:vstech_home_services/core/network/network_log_interceptor.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

class _Silent extends LogOutput {
  @override
  void output(OutputEvent event) {}
}

class _RequestHandler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions requestOptions) {}
}

class _ResponseHandler extends ResponseInterceptorHandler {
  @override
  void next(Response<dynamic> response) {}
}

class _ErrorHandler extends ErrorInterceptorHandler {
  @override
  void next(DioException error) {}
}

DebugLogEntry _log(
  String message, {
  DebugLogLevel level = DebugLogLevel.info,
}) => DebugLogEntry(
  time: DateTime.utc(2026, 10, 15),
  source: DebugLogSource.app,
  level: level,
  message: message,
);

void main() {
  group('DebugLogStore', () {
    test('keeps only the newest entries and lists newest first', () {
      final store = DebugLogStore(maxLogs: 2, maxCalls: 2)
        ..addLog(_log('a'))
        ..addLog(_log('b'))
        ..addLog(_log('c'));
      for (var i = 0; i < 3; i++) {
        store.startCall(method: 'GET', url: '/$i');
      }

      expect(store.logs.map((l) => l.message), ['c', 'b']);
      expect(store.calls.map((c) => c.url), ['/2', '/1']);
    });

    test('finishCall fills the result; isError covers 4xx/5xx and transport failures', () {
      final store = DebugLogStore();
      final ok = store.startCall(method: 'GET', url: '/ok');
      final bad = store.startCall(method: 'POST', url: '/bad');
      final offline = store.startCall(method: 'GET', url: '/offline');
      final pending = store.startCall(method: 'GET', url: '/pending');

      store
        ..finishCall(ok, statusCode: 200, durationMs: 12)
        ..finishCall(bad, statusCode: 409, errorCode: 'HS-409-0005')
        ..finishCall(offline, errorMessage: 'connectionError');

      final byUrl = {for (final c in store.calls) c.url: c};
      expect(byUrl['/ok']!.isError, isFalse);
      expect(byUrl['/bad']!.isError, isTrue);
      expect(byUrl['/bad']!.errorCode, 'HS-409-0005');
      expect(byUrl['/offline']!.isError, isTrue);
      expect(byUrl['/pending']!.isFinished, isFalse);
      expect(pending, 3);
    });

    test('export dumps calls and logs as plain text; clear empties both', () {
      final store = DebugLogStore()..addLog(_log('App started'));
      final id = store.startCall(
        method: 'GET',
        url: 'https://api.test/x',
        requestBody: '{"a":1}',
      );
      store.finishCall(
        id,
        statusCode: 500,
        durationMs: 40,
        responseBody: '{"errorCode":"HS-500-0001"}',
      );

      final text = store.export(header: 'HEADER');

      expect(text, contains('HEADER'));
      expect(text, contains('GET https://api.test/x → 500 (40ms)'));
      expect(text, contains('request: {"a":1}'));
      expect(text, contains('INFO app: App started'));

      store.clear();
      expect(store.logs, isEmpty);
      expect(store.calls, isEmpty);
    });
  });

  group('NetworkLogInterceptor → DebugLogStore', () {
    late DebugLogStore store;
    late NetworkLogInterceptor interceptor;

    setUp(() {
      store = DebugLogStore();
      interceptor = NetworkLogInterceptor(
        logger: Logger(filter: AppLogFilter(enabled: true), output: _Silent()),
        store: store,
      );
    });

    RequestOptions login() => RequestOptions(
      path: '/api/v1/auth/login',
      baseUrl: 'https://api.test',
      method: 'POST',
      headers: {'Authorization': 'Bearer secret-token'},
      data: {'phoneNumber': '0901', 'password': 'p@ss'},
    );

    test('records a successful call with masked token and password', () {
      final options = login();
      interceptor
        ..onRequest(options, _RequestHandler())
        ..onResponse(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: {'accessToken': 'jwt', 'refreshToken': 'r'},
          ),
          _ResponseHandler(),
        );

      final call = store.calls.single;
      expect(call.method, 'POST');
      expect(call.url, 'https://api.test/api/v1/auth/login');
      expect(call.statusCode, 200);
      expect(call.durationMs, isNotNull);
      expect(call.requestHeaders, contains('Bearer ***'));
      expect(call.requestHeaders, isNot(contains('secret-token')));
      expect(call.requestBody, contains('***'));
      expect(call.requestBody, isNot(contains('p@ss')));
      expect(call.responseBody, isNot(contains('jwt')));
    });

    test('records the error code of a failed call and transport failures', () {
      final options = login();
      interceptor
        ..onRequest(options, _RequestHandler())
        ..onError(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 401,
              data: {'errorCode': 'HS-401-0002', 'message': 'Bad credentials'},
            ),
          ),
          _ErrorHandler(),
        );
      final timeout = RequestOptions(
        path: '/slow',
        baseUrl: 'https://api.test',
      );
      interceptor
        ..onRequest(timeout, _RequestHandler())
        ..onError(
          DioException.connectionTimeout(
            requestOptions: timeout,
            timeout: Duration.zero,
          ),
          _ErrorHandler(),
        );

      final failed = store.calls.last;
      expect(failed.statusCode, 401);
      expect(failed.errorCode, 'HS-401-0002');
      expect(failed.isError, isTrue);
      final slow = store.calls.first;
      expect(slow.statusCode, isNull);
      expect(slow.errorMessage, isNotNull);
    });

    test('nothing is recorded without a store (console off)', () {
      final plain = NetworkLogInterceptor(
        logger: Logger(filter: AppLogFilter(enabled: true), output: _Silent()),
      );
      final options = login();
      plain.onRequest(options, _RequestHandler());
      expect(DebugLogStore.instance.calls, isEmpty);
    });
  });

  test('DebugStoreOutput copies the plain message and maps levels', () {
    final store = DebugLogStore();
    Logger(
        filter: AppLogFilter(enabled: true),
        printer: SimplePrinter(colors: false),
        output: DebugStoreOutput(DebugLogSource.bloc, store: store),
      )
      ..e('boom', error: StateError('bad'))
      ..w('careful')
      ..t('noise');

    expect(store.logs.map((l) => l.level), [
      DebugLogLevel.trace,
      DebugLogLevel.warning,
      DebugLogLevel.error,
    ]);
    expect(store.logs.last.message, 'boom\nBad state: bad');
    expect(store.logs.first.source, DebugLogSource.bloc);
  });
}
