import 'package:dio/dio.dart';

/// Typed error wrapper surfaced to BLoC/Cubit state. UI code must never see a raw [DioException]
/// or a raw `HS-XXX-XXXX` code — repositories translate into this before returning a Left/failure.
class NetworkException implements Exception {
  const NetworkException({required this.message, this.errorCode, this.statusCode});

  factory NetworkException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkException(message: 'Kết nối mạng quá chậm, vui lòng thử lại.');
      case DioExceptionType.connectionError:
        return const NetworkException(message: 'Không có kết nối mạng.');
      case DioExceptionType.badResponse:
        return NetworkException(
          message: 'Đã có lỗi xảy ra, vui lòng thử lại.',
          statusCode: e.response?.statusCode,
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return const NetworkException(message: 'Đã có lỗi không xác định xảy ra.');
    }
  }

  /// Localized, user-facing message. Repositories map [errorCode] to this via the catalog in
  /// `docs/reference/api/11-appendices.md`.
  final String message;

  /// Raw `HS-XXX-XXXX` code from the API envelope, if present.
  final String? errorCode;

  final int? statusCode;

  @override
  String toString() => 'NetworkException(errorCode: $errorCode, message: $message)';
}
