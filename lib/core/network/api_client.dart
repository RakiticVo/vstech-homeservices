// Private fields are assigned from public named params (a `this._x` named param can't be passed
// from outside this file), so the initializing-formal lint doesn't apply here.
// ignore_for_file: prefer_initializing_formals

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';
import 'package:vstech_home_services/core/network/models/refresh_token_request.dart';
import 'package:vstech_home_services/core/network/models/refresh_token_response.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/network/network_log_interceptor.dart';
import 'package:vstech_home_services/core/utils/idempotency_key.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

/// Decodes the `data` field of an [ApiResponse].
typedef DataDecoder<T> = T Function(Object? json);

/// Single HTTP entry point for the whole app. Never instantiate a raw `Dio()` or use the `http`
/// package in a feature — always go through this (see CLAUDE.md API Contract Rules).
///
/// - Attaches the bearer token (unless the call is `authenticated: false`).
/// - Adds `X-Idempotency-Key` to calls marked `idempotent: true`; the same key survives the
///   automatic retry after a token refresh.
/// - On 401: one shared refresh via `/auth/refresh` (concurrent 401s wait on the same refresh),
///   then retries once. If refresh fails the tokens are cleared and `onSessionExpired` fires —
///   wired to the session cubit that the GoRouter `redirect` listens to.
/// - Every failure surfaces as a [NetworkException].
class ApiClient {
  ApiClient({
    required String baseUrl,
    required AuthTokenStore tokenStore,
    required VoidCallback onSessionExpired,
    String Function()? languageCode,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 30),
    @visibleForTesting HttpClientAdapter? httpClientAdapter,
  }) : _tokenStore = tokenStore,
       _onSessionExpired = onSessionExpired,
       _languageCode = languageCode,
       dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: connectTimeout,
           receiveTimeout: receiveTimeout,
           contentType: Headers.jsonContentType,
         ),
       ),
       _refreshDio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: connectTimeout,
           receiveTimeout: receiveTimeout,
           contentType: Headers.jsonContentType,
         ),
       ) {
    if (httpClientAdapter != null) {
      dio.httpClientAdapter = httpClientAdapter;
      _refreshDio.httpClientAdapter = httpClientAdapter;
    }
    dio.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onError: _onError));
    if (!kReleaseMode) {
      final logger = NetworkLogInterceptor();
      dio.interceptors.add(logger);
      _refreshDio.interceptors.add(logger);
    }
  }

  static const String idempotencyHeader = 'X-Idempotency-Key';
  static const String _authenticatedExtra = 'authenticated';
  static const String _idempotentExtra = 'idempotent';
  static const String _retriedExtra = 'retried';
  static const String _sentTokenExtra = 'sentToken';

  /// Exposed for edge cases only (e.g. multipart upload). Prefer [get]/[post]/[put]/[delete].
  final Dio dio;
  final Dio _refreshDio;
  final AuthTokenStore _tokenStore;
  final VoidCallback _onSessionExpired;
  final String Function()? _languageCode;

  /// In-flight refresh shared by every request that hit 401 at the same time.
  Future<bool>? _refreshing;

  Future<ApiResponse<T>> get<T>(
    String path, {
    required DataDecoder<T> decode,
    Map<String, dynamic>? query,
    bool authenticated = true,
  }) => _send(path, method: 'GET', decode: decode, query: query, authenticated: authenticated);

  Future<ApiResponse<T>> post<T>(
    String path, {
    required DataDecoder<T> decode,
    Object? body,
    Map<String, dynamic>? query,
    bool authenticated = true,
    bool idempotent = false,
  }) => _send(
    path,
    method: 'POST',
    decode: decode,
    body: body,
    query: query,
    authenticated: authenticated,
    idempotent: idempotent,
  );

  Future<ApiResponse<T>> put<T>(
    String path, {
    required DataDecoder<T> decode,
    Object? body,
    bool authenticated = true,
  }) => _send(path, method: 'PUT', decode: decode, body: body, authenticated: authenticated);

  Future<ApiResponse<T>> delete<T>(
    String path, {
    required DataDecoder<T> decode,
    Map<String, dynamic>? query,
    bool authenticated = true,
  }) => _send(path, method: 'DELETE', decode: decode, query: query, authenticated: authenticated);

  /// For the few endpoints that return a bare body without the [ApiResponse] envelope
  /// (e.g. `POST /api/v1/bookings` → 201). Returns the raw decoded JSON.
  Future<Object?> sendUnwrapped(
    String path, {
    required String method,
    Object? body,
    Map<String, dynamic>? query,
    bool authenticated = true,
    bool idempotent = false,
  }) async {
    final response = await _fetch(
      path,
      method: method,
      body: body,
      query: query,
      authenticated: authenticated,
      idempotent: idempotent,
    );
    return response.data;
  }

  Future<ApiResponse<T>> _send<T>(
    String path, {
    required String method,
    required DataDecoder<T> decode,
    Object? body,
    Map<String, dynamic>? query,
    bool authenticated = true,
    bool idempotent = false,
  }) async {
    final response = await _fetch(
      path,
      method: method,
      body: body,
      query: query,
      authenticated: authenticated,
      idempotent: idempotent,
    );
    final raw = response.data;
    final ApiResponse<T> envelope;
    try {
      envelope = raw is Map<String, dynamic>
          ? ApiResponse<T>.fromJson(raw, decode)
          // 204 / empty body (e.g. DELETE /devices): synthesize an empty success envelope.
          : ApiResponse<T>(
              status: response.statusCode ?? 200,
              message: '',
              data: null,
              errorCode: null,
              timestamp: null,
            );
    } on Object catch (e, st) {
      appLogger.e('Failed to decode $method $path', error: e, stackTrace: st);
      throw NetworkException(kind: NetworkErrorKind.unknown, statusCode: response.statusCode);
    }
    if (!envelope.isSuccess) {
      throw NetworkException(
        kind: NetworkErrorKind.server,
        errorCode: envelope.errorCode,
        statusCode: envelope.status,
        serverMessage: envelope.message,
      );
    }
    return envelope;
  }

  Future<Response<Object?>> _fetch(
    String path, {
    required String method,
    Object? body,
    Map<String, dynamic>? query,
    bool authenticated = true,
    bool idempotent = false,
  }) async {
    try {
      return await dio.request<Object?>(
        path,
        data: body,
        queryParameters: query,
        options: Options(method: method, extra: {_authenticatedExtra: authenticated, _idempotentExtra: idempotent}),
      );
    } on DioException catch (e) {
      final error = e.error;
      if (error is NetworkException) throw error;
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra[_authenticatedExtra] != false) {
      final token = await _tokenStore.readAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
        options.extra[_sentTokenExtra] = token;
      }
    }
    if (options.extra[_idempotentExtra] == true) {
      options.headers.putIfAbsent(idempotencyHeader, IdempotencyKey.generate);
    }
    final language = _languageCode?.call();
    if (language != null) {
      options.headers['Accept-Language'] = language;
    }
    handler.next(options);
  }

  Future<void> _onError(DioException error, ErrorInterceptorHandler handler) async {
    final options = error.requestOptions;
    final shouldRefresh =
        error.response?.statusCode == 401 &&
        options.extra[_authenticatedExtra] != false &&
        options.extra[_retriedExtra] != true;
    if (!shouldRefresh) return handler.next(error);

    // Another request may already have refreshed while this one was in flight — only refresh
    // if the token we sent is still the current one.
    final current = await _tokenStore.readAccessToken();
    final alreadyRefreshed = current != null && current != options.extra[_sentTokenExtra];
    final refreshed = alreadyRefreshed || await _refreshOnce();

    if (!refreshed) {
      await _tokenStore.clear();
      _onSessionExpired();
      return handler.next(error);
    }

    options.extra[_retriedExtra] = true;
    try {
      final response = await dio.fetch<Object?>(options);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return handler.next(retryError);
    }
  }

  Future<bool> _refreshOnce() {
    return _refreshing ??= _refreshAccessToken().whenComplete(() => _refreshing = null);
  }

  Future<bool> _refreshAccessToken() async {
    final refreshToken = await _tokenStore.readRefreshToken();
    if (refreshToken == null) return false;
    try {
      final response = await _refreshDio.post<Map<String, dynamic>>(
        ApiEndpoints.authRefresh,
        data: RefreshTokenRequest(refreshToken: refreshToken).toJson(),
      );
      final body = response.data;
      if (body == null) return false;
      final envelope = ApiResponse<RefreshTokenResponse>.fromJson(
        body,
        (json) => RefreshTokenResponse.fromJson(json! as Map<String, dynamic>),
      );
      final accessToken = envelope.data?.accessToken;
      if (!envelope.isSuccess || accessToken == null) return false;
      // Keep the current refresh token unless the server rotated it.
      await _tokenStore.saveTokens(accessToken: accessToken, refreshToken: envelope.data?.refreshToken ?? refreshToken);
      return true;
    } on Object catch (e) {
      appLogger.w('Token refresh failed', error: e);
      return false;
    }
  }
}
