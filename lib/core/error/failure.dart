import 'package:flutter/foundation.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

/// Client-side business error raised by a repository (not by the server). [code] is a local
/// `APP-…` code that `failureMessage` maps to a localized string, just like `HS-XXX-XXXX` codes.
class AppException implements Exception {
  const AppException(this.code);

  /// An account whose role this app doesn't serve (admin, supplier) tried to sign in.
  static const String unsupportedRole = 'APP-UNSUPPORTED-ROLE';

  final String code;

  @override
  String toString() => 'AppException($code)';
}

/// Domain-level error handed from repositories to Cubits/BLoCs. Carries just enough to pick a
/// localized message (`failure_message.dart`) — never a raw string for the UI.
@immutable
final class Failure {
  const Failure({required this.kind, this.errorCode, this.statusCode});

  /// Converts anything a datasource can throw into a [Failure].
  factory Failure.from(Object error, [StackTrace? stackTrace]) {
    if (error is NetworkException) {
      return Failure(kind: error.kind, errorCode: error.errorCode, statusCode: error.statusCode);
    }
    if (error is AppException) {
      return Failure(kind: NetworkErrorKind.unknown, errorCode: error.code);
    }
    appLogger.e('Unexpected error', error: error, stackTrace: stackTrace);
    return const Failure(kind: NetworkErrorKind.unknown);
  }

  final NetworkErrorKind kind;
  final String? errorCode;
  final int? statusCode;

  bool get isUnauthorized => statusCode == 401;

  @override
  bool operator ==(Object other) =>
      other is Failure && other.kind == kind && other.errorCode == errorCode && other.statusCode == statusCode;

  @override
  int get hashCode => Object.hash(kind, errorCode, statusCode);

  @override
  String toString() => 'Failure(kind: $kind, errorCode: $errorCode, statusCode: $statusCode)';
}
