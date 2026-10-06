import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_response.freezed.dart';
part 'refresh_token_response.g.dart';

/// `data` of `POST /api/v1/auth/refresh` (`TokenResponse`). Only a new access token comes back —
/// the existing refresh token stays valid and must be kept.
@freezed
abstract class RefreshTokenResponse with _$RefreshTokenResponse {
  const factory RefreshTokenResponse({required String accessToken, String? tokenType, int? expiresIn}) =
      _RefreshTokenResponse;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) => _$RefreshTokenResponseFromJson(json);
}
