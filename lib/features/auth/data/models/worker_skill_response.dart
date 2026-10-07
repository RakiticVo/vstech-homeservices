import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_skill_response.freezed.dart';
part 'worker_skill_response.g.dart';

/// `WorkerSkillDTO`.
@freezed
abstract class WorkerSkillResponse with _$WorkerSkillResponse {
  const factory WorkerSkillResponse({int? categoryId, int? experienceYears, String? certificateUrl, bool? isVerified}) =
      _WorkerSkillResponse;

  factory WorkerSkillResponse.fromJson(Map<String, dynamic> json) => _$WorkerSkillResponseFromJson(json);
}
