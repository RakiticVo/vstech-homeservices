import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

/// Body of `POST /api/v1/auth/register`. Every field is required (docs/reference/api/01-auth-profiles.md);
/// [role] is `CUSTOMER` or `WORKER`.
@freezed
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String fullName,
    required String phone,
    required String password,
    required String role,
    required String email,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
}
