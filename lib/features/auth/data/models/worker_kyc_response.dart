import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_kyc_response.freezed.dart';
part 'worker_kyc_response.g.dart';

/// `WorkerKycDTO`.
@freezed
abstract class WorkerKycResponse with _$WorkerKycResponse {
  const factory WorkerKycResponse({
    String? approvalStatus,
    String? idCardNumber,
    String? idCardFrontUrl,
    String? idCardBackUrl,
  }) = _WorkerKycResponse;

  factory WorkerKycResponse.fromJson(Map<String, dynamic> json) => _$WorkerKycResponseFromJson(json);
}
