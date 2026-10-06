import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_request.freezed.dart';
part 'refresh_token_request.g.dart';

/// Body of `POST /api/v1/auth/refresh` (`RefreshRequest`). Lives in core because the token
/// refresh runs inside `ApiClient`, which must not depend on `features/auth`.
@freezed
abstract class RefreshTokenRequest with _$RefreshTokenRequest {
  const factory RefreshTokenRequest({required String refreshToken}) = _RefreshTokenRequest;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) => _$RefreshTokenRequestFromJson(json);
}
