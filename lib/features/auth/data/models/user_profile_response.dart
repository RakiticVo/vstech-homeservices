import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/features/auth/data/models/user_profile_detail_response.dart';
import 'package:vstech_home_services/features/auth/data/models/worker_kyc_response.dart';
import 'package:vstech_home_services/features/auth/data/models/worker_metrics_response.dart';
import 'package:vstech_home_services/features/auth/data/models/worker_skill_response.dart';

part 'user_profile_response.freezed.dart';
part 'user_profile_response.g.dart';

/// `data` of `GET/PUT /api/v1/profiles` (`UserProfileResponse`).
@freezed
abstract class UserProfileResponse with _$UserProfileResponse {
  const factory UserProfileResponse({
    required int id,
    String? identityId,
    String? email,
    String? phoneNumber,
    String? fullName,
    String? avatarUrl,
    String? bio,
    String? role,
    String? verificationStatus,
    double? rating,
    int? totalJobs,
    String? locale,
    bool? isActive,
    String? createdAt,
    UserProfileDetailResponse? userProfile,
    WorkerKycResponse? workerKyc,
    WorkerMetricsResponse? workerMetrics,
    @Default(<WorkerSkillResponse>[]) List<WorkerSkillResponse> workerSkills,
  }) = _UserProfileResponse;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => _$UserProfileResponseFromJson(json);
}
