// A private field name used as a named parameter (`this._tokenStore`) can't be supplied by
// callers outside this file — named-parameter names follow the same privacy rule as any other
// identifier — so the constructor below intentionally uses public param names + an initializer
// list instead of the lint's suggested initializing-formal shorthand.
// ignore_for_file: prefer_initializing_formals

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:vstech_home_services/core/network/auth_token_store.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';

/// Single Dio instance for the whole app. Never instantiate a raw `Dio()` or use the `http`
/// package directly — always go through this (see CLAUDE.md API Contract Rules).
///
/// Attaches the bearer token to every request and performs a single token-refresh retry on 401
/// before giving up and calling `onSessionExpired` (wired to a GoRouter redirect, not a widget
/// check — see CLAUDE.md Authentication rules).
class ApiClient {
  ApiClient({
    required String baseUrl,
    required AuthTokenStore tokenStore,
    required Future<bool> Function() refreshSession,
    required VoidCallback onSessionExpired,
  })  : _tokenStore = tokenStore,
        _refreshSession = refreshSession,
        _onSessionExpired = onSessionExpired,
        dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStore.readAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final isUnauthorized = error.response?.statusCode == 401;
          final alreadyRetried = error.requestOptions.extra['retried'] == true;
          if (isUnauthorized && !alreadyRetried) {
            final refreshed = await _refreshSession();
            if (refreshed) {
              final retryOptions = error.requestOptions..extra['retried'] = true;
              try {
                final response = await dio.fetch<dynamic>(retryOptions);
                return handler.resolve(response);
              } on DioException catch (retryError) {
                return handler.next(retryError);
              }
            }
            await _tokenStore.clear();
            _onSessionExpired();
          }
          handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: true),
      );
    }
  }

  final Dio dio;
  final AuthTokenStore _tokenStore;
  final Future<bool> Function() _refreshSession;
  final VoidCallback _onSessionExpired;

  /// Wraps a request, converting any [DioException] into a [NetworkException].
  Future<Response<T>> guard<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
