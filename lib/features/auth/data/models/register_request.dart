import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

/// Body of `POST /api/v1/auth/register`. [role] is `CUSTOMER` or `WORKER`.
@freezed
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String fullName,
    required String phone,
    required String password,
    required String role,
    @JsonKey(includeIfNull: false) String? email,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
}
