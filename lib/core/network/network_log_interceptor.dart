import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:vstech_home_services/core/config/app_env.dart';
import 'package:vstech_home_services/core/debug/debug_log_store.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

/// Colour-coded HTTP logging on [networkLogger] (added by `ApiClient` when logging is enabled),
/// and — with `DEBUG_CONSOLE` on — each call recorded in the [DebugLogStore] for the in-app console.
/// Tokens and passwords are always masked so logs can be shared safely.
class NetworkLogInterceptor extends Interceptor {
  NetworkLogInterceptor({
    Logger? logger,
    DebugLogStore? store,
    this.maxBodyLength = 3000,
  }) : _logger = logger ?? networkLogger,
       _store =
           store ??
           (AppEnv.debugConsoleEnabled ? DebugLogStore.instance : null);

  final Logger _logger;

  /// Null when the debug console is off.
  final DebugLogStore? _store;

  /// Longer bodies are cut so one big list response doesn't flood the console.
  final int maxBodyLength;

  static const String _startedAtExtra = 'logStartedAt';
  static const String _callIdExtra = 'debugCallId';

  /// JSON keys whose values are never printed.
  static const Set<String> sensitiveKeys = {
    'password',
    'accessToken',
    'refreshToken',
    'token',
  };

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAtExtra] = DateTime.now();
    final store = _store;
    if (store != null) {
      options.extra[_callIdExtra] = store.startCall(
        method: options.method,
        url: '${options.uri}',
        requestHeaders: options.headers.isEmpty
            ? null
            : _pretty(redactHeaders(options.headers)),
        requestBody: options.data == null
            ? null
            : _pretty(redact(options.data)),
      );
    }
    _logger.d(
      [
        '${options.method} ${options.uri}',
        if (options.headers.isNotEmpty)
          'Headers: ${_pretty(redactHeaders(options.headers))}',
        ..._requestSection(options),
      ].join('\n'),
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final options = response.requestOptions;
    _logger.i(
      [
        '${response.statusCode} ${options.method} ${options.uri}${_elapsed(options)}',
        ..._requestSection(options),
        ..._responseSection(response.data),
      ].join('\n'),
    );
    _finish(options, statusCode: response.statusCode, body: response.data);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final status = err.response?.statusCode;
    final body = err.response?.data;
    final message = [
      '${status ?? err.type.name} ${options.method} ${options.uri}${_elapsed(options)}',
      if (body is Map && body['errorCode'] != null)
        'errorCode: ${body['errorCode']} — ${body['message']}',
      ..._requestSection(options),
      ..._responseSection(body),
      if ((body == null || body == '') && err.message != null)
        'Error: ${err.message}',
    ].join('\n');
    if (status != null && status < 500) {
      _logger.w(message);
    } else {
      _logger.e(message);
    }
    _finish(
      options,
      statusCode: status,
      body: body,
      errorCode: body is Map ? body['errorCode'] as String? : null,
      errorMessage: status == null ? (err.message ?? err.type.name) : null,
    );
    handler.next(err);
  }

  /// Query + body that were sent, repeated on the response/error entry so each one reads on its own.
  List<String> _requestSection(RequestOptions options) => [
    if (options.queryParameters.isNotEmpty)
      'Query: ${_pretty(options.queryParameters)}',
    if (options.data != null) 'Request: ${_pretty(redact(options.data))}',
  ];

  List<String> _responseSection(Object? body) => [
    if (body != null && body != '') 'Response: ${_pretty(redact(body))}',
  ];

  void _finish(
    RequestOptions options, {
    int? statusCode,
    Object? body,
    String? errorCode,
    String? errorMessage,
  }) {
    final store = _store;
    final id = options.extra[_callIdExtra];
    if (store == null || id is! int) return;
    final startedAt = options.extra[_startedAtExtra];
    store.finishCall(
      id,
      statusCode: statusCode,
      durationMs: startedAt is DateTime
          ? DateTime.now().difference(startedAt).inMilliseconds
          : null,
      responseBody: body == null || body == '' ? null : _pretty(redact(body)),
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  String _elapsed(RequestOptions options) {
    final startedAt = options.extra[_startedAtExtra];
    return startedAt is DateTime
        ? ' · ${DateTime.now().difference(startedAt).inMilliseconds}ms'
        : '';
  }

  String _pretty(Object? data) {
    final text = data is Map || data is List
        ? const JsonEncoder.withIndent('  ').convert(data)
        : '$data';
    return text.length <= maxBodyLength
        ? text
        : '${text.substring(0, maxBodyLength)}… (${text.length} chars)';
  }

  /// Replaces [sensitiveKeys] anywhere in a JSON-like structure with `***`.
  @visibleForTesting
  static Object? redact(Object? data) => switch (data) {
    final Map<dynamic, dynamic> map => {
      for (final entry in map.entries)
        entry.key: sensitiveKeys.contains(entry.key) && entry.value != null
            ? '***'
            : redact(entry.value),
    },
    final List<dynamic> list => [for (final item in list) redact(item)],
    _ => data,
  };

  /// Masks the bearer token while keeping the scheme visible.
  @visibleForTesting
  static Map<String, dynamic> redactHeaders(Map<String, dynamic> headers) => {
    for (final entry in headers.entries)
      entry.key: entry.key.toLowerCase() == 'authorization'
          ? 'Bearer ***'
          : entry.value,
  };
}
