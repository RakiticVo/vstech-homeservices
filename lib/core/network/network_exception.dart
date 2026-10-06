import 'package:dio/dio.dart';

/// Coarse category of a failed request, used to pick a localized message when the server did
/// not send an `HS-XXX-XXXX` code (timeouts, no connectivity, malformed responses...).
enum NetworkErrorKind { timeout, noConnection, server, cancelled, unknown }

/// Typed error thrown by `ApiClient`. Never shown to the user directly — repositories turn it into
/// a `Failure`, and the UI maps that to a localized string (`core/error/failure_message.dart`).
class NetworkException implements Exception {
  const NetworkException({required this.kind, this.errorCode, this.statusCode, this.serverMessage});

  factory NetworkException.fromDioException(DioException e) {
    final envelope = e.response?.data;
    final errorCode = envelope is Map<String, dynamic> ? envelope['errorCode'] as String? : null;
    final serverMessage = envelope is Map<String, dynamic> ? envelope['message'] as String? : null;
    final kind = switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => NetworkErrorKind.timeout,
      DioExceptionType.connectionError => NetworkErrorKind.noConnection,
      DioExceptionType.badResponse => NetworkErrorKind.server,
      DioExceptionType.cancel => NetworkErrorKind.cancelled,
      DioExceptionType.transformTimeout ||
      DioExceptionType.badCertificate ||
      DioExceptionType.unknown => NetworkErrorKind.unknown,
    };
    return NetworkException(
      kind: kind,
      errorCode: errorCode,
      statusCode: e.response?.statusCode,
      serverMessage: serverMessage,
    );
  }

  final NetworkErrorKind kind;

  /// Raw `HS-XXX-XXXX` code from the API envelope, if present.
  final String? errorCode;

  final int? statusCode;

  /// Server-provided `message` — for logs only, never displayed (not localized).
  final String? serverMessage;

  /// 5xx and transport failures are system problems worth reporting; 4xx are client/validation.
  bool get isSystemFailure =>
      kind == NetworkErrorKind.noConnection || kind == NetworkErrorKind.unknown || (statusCode ?? 0) >= 500;

  @override
  String toString() =>
      'NetworkException(kind: $kind, statusCode: $statusCode, errorCode: $errorCode, message: $serverMessage)';
}
