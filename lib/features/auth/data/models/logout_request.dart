import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_request.freezed.dart';
part 'logout_request.g.dart';

/// Body of `POST /api/v1/auth/logout`.
@freezed
abstract class LogoutRequest with _$LogoutRequest {
  const factory LogoutRequest({
    required String refreshToken,
  }) = _LogoutRequest;

  factory LogoutRequest.fromJson(Map<String, dynamic> json) => _$LogoutRequestFromJson(json);
}
