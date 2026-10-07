import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_response.freezed.dart';
part 'refresh_token_response.g.dart';

/// `data` of `POST /api/v1/auth/refresh` (`TokenResponse`). The OpenAPI spec returns only a new
/// access token while the module doc also returns a rotated [refreshToken] — both are handled.
@freezed
abstract class RefreshTokenResponse with _$RefreshTokenResponse {
  const factory RefreshTokenResponse({
    required String accessToken,
    String? refreshToken,
    String? tokenType,
    int? expiresIn,
  }) = _RefreshTokenResponse;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) => _$RefreshTokenResponseFromJson(json);
}
