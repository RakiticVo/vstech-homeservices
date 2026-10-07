import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

/// Colour-coded HTTP logging on [networkLogger] (debug/profile only — added by `ApiClient`).
/// Tokens and passwords are always masked so logs can be shared safely.
class NetworkLogInterceptor extends Interceptor {
  NetworkLogInterceptor({Logger? logger, this.maxBodyLength = 3000}) : _logger = logger ?? networkLogger;

  final Logger _logger;

  /// Longer bodies are cut so one big list response doesn't flood the console.
  final int maxBodyLength;

  static const String _startedAtExtra = 'logStartedAt';

  /// JSON keys whose values are never printed.
  static const Set<String> sensitiveKeys = {'password', 'accessToken', 'refreshToken', 'token'};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAtExtra] = DateTime.now();
    _logger.d(
      [
        '${options.method} ${options.uri}',
        if (options.headers.isNotEmpty) 'Headers: ${_pretty(redactHeaders(options.headers))}',
        ..._requestSection(options),
      ].join('\n'),
    );
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final options = response.requestOptions;
    _logger.i(
      [
        '${response.statusCode} ${options.method} ${options.uri}${_elapsed(options)}',
        ..._requestSection(options),
        ..._responseSection(response.data),
      ].join('\n'),
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final status = err.response?.statusCode;
    final body = err.response?.data;
    final message = [
      '${status ?? err.type.name} ${options.method} ${options.uri}${_elapsed(options)}',
      if (body is Map && body['errorCode'] != null) 'errorCode: ${body['errorCode']} — ${body['message']}',
      ..._requestSection(options),
      ..._responseSection(body),
      if ((body == null || body == '') && err.message != null) 'Error: ${err.message}',
    ].join('\n');
    if (status != null && status < 500) {
      _logger.w(message);
    } else {
      _logger.e(message);
    }
    handler.next(err);
  }

  /// Query + body that were sent, repeated on the response/error entry so each one reads on its own.
  List<String> _requestSection(RequestOptions options) => [
    if (options.queryParameters.isNotEmpty) 'Query: ${_pretty(options.queryParameters)}',
    if (options.data != null) 'Request: ${_pretty(redact(options.data))}',
  ];

  List<String> _responseSection(Object? body) => [if (body != null && body != '') 'Response: ${_pretty(redact(body))}'];

  String _elapsed(RequestOptions options) {
    final startedAt = options.extra[_startedAtExtra];
    return startedAt is DateTime ? ' · ${DateTime.now().difference(startedAt).inMilliseconds}ms' : '';
  }

  String _pretty(Object? data) {
    final text = data is Map || data is List ? const JsonEncoder.withIndent('  ').convert(data) : '$data';
    return text.length <= maxBodyLength ? text : '${text.substring(0, maxBodyLength)}… (${text.length} chars)';
  }

  /// Replaces [sensitiveKeys] anywhere in a JSON-like structure with `***`.
  @visibleForTesting
  static Object? redact(Object? data) => switch (data) {
    final Map<dynamic, dynamic> map => {
      for (final entry in map.entries)
        entry.key: sensitiveKeys.contains(entry.key) && entry.value != null ? '***' : redact(entry.value),
    },
    final List<dynamic> list => [for (final item in list) redact(item)],
    _ => data,
  };

  /// Masks the bearer token while keeping the scheme visible.
  @visibleForTesting
  static Map<String, dynamic> redactHeaders(Map<String, dynamic> headers) => {
    for (final entry in headers.entries)
      entry.key: entry.key.toLowerCase() == 'authorization' ? 'Bearer ***' : entry.value,
  };
}
