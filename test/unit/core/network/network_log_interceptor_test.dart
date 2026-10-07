import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:vstech_home_services/core/network/network_log_interceptor.dart';

/// Captures what the interceptor logs instead of printing it.
class _MemoryOutput extends LogOutput {
  final events = <OutputEvent>[];

  @override
  void output(OutputEvent event) => events.add(event);
}

class _RecordingPrinter extends LogPrinter {
  final messages = <(Level, String)>[];

  @override
  List<String> log(LogEvent event) {
    messages.add((event.level, event.message as String));
    return [event.message as String];
  }
}

// Handlers that swallow the pass-through so no dio future completes (with an error) unobserved.
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

class _AlwaysLog extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}

void main() {
  late _RecordingPrinter printer;
  late NetworkLogInterceptor interceptor;

  setUp(() {
    printer = _RecordingPrinter();
    interceptor = NetworkLogInterceptor(
      logger: Logger(filter: _AlwaysLog(), printer: printer, output: _MemoryOutput()),
    );
  });

  RequestOptions loginOptions() => RequestOptions(
    path: '/api/v1/auth/login',
    baseUrl: 'https://api.test',
    method: 'POST',
    headers: {'Authorization': 'Bearer secret-token', 'X-Idempotency-Key': 'k-1'},
    queryParameters: {'page': 0},
    data: {'identifier': '0901234567', 'password': 'Secret123'},
  );

  test('redact masks sensitive keys at any depth', () {
    expect(
      NetworkLogInterceptor.redact({
        'password': 'p',
        'data': {
          'accessToken': 'a',
          'refreshToken': 'r',
          'user': {'fullName': 'Mai'},
        },
        'items': [
          {'token': 't', 'platform': 'ios'},
        ],
      }),
      {
        'password': '***',
        'data': {
          'accessToken': '***',
          'refreshToken': '***',
          'user': {'fullName': 'Mai'},
        },
        'items': [
          {'token': '***', 'platform': 'ios'},
        ],
      },
    );
  });

  test('redactHeaders masks the bearer token only', () {
    expect(NetworkLogInterceptor.redactHeaders({'Authorization': 'Bearer abc', 'Accept-Language': 'vi'}), {
      'Authorization': 'Bearer ***',
      'Accept-Language': 'vi',
    });
  });

  test('request is logged at debug with masked headers, query and body', () {
    interceptor.onRequest(loginOptions(), _RequestHandler());

    final (level, message) = printer.messages.single;
    expect(level, Level.debug);
    expect(message, contains('POST https://api.test/api/v1/auth/login?page=0'));
    expect(message, contains('Bearer ***'));
    expect(message, contains('Request:'));
    expect(message, contains('"identifier": "0901234567"'));
    expect(message, isNot(contains('secret-token')));
    expect(message, isNot(contains('Secret123')));
  });

  test('success response is logged at info with both request and response', () {
    final options = loginOptions();
    interceptor
      ..onRequest(options, _RequestHandler())
      ..onResponse(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: {
            'status': 200,
            'data': {'accessToken': 'a-1'},
          },
        ),
        _ResponseHandler(),
      );

    final (level, message) = printer.messages.last;
    expect(level, Level.info);
    expect(message, startsWith('200 POST'));
    expect(message, contains('ms'));
    expect(message, contains('Request:'));
    expect(message, contains('Response:'));
    expect(message, isNot(contains('a-1')));
  });

  test('4xx is a warning with the errorCode, 5xx and transport errors are errors', () {
    final options = loginOptions();
    interceptor.onError(
      DioException(
        requestOptions: options,
        response: Response(
          requestOptions: options,
          statusCode: 401,
          data: {'status': 401, 'errorCode': 'HS-401-0002', 'message': 'Sai thông tin'},
        ),
      ),
      _ErrorHandler(),
    );
    expect(printer.messages.last.$1, Level.warning);
    expect(printer.messages.last.$2, contains('errorCode: HS-401-0002'));
    expect(printer.messages.last.$2, contains('Request:'));

    interceptor.onError(
      DioException(
        requestOptions: options,
        response: Response(requestOptions: options, statusCode: 500),
      ),
      _ErrorHandler(),
    );
    expect(printer.messages.last.$1, Level.error);

    interceptor.onError(DioException.connectionError(requestOptions: options, reason: 'offline'), _ErrorHandler());
    expect(printer.messages.last.$1, Level.error);
    expect(printer.messages.last.$2, startsWith('connectionError'));
  });

  test('long bodies are truncated', () {
    NetworkLogInterceptor(
      maxBodyLength: 20,
      logger: Logger(filter: _AlwaysLog(), printer: printer, output: _MemoryOutput()),
    ).onRequest(RequestOptions(path: '/x', data: {'note': 'a' * 100}), _RequestHandler());
    expect(printer.messages.last.$2, contains('chars)'));
  });
}
